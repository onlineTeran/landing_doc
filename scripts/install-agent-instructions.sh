#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <project-root> <codex|claude>" >&2
  exit 64
fi

project_root="$1"
agent_name="$(printf '%s' "$2" | tr '[:upper:]' '[:lower:]')"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
methodology_root="$(cd "$script_dir/.." && pwd)"
source_block="$methodology_root/templates/AGENT-INSTRUCTIONS.md"

case "$agent_name" in
  codex) target="$project_root/AGENTS.md" ;;
  claude) target="$project_root/CLAUDE.md" ;;
  *) echo "Agent must be codex or claude." >&2; exit 64 ;;
esac

if [[ ! -f "$target" ]]; then
  cp "$source_block" "$target"
  echo "Created $target with promo landing instructions."
elif rg -q '<!-- promo-landing-framework:begin -->' "$target"; then
  echo "Promo landing instructions already present in $target; leaving unchanged."
else
  printf '\n\n' >> "$target"
  cat "$source_block" >> "$target"
  echo "Appended managed promo landing instructions to $target."
fi
