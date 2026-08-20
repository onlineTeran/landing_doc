#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 3 ]]; then
  echo "Usage: $0 <project-root> <slotcity|catbet> <codex|claude>" >&2
  exit 64
fi

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_root="$1"
product_name="$(printf '%s' "$2" | tr '[:upper:]' '[:lower:]')"
agent_name="$(printf '%s' "$3" | tr '[:upper:]' '[:lower:]')"

case "$product_name" in
  slotcity|catbet) ;;
  *) echo "Product must be slotcity or catbet." >&2; exit 64 ;;
esac

case "$agent_name" in
  codex|claude) ;;
  *) echo "Agent must be codex or claude." >&2; exit 64 ;;
esac

"$script_dir/init-project-kit.sh" "$project_root" "$product_name"

state_path="$project_root/docs/promo-landing/PROJECT-STATE.md"
state_tmp="$state_path.bootstrap-tmp"
sed "s@^- Operating agent:.*@- Operating agent: $agent_name@" "$state_path" > "$state_tmp"
mv "$state_tmp" "$state_path"

"$script_dir/install-project-skills.sh" "$project_root" "$agent_name"
"$script_dir/install-agent-instructions.sh" "$project_root" "$agent_name"
"$script_dir/verify-project-skills.sh" "$project_root" "$agent_name"

echo "Bootstrap complete. Open docs/promo-landing/PROJECT-STATE.md and SKILL-AUDIT.md."
