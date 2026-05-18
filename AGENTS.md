# AGENTS.md

Guidance for agents working in `marginalia-hub`.

## Project Role

This repo is the package discovery and publishing surface for Marginalia. It hosts the public catalog browser and static
catalog endpoints. It does not install or execute packages; firmware owns installation and runtime behavior.

Related repos:

- `marginalia-sdk` defines manifest schemas and package-building tools.
- `marginalia-registry` stores reviewed package metadata and artifact hashes.
- `marginalia-firmware` consumes catalog entries and installs packages.
- `marginalia-examples` provides reference packages and release artifacts.

## Current Shape

- Static browser lives at `index.html`.
- Vercel serves `public/`, so sync the root page before deployment.
- `public/v1/catalog.json` is a bootstrap catalog snapshot shaped from `marginalia-registry`.
- `vercel.json` keeps catalog responses CORS-readable from firmware.

## Common Commands

```sh
./scripts/sync-public-index.sh
./scripts/check-registry-catalog.sh ../marginalia-registry
vercel deploy . -y
```

Use the relative registry path only after the repos are checked out side by side.

## Guidelines

- Keep catalog JSON compatible with `docs/hub-contract.md`.
- Do not invent package metadata fields without updating `marginalia-sdk` and `marginalia-registry` first.
- Catalog entries must remain source-reviewable: include source URL/ref/path and immutable artifact metadata.
- Firmware verifies archive hashes; do not remove hashes from catalog entries.
- Keep catalog endpoints stable and CORS-readable for device firmware.
- Treat signatures as optional until the firmware and registry enforce them.

