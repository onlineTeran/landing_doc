# CATBET Asset Evidence Pack 0.9

This pack combines owner-supplied Brand Bible/Lore World boards with dated live/campaign evidence.
The owner-supplied source closes the visual and narrative identity of Bet for methodology `0.9`; it does
not by itself grant external reuse rights or replace editable masters. See [`../MASCOT.md`](../MASCOT.md),
[`../BRAND-BIBLE.md`](../BRAND-BIBLE.md) and [`manifest.json`](manifest.json).

| Asset | Role | Evidence class | Default use |
|---|---|---|---|
| `reference/logo-live-2026-08-21.svg` | exact logo layer | `LIVE_SNAPSHOT` | composite unchanged; contract pending |
| `reference/catbet-brand-bible-owner-supplied-v0.9-2026-08-21.png` | brand core, identity, voice, visual grammar | `OWNER_SUPPLIED_BRAND_SOURCE` | methodology extraction/reference |
| `reference/catbet-lore-world-owner-supplied-v0.9-2026-08-21.png` | lore, formats, artifacts, sound direction | `OWNER_SUPPLIED_BRAND_SOURCE` | methodology extraction/reference |
| `reference/cat-bet-identity-no-clothes-clean-v0.9.png` | clean Bet identity | `DERIVED_IDENTITY_CROP` | default identity reference for generation |
| `reference/cat-bet-relaxed-yarn-pose-live-2026-08-21.png` | relaxed lying pose | `DERIVED_POSE_CROP` | pose only; captured from current promo page |
| `reference/catbet-lore-world-style-v0.9.png` | feline lore/material context | `DERIVED_CONTEXT_CROP` | style/artifacts; ignore baked text |
| `reference/cat-bet-tuxedo-999-campaign-2026-08-21.webp` | кіт Бет identity | `APPROVED_CAMPAIGN / STATUS_REVALIDATION_PENDING` | identity reference; ignore baked copy/value |
| `reference/cat-bet-promo-og-live-2026-08-21.jpg` | natural-cat identity cross-check/yarn narrative | `LIVE_SNAPSHOT` | identity/narrative reference only |

Use only one declared role per file in a prompt. Prefer the clean no-clothes crop for identity; costume
campaigns are not the default. Baked campaign text and numbers are never Product Truth.
