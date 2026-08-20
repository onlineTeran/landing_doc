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

case "$agent_name" in
  codex)
    skills_root="$project_root/.agents/skills"
    ;;
  claude)
    skills_root="$project_root/.claude/skills"
    ;;
  *)
    echo "Agent must be codex or claude." >&2
    exit 64
    ;;
esac

mkdir -p "$skills_root"

for skill_name in promo-landing-framework brand-design-base playcity-copy-review; do
  source_dir="$methodology_root/skills/$skill_name"
  destination="$skills_root/$skill_name"

  if [[ ! -f "$source_dir/SKILL.md" ]]; then
    echo "Missing repository skill: $source_dir" >&2
    exit 66
  fi

  if [[ -e "$destination" ]]; then
    echo "Refusing to overwrite installed skill: $destination" >&2
    exit 73
  fi

  cp -R "$source_dir" "$destination"
done

audit_dir="$project_root/docs/promo-landing"
mkdir -p "$audit_dir"
if [[ -e "$audit_dir/SKILL-AUDIT.md" ]]; then
  echo "Refusing to overwrite skill audit: $audit_dir/SKILL-AUDIT.md" >&2
  exit 73
fi
cp "$methodology_root/templates/SKILL-AUDIT.md" "$audit_dir/SKILL-AUDIT.md"

echo "Installed repository-owned skills for $agent_name in $skills_root"
echo "Complete $audit_dir/SKILL-AUDIT.md before the required gates."
