# SlotCity Foundations and Tokens

**Design System version:** `0.9`

## Source and scope

The archive contains 3,078 variable nodes from local and attached libraries. This snapshot publishes
only the 110 local semantic color variables in collection `general` (`Default` mode), because those are
the variables authored for this reference file. Imported primitives remain traceable in the Figma source
but must be resolved against their upstream libraries before reuse.

Machine values: [`machine/color-tokens.json`](machine/color-tokens.json).

## Color roles

| Role family | Intent | Key examples |
|---|---|---|
| `general/bg/*` | page, section, surface, skeleton and translucent status fills | `color-site #050508`, `color-black900 #0B0D11`, `color-yellow500 #FFCE00` |
| `general/text/*` | primary/secondary copy and semantic text | `color-pure1 #FFFFFF`, `color-gray100 #CBCED1`, `color-yellow500 #FFCE00` |
| `general/icon/*` | functional icon hierarchy and semantic icons | white, gray ladder, yellow ladder, green/blue/violet/pink/orange/red |
| `general/border/*` | surfaces, semantic borders and translucent/Smartico strokes | black/gray ladder, semantic solids, `stroke-transp-*`, `smartico-*` |

### Base palette

| Name | Value | Typical role |
|---|---:|---|
| Site/section | `#050508` | full-page and section base |
| Black 900 | `#0B0D11` | darkest component surface/border |
| Black 800 | `#0E1217` | raised surface |
| Black 700 | `#12171D` | card/control surface |
| Black 600 | `#181D25` | border/skeleton surface |
| Black 500 | `#1A2029` | elevated neutral surface |
| Gray 900 | `#25282D` | neutral status/surface |
| Gray 700 | `#3E444C` | strong neutral border/icon |
| Light | `#FAFBFC` | light surface |
| White | `#FFFFFF` | primary text/icon |

### Semantic accents

| Family | 500 | Dark/support | Translucent use |
|---|---:|---:|---:|
| Yellow | `#FFCE00` | `#B79200`, `#E8BB00`, `#FFDE54` | 10/20/30% |
| Green | `#22C55D` | `#188C42` | 10/20/30% |
| Blue | `#0F97FF` | `#0B6BB5` | 20/30% |
| Violet | `#B152FF` | — | 20/30% |
| Pink | `#FF3874` | `#B52852` | 20/30% |
| Orange | `#FF6600` | `#B54800` | 20/30% |
| Red | `#FF3333` | `#B52424` | 10/20/30% |

Tokens with `gradient-*` names in the local `general` collection are color endpoints or translucent
strokes, not complete gradient recipes. Recreate a gradient only from an approved component/art recipe.

## Semantic typography

Selection order: context → semantic role → Desktop/Tablet/Mobile → approved master style. Do not invent
intermediate sizes. Button, Badge, Tabs, Timer, Accordion, Alert and other components retain their own
text styles.

| Role | Allowed master styles | Responsive intent |
|---|---|---|
| `landing/hero/title` | Promo Heading 40/40, 32/32, 18/18 | large/medium desktop; small mobile/compact campaign card |
| `landing/hero/description` | Body Text 16/24, 14/20 | desktop/tablet; mobile/dense banner |
| `landing/section/title` | H2 32/40, Title 20/24, H3 18/24, Title 18/24 | large section → standard → compact/nested/mobile |
| `landing/section/description` | Body Text 16/24, 14/20 | standard → mobile/compact |
| `landing/card/title` | Promo Heading 18/18, Title 18/24, Title 16/22 | campaign card → content card → FAQ/compact |
| `landing/card/description` | Body Text 16/24, 14/20, 12/18 | feature/character → standard → dense compact |
| `landing/meta` | Body Text 12/18 Light or SemiBold | note/legal/helper → short label/badge |
| `landing/action` | Button 18/24, 14/20, 12/16, 10/12 | component-owned large/medium/small/micro |

Observed fonts in the whole archive are mixed because of imported libraries and historic templates.
The dominant rendered families are Geologica and Gilroy, but font licensing and canonical product
ownership are not proven by the archive alone; do not package font binaries until owner confirmation.

## Responsive rule

The hero campaign title moves from 40/40 or 32/32 on desktop to 18/18 on mobile. Body roles preserve
hierarchy by changing the approved mode, container width and line count—not by interpolating arbitrary
font sizes.
