#!/usr/bin/env bash
set -euo pipefail

DOMAIN="${1:-}"
if [ -z "$DOMAIN" ]; then
  echo "Usage: $0 example.com"
  exit 1
fi

BASE="https://${DOMAIN}"
TMPDIR="$(mktemp -d)"

cleanup() {
  rm -rf "$TMPDIR"
}
trap cleanup EXIT

echo "== TFWS Fetch + Validate =="
echo "Domain: ${DOMAIN}"
echo "Temp  : ${TMPDIR}"
echo

fetch() {
  local path="$1"
  local out="$2"
  echo "-- Fetch ${path}"
  curl -fsS "${BASE}${path}" -o "${out}"
}

validate_json() {
  local file="$1"
  python - <<PY
import json, sys
p = sys.argv[1]
with open(p, "r", encoding="utf-8") as f:
    json.load(f)
print("OK JSON:", p)
PY
}

echo "== 1) Fetch trust hub =="
HUB="${TMPDIR}/ai-trust-hub.json"
fetch "/.well-known/ai-trust-hub.json" "${HUB}"
validate_json "${HUB}"
echo

echo "== 2) Fetch referenced endpoints (best-effort) =="
KEYS="${TMPDIR}/key-history.json"
LLMS="${TMPDIR}/llms.txt"
ADOPT="${TMPDIR}/tfws-adoption.json"

fetch "/.well-known/key-history.json" "${KEYS}"
validate_json "${KEYS}"

fetch "/.well-known/llms.txt" "${LLMS}"
echo "OK text: ${LLMS}"

# adoption manifest is optional
if curl -fsSI "${BASE}/.well-known/tfws-adoption.json" >/dev/null 2>&1; then
  fetch "/.well-known/tfws-adoption.json" "${ADOPT}"
  validate_json "${ADOPT}"
else
  echo "-- Skip /.well-known/tfws-adoption.json (not present)"
fi
echo

echo "== 3) Quick consistency checks =="
python - <<PY
import json, sys

hub_path = sys.argv[1]
keys_path = sys.argv[2]

with open(hub_path, "r", encoding="utf-8") as f:
    hub = json.load(f)
with open(keys_path, "r", encoding="utf-8") as f:
    keys = json.load(f)

errs = []

# minimal expected fields
for field in ("version", "site", "endpoints"):
    if field not in hub:
        errs.append(f"trust hub missing field: {field}")

# endpoints sanity
eps = hub.get("endpoints", {})
expected = {"llms_txt", "key_history"}
missing = expected - set(eps.keys())
if missing:
    errs.append(f"trust hub endpoints missing: {sorted(missing)}")

# keys sanity
if "keys" not in keys or not isinstance(keys["keys"], list) or len(keys["keys"]) == 0:
    errs.append("key-history.json has no keys[] entries")

if errs:
    print("FAIL:")
    for e in errs:
        print(" -", e)
    raise SystemExit(2)

print("OK: trust hub and key history look structurally sane.")
PY "${HUB}" "${KEYS}"

echo
echo "== Done =="
echo "Next steps:"
echo " - Add signatures (minisign/ed25519) if you use signed artifacts"
echo " - Add schema validation (optional) for tfws-adoption.json"
