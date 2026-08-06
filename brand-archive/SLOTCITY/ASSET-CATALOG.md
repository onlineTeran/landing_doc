# SlotCity Asset Catalog

This is the schema for brand onboarding; do not populate with guessed assets.

| Family | Canonical source | Status | Allowed modifications | Master/delivery | QA rule |
|---|---|---|---|---|---|
| Logos | TBD | PENDING | immutable until approved | | clear space/minimum size |
| CTA/UI | TBD | PENDING | no restyling | | states and responsiveness |
| Mascot/characters | TBD | PENDING | immutable until matrix exists | | identity |
| Icons | TBD | PENDING | style-lock required | | optical family weight |
| 3D/illustrations | TBD | PENDING | source-specific | | camera/material/light |
| Promo objects | TBD | PENDING | mechanic-specific | | current product truth |
| Motion assets | TBD | PENDING | contract-specific | | poster/fallback/layers |

Every actual asset uses this metadata schema with SlotCity sources and owners:

```yaml
asset_id:
family:
source_status:
source_url_or_path:
figma_node:
owner:
rights:
allowed_modifications: []
identity_reference:
style_reference:
master_format:
delivery_variants: []
alpha_required:
slot_sizes: []
weight_caps: []
last_verified:
campaigns_used: []
```

Unknown rights mean `IMMUTABLE`.
