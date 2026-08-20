# SlotCity Design System

**Version:** `0.9` · **Status:** extracted evidence, pending Brand owner approval and missing layers.

## Brand signature

The supplied system describes SlotCity as a licensed, mobile-oriented iGaming/casino product with
gamification, dark surfaces, modern neon lighting and controlled glass-like depth. The signature is not
«more neon»: it is dark semantic UI, restrained promotional accents, role-based typography, rounded
high-volume objects and disciplined content safe zones.

## Selection order

1. Classify the surface and semantic role.
2. Reuse the live canonical component/variant or approved asset with matching meaning.
3. Resolve tokens and responsive mode; do not select literal values by eye.
4. For art, select exactly one evidence-backed style group.
5. Validate the real slot and mobile separately.
6. If no role fits, return `DESIGN_SYSTEM_GAP`; do not invent a new family.

## Foundations

- Base page/section: near-black `#050508`; core surface ladder begins at `#0B0D11`, `#0E1217`,
  `#12171D`, `#181D25`, `#1A2029`.
- Primary promotional accent: yellow `#FFCE00`; supporting semantic colors include green `#22C55D`,
  blue `#0F97FF`, violet `#B152FF`, pink `#FF3874`, orange `#FF6600`, red `#FF3333`.
- Token families are semantic: `general/bg/*`, `general/text/*`, `general/icon/*`, `general/border/*`.
- Page content typography is selected as context → `landing/*` role → responsive mode → master style.
  Component labels keep component-owned typography.
- All colors are referenced by token; campaign identity comes from approved art/gradient choice, not
  ad-hoc new hex values.

Exact rules: [TOKENS.md](TOKENS.md) and `machine/color-tokens.json`.

## Landing layout system

| Viewport | Content column | Side margin | Vertical stack gap |
|---:|---:|---:|---:|
| 360 | 328 | 16 | 24 |
| 414 | 382 | 16 | 24 |
| 768 | 732 | 18 | 40 |
| 1024 | 912 | 56 | 40 |
| 1440 | 1200 | 120 | 40 |

- One centered content column; only header/footer/full-bleed background art crosses it.
- Blocks are either full width or reading width. Reading width caps at 800 on 1024/1440; below 1024
  all blocks use the full column.
- Hero is first. Campaign body follows. Games/catalogue, when present, is directly before FAQ.
  FAQ/conditions is last content block; SEO text and footer may follow.
- The order is identical across breakpoints.
- Registered/unregistered state changes composition, not layout: registered may add progress/state after
  hero and omits acquisition SEO; anonymous omits personal progress and may include SEO text.
- Maximum observed landing length is 8–9 content blocks, but this is not yet a hard limit.

## Global interaction rules

- Exactly one primary action per block.
- Choose action emphasis by semantic role, never by contrast with campaign art.
- Default tap-target floor is 44 px. A smaller control requires a real density constraint and cannot be
  the main CTA.
- Never hide required information behind hover.
- A disabled action needs a visible adjacent explanation.
- Legal conditions qualifying a deposit/bonus action stay in the same visual context; exact wording and
  binding level remain Legal-owned.

## Content and compliance boundary

- Placeholder strings (`Button`, `Title`, `Subtitle`, generic `Детальніше`) are unfinished content,
  not approved copy.
- Never paraphrase legal copy or derive campaign claims from historic artwork.
- ToV is not present in the source archive. Use product/legal truth and PlayCity review, then block
  brand-voice approval until an owner provides the canonical ToV.

## Known non-equivalences

- Similar rounded controls can be Button chips, Tabs or another component; behavior decides selection.
- Button_fresh is not a style variant of Button; it owns favorite/action semantics.
- Component names can collide across libraries. Identify by source library and set/component key.
- UI icons, expressive 3D icons, hero art and decorative backgrounds are four different families.
