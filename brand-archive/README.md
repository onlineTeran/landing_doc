# Brand Archive

**Current design-system package version:** `0.9` for both SlotCity and CATBET. Version `0.9` means the
structure is usable by agents, but one or more canonical owner approvals or source layers are still
pending. A later supplied source updates the package through review; it does not silently overwrite 0.9.

Brand Archive — канонічний evidence layer між живою дизайн-системою та проєктним Product KB для
лендінгів, окремих артів, product UI, компонентів і візуальних аудитів.
Product KB пояснює, **як приймати рішення**; archive фіксує, **де лежить доказ**.

## Структура кожного бренду

```text
<BRAND>/
  INDEX.md               # readiness, owners, change log
  DESIGN-SYSTEM.md       # tokens, components, layout, motion, invariants
  ASSET-CATALOG.md       # asset families і modification rights
  REFERENCE-REGISTER.md  # Figma nodes, URLs, files і роль кожного reference
  TONE-OF-VOICE.md       # підключається після legal/product truth
  TOKENS.md              # semantic foundations і responsive roles
  COMPONENTS.md          # component selection, variants, states, restrictions
  ART-DIRECTION.md       # composition/material/camera/light/style groups
  ART-GENERATION.md      # prompt and QA contract
  MASCOT.md              # identity evidence and modification gaps, when applicable
  DESIGN-GAPS.md         # explicit stop conditions
  assets/                # small dated evidence pack + checksums; canonical/ only after owner approval
  machine/               # source manifest and deterministic contracts
```

See [ASSET-EVIDENCE-STANDARD.md](ASSET-EVIDENCE-STANDARD.md) for local reference/master classes,
manifest fields, prompt-role separation and update rules.

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

- [CATBET](CATBET/INDEX.md) — owner-supplied Brand Bible/Lore World `0.9` з окремими gaps точних editable tokens/components.
- [SlotCity](SLOTCITY/INDEX.md) — детально вилучена AI design base; ToV/mascot/logo/motion approval gaps explicit.
- [SlotCity × CATBET bridge evidence](BRIDGES/SLOTCITY-CATBET/README.md) — owner-supplied ensemble reference without merging brand ownership.
