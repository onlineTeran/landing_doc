# CATBET Token Contract

**Design System version:** `0.9` · **Status:** `SEMANTIC ROLES CONFIRMED / EXACT VALUES PENDING`

Надана власником Brand Bible підтверджує чорні/темні surfaces, cyan і orange CATBET як семантичні identity
roles. This document deliberately does not invent exact hex, font names, radii, shadows or breakpoints;
those values still require extraction from editable source and production verification.

## 1. Source rule

Порядок доказовості: current CATBET variables/styles → approved component properties → current
production → approved campaign reference. Screenshot sampling, SlotCity tokens та AI guesses не є
джерелом токенів. Якщо потрібного значення немає, результат — `DESIGN_SYSTEM_GAP: <family>/<role>`.

## 2. Color families

| Family | Confirmed semantic role | Value in 0.9 | Use rule |
|---|---|---|---|
| `color/brand/cyan/*` | primary CATBET identity/accent | `PENDING` | не замінювати довільним blue |
| `color/brand/orange/*` | secondary identity/semantic emphasis | `PENDING` | не втрачати під суцільним cyan |
| `color/surface/*` | page, section, card and overlay surfaces | `PENDING` | extract modes and elevation relationships |
| `color/text/*` | primary, secondary, inverse, muted, legal | `PENDING` | contrast перевіряється у реальному контексті |
| `color/action/*` | CTA default/hover/pressed/disabled/focus | `PENDING` | same-brand only; cross-brand може бути host-owned |
| `color/status/*` | success, warning, error, info | `PENDING` | не підмінювати brand accents |
| `color/auxiliary/*` | purple/lime/offer-specific colors | `PENDING` | лише з canonical component/asset evidence |

## 3. Typography families

| Family | Roles | Required extraction |
|---|---|---|
| `type/display/*` | hero and campaign headings | family, weight, tracking, line-height, desktop/mobile scales |
| `type/furry/*` | selected art titles and numeric moments | source technique, glyph coverage, export rules, minimum size |
| `type/body/*` | explanations and mechanics | family, weights, line-height, max line length |
| `type/ui/*` | CTA, controls, labels, badges | states, casing, truncation and localization behavior |
| `type/legal/*` | qualifiers, 21+, license/terms | family, minimum size, contrast and immutable rules |

Furry lettering is an asset/effect family, not a replacement for body/UI/legal typography.

## 4. Layout and responsive families

Контракт 0.9 очікує `space/*`, `size/*`, `radius/*`, `border/*`, `shadow/*`, `grid/*`,
`breakpoint/*`, `z/*` and `motion/*` families. Until extracted:

- use the approved CATBET component or campaign-local specification;
- document each temporary value in the implementation decision log;
- do not copy SlotCity values just because both products share a company;
- desktop and mobile hero composition are separate approved layouts, not mechanical scaling;
- safe zones for mascot, reward, copy, CTA and legal must be recorded per asset/viewport.

## 5. Naming and modes

Prefer semantic aliases over raw values: `color/action/primary/default`, not `cyan-500` in product
code. The source import must preserve variable collections, aliases and modes rather than flattening
them. At minimum record `light/dark`, interaction states and campaign/host overrides if they exist.

## 6. Extraction acceptance

Сімейство токенів стає `CONFIRMED` лише за наявності точного source URL/node або variable ID, експортованого
value, mode, semantic role, owner, verification date and usage example. Update
`machine/token-contract.json`, then run visual and contrast QA before marking the family approved.
