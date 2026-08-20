#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"

required_docs=(
  INDEX.md
  DESIGN-SYSTEM.md
  TOKENS.md
  COMPONENTS.md
  ART-DIRECTION.md
  ART-GENERATION.md
  ASSET-CATALOG.md
  REFERENCE-REGISTER.md
  TONE-OF-VOICE.md
  MASCOT.md
  DESIGN-GAPS.md
)

for brand in SLOTCITY CATBET; do
  brand_root="$repo_root/brand-archive/$brand"
  for file in "${required_docs[@]}"; do
    test -f "$brand_root/$file"
    rg -q '0\.9' "$brand_root/$file"
  done

  while IFS= read -r machine_file; do
    jq -e '.designSystemVersion == "0.9"' "$machine_file" >/dev/null
  done < <(find "$brand_root/machine" -type f -name '*.json' | sort)

  asset_manifest="$brand_root/assets/manifest.json"
  jq -e '.designSystemVersion == "0.9" and (.assets | length > 0)' "$asset_manifest" >/dev/null
  while IFS=$'\t' read -r asset_path expected_sha; do
    full_path="$brand_root/assets/$asset_path"
    test -f "$full_path"
    actual_sha="$(shasum -a 256 "$full_path" | awk '{print $1}')"
    test "$actual_sha" = "$expected_sha"
  done < <(jq -r '.assets[] | [.path, .sha256] | @tsv' "$asset_manifest")
done

test "$(jq '.tokens | length' "$repo_root/brand-archive/SLOTCITY/machine/color-tokens.json")" = "110"
jq -e '.currentDesignSystem.status == "brand-rules-available-editable-tokens-and-components-pending"' \
  "$repo_root/brand-archive/CATBET/machine/source-manifest.json" >/dev/null
test -f "$repo_root/brand-archive/CATBET/BRAND-BIBLE.md"
rg -q 'OWNER-SUPPLIED BRAND EVIDENCE' "$repo_root/brand-archive/CATBET/BRAND-BIBLE.md"
rg -q 'PENDING — USER WILL PROVIDE' "$repo_root/brand-archive/SLOTCITY/TONE-OF-VOICE.md"

echo "Brand archive contracts passed for SlotCity 0.9 and CATBET 0.9."
