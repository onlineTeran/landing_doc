#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

failed=0

while IFS= read -r file; do
  if grep -Eq '[А-Яа-яІіЇїЄєҐґ]' "$file"; then
    continue
  fi

  printf 'ERROR: Markdown без українського тексту: %s\n' "$file" >&2
  failed=1
done < <(find . -type f -name '*.md' -not -path './.git/*' | sort)

if [[ "$failed" -ne 0 ]]; then
  exit 1
fi

printf 'Мовна політика пройдена: усі Markdown-файли містять український human-readable текст.\n'
