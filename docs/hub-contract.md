# Marginalia Hub Contract v1

## Core idea

The hub is the community discovery layer. Firmware downloads packages from it, but firmware remains responsible for
installation, activation, integrity checks, and runtime enforcement.

## Public endpoints

- `GET /v1/catalog`
- `GET /v1/catalog?device=xteink-x4&channel=stable`
- `GET /v1/package/:id`
- `GET /v1/package/:id/download`
- `POST /v1/package/submit`
- `POST /v1/package/verify`

## Catalog responsibilities

`GET /v1/catalog` returns a catalog envelope:

- `schemaVersion`
- `generatedAt`
- `signature`
- `entries`

Each entry should include:

- package id
- package name
- package version
- package kind
- execution class
- target compatibility
- release channel
- source repository, path, and ref
- artifact URL
- artifact format and byte size
- integrity hashes
- optional signature metadata
- deprecation links

The bootstrap repo includes `public/v1/catalog.json` as a community snapshot. The catalog is intentionally source-first:
entries point at reviewed source repositories and immutable release artifacts. Catalog signatures are optional for now.

## Firmware flow

1. firmware fetches a catalog snapshot
2. firmware filters entries by device and chip family
3. firmware fetches the selected `.mpkg.zip` artifact
4. firmware verifies the artifact checksum
5. firmware installs locally
6. firmware activates or queues the package

## Submission flow

1. author uploads package metadata and artifact reference
2. hub validates manifest against the SDK schema
3. hub checks compatibility and integrity
4. hub publishes the release to the chosen channel

## Trust rules

- packages without a valid checksum are rejected
- packages with a mismatched target are rejected
- packages with unsupported schema versions are rejected
- packages can be deprecated or revoked through the catalog
- package source metadata is required so the community can review what produced the artifact
