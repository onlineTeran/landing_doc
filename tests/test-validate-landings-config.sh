#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
node "$repo_root/scripts/validate-landings-config.mjs" "$repo_root/tests/fixtures/landings-config-valid"
node "$repo_root/scripts/validate-landings-config.mjs" "$repo_root/tests/fixtures/landings-config-valid" --require-dist

if node "$repo_root/scripts/validate-landings-config.mjs" "$repo_root/tests/fixtures/landings-config-invalid"; then
  echo "Expected invalid fixture to fail." >&2
  exit 1
fi

echo "Validator tests passed."
