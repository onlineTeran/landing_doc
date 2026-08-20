#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 3 ]]; then
  echo "Usage: $0 <project-root> <slotcity|catbet> <codex|claude>" >&2
  exit 64
fi

project_root="$1"
product_name="$(printf '%s' "$2" | tr '[:lower:]' '[:upper:]')"
agent_name="$(printf '%s' "$3" | tr '[:upper:]' '[:lower:]')"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
methodology_root="$(cd "$script_dir/.." && pwd)"
task_root="$project_root/docs/design-task"

case "$product_name" in
  CATBET|SLOTCITY) ;;
  *) echo "Product must be catbet or slotcity." >&2; exit 64 ;;
esac

case "$agent_name" in
  codex) skills_root="$project_root/.agents/skills"; instructions_file="$project_root/AGENTS.md" ;;
  claude) skills_root="$project_root/.claude/skills"; instructions_file="$project_root/CLAUDE.md" ;;
  *) echo "Agent must be codex or claude." >&2; exit 64 ;;
esac

if [[ -e "$task_root/DESIGN-TASK-STATE.md" ]]; then
  echo "Refusing to overwrite existing design task: $task_root" >&2
  exit 73
fi

mkdir -p "$task_root/brand-archive" "$skills_root"
sed \
  -e "s@^- Product:.*@- Product: $product_name@" \
  -e "s@^- Operating agent:.*@- Operating agent: $agent_name@" \
  "$methodology_root/templates/DESIGN-TASK-STATE.md" > "$task_root/DESIGN-TASK-STATE.md"
cp "$methodology_root/templates/ART-BRIEF.md" "$task_root/ART-BRIEF.md"
cp "$methodology_root/templates/ART-QA.md" "$task_root/ART-QA.md"
cp -R "$methodology_root/brand-archive/$product_name" "$task_root/brand-archive/$product_name"

for skill_name in brand-design-base playcity-copy-review; do
  destination="$skills_root/$skill_name"
  if [[ -e "$destination" ]]; then
    echo "Refusing to overwrite installed skill: $destination" >&2
    exit 73
  fi
  cp -R "$methodology_root/skills/$skill_name" "$destination"
done

instructions_block="$methodology_root/templates/BRAND-DESIGN-INSTRUCTIONS.md"
if [[ ! -f "$instructions_file" ]]; then
  cp "$instructions_block" "$instructions_file"
elif rg -q '<!-- brand-design-base:begin -->' "$instructions_file"; then
  echo "Brand design instructions already present in $instructions_file; leaving unchanged."
else
  printf '\n\n' >> "$instructions_file"
  cat "$instructions_block" >> "$instructions_file"
fi

for required in \
  "$task_root/DESIGN-TASK-STATE.md" \
  "$task_root/ART-BRIEF.md" \
  "$task_root/ART-QA.md" \
  "$task_root/brand-archive/$product_name/INDEX.md" \
  "$skills_root/brand-design-base/SKILL.md" \
  "$skills_root/playcity-copy-review/SKILL.md"; do
  if [[ ! -f "$required" ]]; then
    echo "Missing bootstrap output: $required" >&2
    exit 1
  fi
done

echo "Design task bootstrap complete at $task_root"
echo "Open DESIGN-TASK-STATE.md and start at A0 Route."
