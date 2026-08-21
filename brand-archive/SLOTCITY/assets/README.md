# Доказовий пакет ассетів SlotCity 0.9

Це датовані production snapshots для точного evidence. Вони не стають canonical masters автоматично.
Дивись [`../MASCOT.md`](../MASCOT.md) і [`manifest.json`](manifest.json).

| Ассет | Роль | Evidence class | Дозволене використання |
|---|---|---|---|
| `reference/logo-live-2026-08-21.svg` | exact logo layer | `LIVE_SNAPSHOT` | композит без змін; logo contract очікується |
| `reference/mascot-city-levels-live-2026-08-21.webp` | identity маскота | `LIVE_SNAPSHOT` | reference без inferred modifications |
| `reference/mascot-levels-identity-clean-v0.9.png` | focused identity crop | `DERIVED_IDENTITY_CROP` | пріоритетний identity reference для generation |
| `reference/mascot-relaxed-pose-owner-supplied-v0.9-2026-08-21.png` | relaxed leaning pose | `OWNER_SUPPLIED_BRAND_SOURCE` | лише pose; ігнорувати third-party social icons |
| `reference/mascot-relaxed-pose-crop-v0.9.png` | focused pose crop | `DERIVED_POSE_CROP` | лише pose, не джерело identity/social marks |

Для generation використовуй focused crop як `identity`, а full banner лише як `environment`.
Output зберігай поза цією папкою. Новий reference додається тільки після file-specific storage consent.
