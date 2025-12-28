# Security Policy

## Supported Versions
This repository is a static toolkit. Security issues typically relate to:
- scripts (`scripts/`)
- example templates that could be misused if copied blindly

We will fix issues in the latest version on `main`.

## Reporting a Vulnerability
If you believe you found a security issue:
- Open a GitHub issue with minimal details, **or**
- Contact the maintainer(s) privately if the issue is sensitive.

## Scope notes
- Do not publish private keys in any `.well-known` file.
- Treat template content as **examples**: replace placeholders and verify your deployment.

## Hard rules
- Never commit secrets (private keys, tokens, credentials).
- Avoid adding telemetry or tracking to scripts.
