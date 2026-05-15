# Marginalia Hub

Catalog, publishing, and discovery hub for Marginalia packages.

This service sits between package authors and the firmware. It does not execute packages.

The current repo includes a static package browser in [`index.html`](./index.html). Serve the repo root over HTTP and
open `/` to browse the bootstrap catalog.

For Vercel, sync the page into `public/` before deploying because Vercel serves that directory as static output:

```sh
./scripts/sync-public-index.sh
vercel deploy . -y
```

`vercel.json` keeps catalog responses CORS-readable from the device-hosted package manager.

## Responsibilities

- host the public package catalog
- validate package metadata and manifests
- expose source repositories and release artifact checksums
- provide package search and discovery
- serve package artifacts
- support submissions and deprecations

## API contract

See [`docs/hub-contract.md`](./docs/hub-contract.md)

## Bootstrap catalog

`public/v1/catalog.json` is a static community catalog snapshot. It uses the same entry shape as
`marginalia-registry`, wrapped in a catalog envelope:

- `schemaVersion`
- `generatedAt`
- `signature`
- `entries`

The bootstrap catalog points at `.mpkg.zip` release assets with real SHA-256 hashes. It also includes source repository
metadata so package entries can be reviewed like an RT-Thread package index. Catalog signatures are intentionally
optional for now; firmware verifies archive hashes before staging downloads.

Check that the published bootstrap catalog still matches the registry source:

```sh
./scripts/check-registry-catalog.sh ../marginalia-registry
```
