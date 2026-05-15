# Marginalia Hub

Catalog, publishing, and discovery hub for Marginalia packages.

This service sits between package authors and the firmware. It does not execute packages.

## Responsibilities

- host the public package catalog
- validate package metadata and manifests
- publish signed catalog snapshots
- provide package search and discovery
- serve package artifacts
- support submissions and deprecations

## API contract

See [`docs/hub-contract.md`](./docs/hub-contract.md)
