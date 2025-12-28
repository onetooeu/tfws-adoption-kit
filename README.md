![Stable](https://img.shields.io/badge/status-stable_v0.1.0-brightgreen)

# TFWS Adoption Kit (onetooeu/tfws-adoption-kit)

Static, self-service toolkit to adopt **Trust-First Web Standard (TFWS v2)** signals on your own domain.

It provides:
- Ready-to-copy **/.well-known** templates
- Platform **guides** (Cloudflare Pages, GitHub Pages, Netlify, nginx)
- Simple **verification scripts**
- A minimal, optional adoption manifest (non-authoritative)

---

## What this is (and is not)

✅ Helps you publish verifiable trust signals **without asking anyone for permission**  
✅ Documentation, templates, and offline checks  
❌ Not a certification authority  
❌ Not a central registry  
❌ No runtime service, no database, no login  

---

## Quickstart

1) Copy templates from `templates/well-known/` into your site’s `/.well-known/`  
2) Replace placeholders (domain, contacts, keys)  
3) Publish your site  
4) Verify:

```bash
bash scripts/verify-domain.sh example.com

