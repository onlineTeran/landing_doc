#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

allowlist="tests/language-legacy-allowlist.txt"
failed=0
legacy_count=0

while IFS= read -r file; do
  if grep -Eq '[А-Яа-яІіЇїЄєҐґ]' "$file"; then
    continue
  fi

  if grep -Fqx "$file" "$allowlist"; then
    legacy_count=$((legacy_count + 1))
  else
    printf 'ERROR: новий Markdown без українського тексту: %s\n' "$file" >&2
    failed=1
  fi
done < <(find . -type f -name '*.md' -not -path './.git/*' | sort)

while IFS= read -r legacy; do
  [[ -n "$legacy" ]] || continue
  if [[ ! -f "$legacy" ]]; then
    printf 'ERROR: allowlist містить відсутній файл: %s\n' "$legacy" >&2
    failed=1
  elif grep -Eq '[А-Яа-яІіЇїЄєҐґ]' "$legacy"; then
    printf 'ERROR: уже перекладений файл треба прибрати з allowlist: %s\n' "$legacy" >&2
    failed=1
  fi
done < "$allowlist"

if [[ "$legacy_count" -gt 36 ]]; then
  printf 'ERROR: legacy language backlog зріс: %s > 36\n' "$legacy_count" >&2
  failed=1
fi

if [[ "$failed" -ne 0 ]]; then
  exit 1
fi

printf 'Мовна політика пройдена; зафіксований legacy backlog: %s файл(ів).\n' "$legacy_count"
