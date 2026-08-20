# SlotCity Asset Catalog

**Design System version:** `0.9`

This catalog records reusable families and modification contracts; it does not copy the 1.58 GB source
archive into the methodology repository.

| Family | Status | Selection / modifications | Delivery QA |
|---|---|---|---|
| Logos | `LIVE SVG SNAPSHOT / CONTRACT PENDING` | exact local SVG may be composited unchanged | clear space, min size and variant owner rules pending |
| Mascot/characters | `LIVE + OWNER-SUPPLIED ENSEMBLE / PASSPORT PENDING` | main and supporting identity references are immutable; new generation needs Brand review | names, identity matrices and owner approval |
| UI vector icons | `EXTERNAL LIVE SOURCE` | reuse component, no expressive 3D substitution | optical size, state, contrast |
| Expressive 3D icons | `EXTRACTED` | semantic variant first; new icon follows locked camera/material/light | transparent/dark variant, 28–360 role size, family consistency |
| Landing hero/promo art | `EXTRACTED` | select one style group; copy/logo/UI separate | desktop/mobile, safe zone, crop/anatomy |
| Card backgrounds | `EXTRACTED` | one focal group, copy remains primary | ratio-specific crop, calm zone |
| Section backgrounds | `EXTRACTED` | no critical subject; edge decoration only | neutral content zone, scalable crops |
| Decorative effects | `EXTRACTED` | one glow group + at most one secondary layer | no hotspots/noise under content |
| Game/provider art | `REFERENCE_ONLY` | third-party source/rights required; do not restyle as brand asset | exact provider asset and legal use |
| Motion | `PENDING` | no canonical timing/easing contract | poster/fallback/reduced motion pending |

## 3D library evidence

The authored guide reports a 172-variant `3D Icon` family; decoded attached-library copies expose 198
unique labels, so the current upstream set must resolve the drift. Observed names include rewards and finance (Gift Red,
Trophy, Wallet, Coins, Chips, Dice, Medal), support/status (24/7, Chat, Settings, Verification), gaming
and responsibility (Roulette, Gamepad, Responsible_gaming, Deposit_limit, Daily/Weekly game limit), and
campaign/frozen variants. Variant names are discovery aids—not permission to export or modify without
the current source component and rights check.

## Asset record schema

```yaml
asset_id:
product: slotcity
family:
semantic_role:
style_group:
source_status:
source_url_or_path:
figma_file_version:
figma_node_or_component_key:
owner:
rights:
identity_lock: []
allowed_modifications: []
forbidden_modifications: []
master_format:
delivery_variants: []
alpha_required:
slot_sizes: []
safe_zone:
crop_tolerance:
mobile_strategy:
weight_caps: []
prompt_log:
qa_evidence:
last_verified:
campaigns_used: []
```

Unknown rights mean `IMMUTABLE`. Any newly generated family begins with one approved style-lock asset.

Local evidence files and checksums: [`assets/README.md`](assets/README.md) and
[`assets/manifest.json`](assets/manifest.json). These snapshots do not promote themselves to canonical.
