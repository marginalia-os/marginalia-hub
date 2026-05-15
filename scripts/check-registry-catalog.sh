#!/usr/bin/env sh
set -eu

REGISTRY_DIR="${1:-marginalia-registry}"
if [ ! -d "$REGISTRY_DIR" ] && [ -d "../marginalia-registry" ]; then
  REGISTRY_DIR="../marginalia-registry"
fi

if [ ! -f "$REGISTRY_DIR/tools/build_catalog.py" ]; then
  echo "Registry checkout not found: $REGISTRY_DIR" >&2
  exit 1
fi

GENERATED_AT="$(python3 - <<'PY'
import json
from pathlib import Path

catalog = json.loads(Path("public/v1/catalog.json").read_text(encoding="utf-8"))
print(catalog["generatedAt"])
PY
)"

TMP_CATALOG="$(mktemp)"
python3 "$REGISTRY_DIR/tools/build_catalog.py" --generated-at "$GENERATED_AT" --output "$TMP_CATALOG" >/dev/null
diff -u public/v1/catalog.json "$TMP_CATALOG"
rm -f "$TMP_CATALOG"
