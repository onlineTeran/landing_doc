# Міграція документації українською

Мета — прибрати англомовні human-readable документи без втрати технічних контрактів. Нові файли вже
не можуть збільшувати legacy backlog: це контролює `tests/test-language-policy.sh`.

## Поточний стан

- стартовий аудит: 51 English-only Markdown-файл;
- перша хвиля: README hero, cross-brand evidence, Art process, Brand Design skill, agent templates,
  SlotCity mascot/reference package — перекладено;
- legacy backlog після першої хвилі: 36 файлів;
- кінцева ціль: 0 файлів у `tests/language-legacy-allowlist.txt`.

## Порядок наступних хвиль

1. шаблони робочих артефактів і `promo-landing-framework` skill;
2. CATBET та SlotCity Brand Archive;
3. Product KB і audit/migration документація;
4. фінальний terminology/links review та видалення allowlist.

Machine-readable keys, enum/status values, API names, commands і filenames не перекладаються згідно
з [`LANGUAGE-POLICY.md`](LANGUAGE-POLICY.md).
