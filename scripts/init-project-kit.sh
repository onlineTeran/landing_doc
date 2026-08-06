#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <project-root> <catbet|slotcity>" >&2
  exit 64
fi

project_root="$1"
product_name="$(printf '%s' "$2" | tr '[:upper:]' '[:lower:]')"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
methodology_root="$(cd "$script_dir/.." && pwd)"
destination="$project_root/docs/promo-landing"

case "$product_name" in
  catbet)
    product_file="$methodology_root/products/CATBET.md"
    brand_archive="$methodology_root/brand-archive/CATBET"
    product_filename="CATBET.md"
    brand_directory="CATBET"
    ;;
  slotcity)
    product_file="$methodology_root/products/SLOTCITY.md"
    brand_archive="$methodology_root/brand-archive/SLOTCITY"
    product_filename="SLOTCITY.md"
    brand_directory="SLOTCITY"
    ;;
  *)
    echo "Product must be catbet or slotcity." >&2
    exit 64
    ;;
esac

if [[ -e "$destination" ]]; then
  echo "Refusing to overwrite existing project kit: $destination" >&2
  exit 73
fi

mkdir -p "$destination"
mkdir -p "$destination/products" "$destination/brand-archive"
cp "$methodology_root/templates/PROJECT-STATE.md" "$destination/PROJECT-STATE.md"
cp "$methodology_root/templates/PROJECT-BRIEF.md" "$destination/PROJECT-BRIEF.md"
cp "$methodology_root/templates/CLAIMS-MATRIX.md" "$destination/CLAIMS-MATRIX.md"
cp "$methodology_root/templates/BRAND-BRIDGE.md" "$destination/BRAND-BRIDGE.md"
cp "$methodology_root/templates/STORYBOARD.md" "$destination/STORYBOARD.md"
cp "$methodology_root/templates/ASSET-REGISTER.md" "$destination/ASSET-REGISTER.md"
cp "$methodology_root/templates/ANALYTICS-PLAN.md" "$destination/ANALYTICS-PLAN.md"
cp "$methodology_root/templates/DESIGN-QA.md" "$destination/DESIGN-QA.md"
cp "$product_file" "$destination/products/$product_filename"
cp "$methodology_root/PLAYCITY-COPYWRITING-RULES.md" "$destination/PLAYCITY-COPYWRITING-RULES.md"
cp -R "$brand_archive" "$destination/brand-archive/$brand_directory"

echo "Created promo landing project kit at $destination"
echo "Start with PROJECT-STATE.md, PROJECT-BRIEF.md and the selected product/brand-archive snapshot."
