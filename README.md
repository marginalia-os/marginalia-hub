# Marginalia Hub

Catalog, publishing, and discovery hub for Marginalia packages.

This service sits between package authors and the firmware. It does not execute packages.

The current repo includes a static package browser in [`index.html`](./index.html). Serve the repo root over HTTP and
open `/` to browse the bootstrap catalog.

## Responsibilities

- host the public package catalog
- validate package metadata and manifests
- publish signed catalog snapshots
- provide package search and discovery
- serve package artifacts
- support submissions and deprecations

## API contract

See [`docs/hub-contract.md`](./docs/hub-contract.md)

## Bootstrap catalog

`public/v1/catalog.json` is a static unsigned catalog snapshot for early firmware and UI experiments. It uses the same
entry shape as `marginalia-registry`, wrapped in a catalog envelope:

- `schemaVersion`
- `generatedAt`
- `signature`
- `entries`

The bootstrap catalog points at `.mpkg.zip` release assets with real SHA-256 hashes. Production catalogs must also sign
the snapshot.
