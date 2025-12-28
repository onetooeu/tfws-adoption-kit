#!/usr/bin/env bash
set -euo pipefail

DOMAIN="${1:-}"
if [ -z "$DOMAIN" ]; then
  echo "Usage: $0 example.com"
  exit 1
fi

BASE="https://${DOMAIN}"

echo "== TFWS Adoption sanity check =="
echo "Domain: ${DOMAIN}"
echo "Base  : ${BASE}"

check() {
  local path="$1"
  echo
  echo "-- ${path}"
  curl -fsSI "${BASE}${path}" | sed -n '1,15p'
}

check "/.well-known/ai-trust-hub.json"
check "/.well-known/llms.txt"
check "/.well-known/key-history.json"
check "/.well-known/tfws-adoption.json" || true

echo
echo "== Done =="
echo "Tip: If any endpoint fails, ensure it is published at /.well-known/ and publicly reachable."
