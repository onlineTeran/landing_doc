#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"
test_root="$(mktemp -d /tmp/landing-framework-bootstrap.XXXXXX)"
trap 'rm -rf "$test_root"' EXIT

for product in slotcity catbet; do
  case "$product" in
    slotcity) product_label="SlotCity"; product_dir="SLOTCITY" ;;
    catbet) product_label="CATBET"; product_dir="CATBET" ;;
  esac

  for agent in codex claude; do
    landing_root="$test_root/landing-$product-$agent"
    design_root="$test_root/design-$product-$agent"
    mkdir -p "$landing_root" "$design_root"

    "$repo_root/scripts/bootstrap-project.sh" "$landing_root" "$product" "$agent" >/dev/null
    rg -q "^- Destination product: $product_label$" \
      "$landing_root/docs/promo-landing/PROJECT-STATE.md"
    rg -q "^- Operating agent: $agent$" "$landing_root/docs/promo-landing/PROJECT-STATE.md"
    test -f "$landing_root/docs/promo-landing/brand-archive/$product_dir/machine/source-manifest.json"

    "$repo_root/scripts/bootstrap-design-task.sh" "$design_root" "$product" "$agent" >/dev/null
    rg -q "^- Product: $product_dir$" "$design_root/docs/design-task/DESIGN-TASK-STATE.md"
    rg -q "^- Operating agent: $agent$" "$design_root/docs/design-task/DESIGN-TASK-STATE.md"
    test -f "$design_root/docs/design-task/brand-archive/$product_dir/machine/source-manifest.json"
  done
done

invalid_root="$test_root/invalid-agent"
mkdir -p "$invalid_root"
if "$repo_root/scripts/bootstrap-project.sh" "$invalid_root" slotcity unknown >/dev/null 2>&1; then
  echo "Invalid agent unexpectedly passed." >&2
  exit 1
fi
test ! -e "$invalid_root/docs/promo-landing"

echo "Bootstrap matrix passed: both products work independently with Codex and Claude."
