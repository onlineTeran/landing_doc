#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <project-root> <codex|claude>" >&2
  exit 64
fi

project_root="$1"
agent_name="$(printf '%s' "$2" | tr '[:upper:]' '[:lower:]')"

case "$agent_name" in
  codex) skills_root="$project_root/.agents/skills"; instructions_file="$project_root/AGENTS.md" ;;
  claude) skills_root="$project_root/.claude/skills"; instructions_file="$project_root/CLAUDE.md" ;;
  *) echo "Agent must be codex or claude." >&2; exit 64 ;;
esac

status=0
for skill_name in promo-landing-framework brand-design-base playcity-copy-review; do
  if [[ -f "$skills_root/$skill_name/SKILL.md" ]]; then
    echo "OK $skills_root/$skill_name/SKILL.md"
  else
    echo "MISSING $skills_root/$skill_name/SKILL.md" >&2
    status=1
  fi
done

if [[ -f "$instructions_file" ]] && rg -q '<!-- promo-landing-framework:begin -->' "$instructions_file"; then
  echo "OK $instructions_file promo landing instructions"
else
  echo "MISSING managed promo landing instructions in $instructions_file" >&2
  status=1
fi

audit_path="$project_root/docs/promo-landing/SKILL-AUDIT.md"
if [[ -f "$audit_path" ]]; then
  echo "OK $audit_path"
else
  echo "MISSING $audit_path" >&2
  status=1
fi

if [[ $status -ne 0 ]]; then
  echo "Project skill bootstrap is incomplete." >&2
  exit 1
fi

echo "Repository-owned skill bootstrap is complete. Review external capability statuses in SKILL-AUDIT.md."
