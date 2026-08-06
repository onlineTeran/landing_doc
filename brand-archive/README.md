# Brand Archive

Brand Archive — канонічний evidence layer між живою дизайн-системою та проєктним Product KB.
Product KB пояснює, **як приймати рішення**; archive фіксує, **де лежить доказ**.

## Структура кожного бренду

```text
<BRAND>/
  INDEX.md               # readiness, owners, change log
  DESIGN-SYSTEM.md       # tokens, components, layout, motion, invariants
  ASSET-CATALOG.md       # asset families і modification rights
  REFERENCE-REGISTER.md  # Figma nodes, URLs, files і роль кожного reference
  TONE-OF-VOICE.md       # підключається після legal/product truth
```

## Archive rules

- Запис без exact file/node/path не є canonical reference.
- `Reference-only` не можна копіювати або видавати за brand asset.
- Невідомі modification rights означають `immutable`.
- Live URL без capture/date не є надійним versioned evidence.
- Бінарні masters не зберігаються випадково у documentation repo: archive містить approved source path,
  owner і checksum/version; delivery-копії належать campaign repo.
- Перед G3 створюється snapshot потрібних записів у Brand Bridge/Asset Register.
- Кожен запис має `last verified`; застарілий запис не проходить Brand Ready.

## Бренди

- [CATBET](CATBET/INDEX.md) — seeded archive на основі BETON × CATBET.
- [SlotCity](SLOTCITY/INDEX.md) — керований onboarding archive без вигаданих правил.
