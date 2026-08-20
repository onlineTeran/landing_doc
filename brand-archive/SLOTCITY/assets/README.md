# SlotCity Asset Evidence Pack 0.9

These are dated production snapshots used by agents for exact evidence. They are not automatically
canonical masters. See [`../MASCOT.md`](../MASCOT.md) and [`manifest.json`](manifest.json).

| Asset | Role | Evidence class | Default use |
|---|---|---|---|
| `reference/logo-live-2026-08-21.svg` | exact logo layer | `LIVE_SNAPSHOT` | composite unchanged; logo contract still pending |
| `reference/mascot-city-levels-live-2026-08-21.webp` | mascot identity | `LIVE_SNAPSHOT` | identity reference; no inferred modifications |
| `reference/mascot-levels-identity-clean-v0.9.png` | focused mascot identity crop | `DERIVED_IDENTITY_CROP` | preferred identity reference for generation |
| `reference/mascot-relaxed-pose-owner-supplied-v0.9-2026-08-21.png` | relaxed leaning pose | `OWNER_SUPPLIED_BRAND_SOURCE` | pose only; ignore third-party social icons |
| `reference/mascot-relaxed-pose-crop-v0.9.png` | focused relaxed-pose crop | `DERIVED_POSE_CROP` | pose reference only, never identity/source for social marks |
| `reference/city-levels-og-live-2026-08-21.webp` | city environment | `LIVE_SNAPSHOT` | environment/composition reference only |

For generation, prefer the focused crop as `identity` and the full banner or OG only as `environment`.
Store output outside this folder.
