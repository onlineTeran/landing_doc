#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <project-root>" >&2
  exit 64
fi

project_root="$1"
state="$project_root/docs/promo-landing/PROJECT-STATE.md"
kit="$project_root/docs/promo-landing"

if [[ ! -f "$state" ]]; then
  echo "ERROR missing $state" >&2
  exit 1
fi

status=0
seen_open=0
approved_count=0

while IFS='|' read -r _ gate gate_status owner artifact approval_date blockers _; do
  gate="$(printf '%s' "$gate" | xargs)"
  gate_status="$(printf '%s' "$gate_status" | xargs)"
  owner="$(printf '%s' "$owner" | xargs)"
  artifact="$(printf '%s' "$artifact" | xargs)"
  approval_date="$(printf '%s' "$approval_date" | xargs)"
  [[ "$gate" =~ ^G([0-9]|1[0-2])[[:space:]] ]] || continue
  if [[ "$gate_status" == "APPROVED" ]]; then
    approved_count=$((approved_count + 1))
    if [[ $seen_open -eq 1 ]]; then
      echo "ERROR $gate is APPROVED after an earlier non-approved gate" >&2
      status=1
    fi
    if [[ -z "$owner" || -z "$artifact" || -z "$approval_date" ]]; then
      echo "ERROR $gate approval requires owner, artifact/version and approval date" >&2
      status=1
    fi
  else
    seen_open=1
  fi
done < "$state"

required=(PROJECT-STATE.md PROJECT-BRIEF.md CLAIMS-MATRIX.md REFERENCE-AND-MASCOT-BASE.md STORYBOARD.md ASSET-REGISTER.md FUNCTIONAL-SPEC.md QA-TASK.md GIT-DELIVERY.md RELEASE-TASK.md)
for file in "${required[@]}"; do
  if [[ ! -f "$kit/$file" ]]; then
    echo "ERROR missing project artifact $kit/$file" >&2
    status=1
  fi
done

if rg -n '<campaign>|<product>|<agent>' "$state" >/dev/null; then
  echo "ERROR PROJECT-STATE.md still contains unresolved placeholders" >&2
  status=1
fi

if [[ $status -ne 0 ]]; then
  echo "Project workflow validation failed." >&2
  exit 1
fi

echo "OK project kit present; $approved_count consecutive gate(s) approved."
echo "NOTE this structural check does not replace Product/Legal/Brand/Design/QA review."
