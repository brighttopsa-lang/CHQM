#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT_DIR="$ROOT_DIR/dist"
OUT_FILE="$OUT_DIR/chqm_flutter_mvp_files.zip"

mkdir -p "$OUT_DIR"
rm -f "$OUT_FILE"

cd "$ROOT_DIR"
zip -r "$OUT_FILE" \
  analysis_options.yaml \
  pubspec.yaml \
  docs/flutter_training_app_execution_plan_ar.md \
  lib >/dev/null

echo "Bundle created: $OUT_FILE"
