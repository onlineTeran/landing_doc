#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 3 ]]; then
  echo "Usage: $0 <project-root> <catbet|slotcity> <codex|claude>" >&2
  exit 64
fi

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$script_dir/init-project-kit.sh" "$1" "$2"
"$script_dir/install-project-skills.sh" "$1" "$3"
"$script_dir/verify-project-skills.sh" "$1" "$3"

echo "Bootstrap complete. Open docs/promo-landing/PROJECT-STATE.md and SKILL-AUDIT.md."
