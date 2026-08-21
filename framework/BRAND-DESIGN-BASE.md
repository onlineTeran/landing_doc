# Brand Design Base

Brand Design Base — versioned evidence layer для будь-якого візуального завдання: лендінгу, окремого
арту, product UI, component work або design audit. Він не є moodboard і не дозволяє AI домальовувати
прогалини «за стилем казино».

## Source precedence

1. Approved живий component/token у canonical design system.
2. Brand Archive snapshot із exact source checksum/node/version.
3. Approved production asset із відомими rights і campaign context.
4. Dated live production capture.
5. Reference-only evidence — лише для названої ролі.

Нижчий рівень не переписує вищий. Назва компонента без library key/set key не ідентифікує компонент.

## Reference admission

Надане, відкрите або згенероване зображення доступне лише для поточної задачі. Воно не стає частиною
Brand Design Base автоматично. Перед кожним додаванням original/crop/derivative агент окремо називає
точний файл, бренд, evidence role і target path та отримує явне storage consent користувача. Дозвіл
фіксується дослівно в manifest; без нього заборонені copy/download/crop/register/commit у Brand Archive.

## Шари бази

| Layer | Що зберігає | Обов'язковий anti-invention rule |
|---|---|---|
| Product truth | механіка, audience, host/destination, інтеграції | не виводити з арту |
| Identity | logo, mascot/character, immutable features | unknown rights = immutable |
| Foundations | color, typography, spacing, radius, breakpoints | token/role before literal value |
| Components | variants, states, properties, semantics | reuse before generation |
| Art direction | composition, materials, camera, light, crop, style groups | one evidence group per asset |
| Content voice | ToV, CTA vocabulary, legal relationship | `PENDING` не заповнюється AI |
| Delivery | formats, ratios, alpha, weight, safe zones | verify in real slot |
| Provenance | source, checksum/node, owner, date, status | chat memory is not evidence |

## Evidence statuses

- `CANONICAL`: current approved source of truth.
- `CONFIRMED`: repeated, measured production pattern.
- `LIKELY`: strong inference requiring review before system-wide reuse.
- `HYPOTHESIS`: exploration only; never silently promoted to rule.
- `REFERENCE_ONLY`: may guide its assigned role, never becomes a reusable asset.
- `PENDING`: missing source or owner.
- `SUPERSEDED`: retained for history, forbidden for new output.

## Product package contract

Each `brand-archive/<PRODUCT>/` should contain:

```text
INDEX.md
DESIGN-SYSTEM.md
TOKENS.md
COMPONENTS.md
ART-DIRECTION.md
ART-GENERATION.md
ASSET-CATALOG.md
REFERENCE-REGISTER.md
TONE-OF-VOICE.md
MASCOT.md              # when a mascot/character exists
BRAND-BIBLE.md          # when owner-supplied brand principles exist
DESIGN-GAPS.md
assets/
  README.md
  manifest.json
  reference/
machine/
  source-manifest.json
  token or extracted color/typography contracts
  identity contract when mascot/character exists
  art-contract.json
```

An extracted package may store full `color-tokens.json` and `typography-roles.json`; a partial
package stores a `token-contract.json` with pending values so an agent cannot mistake guesses for
tokens. Machine files support selection and validation; Markdown explains intent, precedence and known gaps.
Neither format replaces owner approval.

## Request protocol

Every design request must state or derive without guessing:

- product and primary surface;
- target slot, dimensions/aspect ratio, viewports and delivery format;
- user goal and content hierarchy;
- selected canonical sources and evidence status;
- identity lock and allowed modifications;
- selected semantic role/component/style group;
- responsive/crop behavior;
- legal/copy status;
- QA criteria and approvers.

Use [templates/ART-BRIEF.md](../templates/ART-BRIEF.md) for art and the landing project kit for
landing work. Unknown required values become blockers, not creative freedom.
