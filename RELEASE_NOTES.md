# TFWS Adoption Kit — Release v0.1.0

This is the **initial public release** of the TFWS Adoption Kit.

The kit provides a **static, self-service toolkit** for adopting
Trust-First Web Standard (TFWS v2) signals on any domain.

No registration.  
No approval.  
No central authority.

---

## Included in this release

### Core templates (`/.well-known`)
- `llms.txt`
- `ai-trust-hub.json`
- `key-history.json`
- `tfws-adoption.json` (optional)

### Validation scripts
- `scripts/verify-domain.sh`
- `scripts/fetch-and-validate.sh`

### Schemas
- `schemas/tfws-adoption.schema.json`

### Documentation
- `README.md`
- `CHANGELOG.md`
- `GOVERNANCE.md`
- `SECURITY.md`
- `guides/quickstart.md`

### Platform guides
- Cloudflare Pages
- GitHub Pages
- Netlify
- nginx

---

## Design principles

- Trust is **published**, not granted
- Adoption is **self-declared and verifiable**
- No runtime services
- No tracking or telemetry
- No certification authority
- Fully static and mirror-friendly

---

## Compatibility

- TFWS v2
- onetoo.eu-compatible trust layout
- Works with any static hosting or standard web server

---

## License

CC0 / Public Domain  
Free to copy, fork, mirror, or embed without restriction.

---

## Status

**Stable.**  
Future changes, if any, will preserve backward compatibility.

