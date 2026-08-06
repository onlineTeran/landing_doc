# CATBET Asset Catalog

`Source status`: `CANONICAL | APPROVED CAMPAIGN | REFERENCE-ONLY | GENERATED MASTER | RETIRED`.
`Modification`: `IMMUTABLE | CROP | RECOLOR | DRESS | POSE | ANIMATE | REGENERATE` — only explicitly
approved values apply.

| Family | Source status | Default modification | Master/delivery expectation | Principal QA |
|---|---|---|---|---|
| CAT mascot | CANONICAL source required | IMMUTABLE; adaptation by approval | layered/hi-res master; transparent WebP/PNG delivery | face/body/color identity |
| CatBox closed tiers | CANONICAL | CROP/ANIMATE if approved | transparent master + responsive delivery | label/tier/mechanic correctness |
| CatBox open tiers | CANONICAL | CROP/ANIMATE if approved | transparent master + responsive delivery | open state and reward semantics |
| Furry utility icons | CANONICAL family | REGENERATE only from style lock | alpha master; WebP preferred | fiber/camera/light/weight consistency |
| Furry numbers/letters | CANONICAL treatment | compose approved glyphs | alpha/raster or approved font/effect | mobile readability and exact glyph |
| Bonus icons | CANONICAL family | immutable unless owner says otherwise | source export + optimized delivery | reward identity and no rectangular matte |
| Paw/fish/yarn/duck | CANONICAL vocabulary | pose/crop by approval | transparent master + WebP | decorative, not misleading |
| Mission icons/art | campaign source | immutable unless campaign owner approves | transparent source export | current mission/reward/value |
| Host bridge materials | host-owned | Brand Bridge decides | campaign-local | does not become CATBET canonical |

## Required metadata per actual asset

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

## Production policy

1. Export canonical asset before asking AI to recreate it.
2. If generation is needed, use identity reference and separate style/composition references.
3. Approve one style-lock asset in a real section before producing the family.
4. Preserve true alpha. A black/white rectangular matte is a failed delivery.
5. Keep lossless/layered master; deliver compressed transparent WebP unless integration explicitly
   requires PNG. Legal/technical owner may require both.
6. Compare contact sheet at equal canvas size and at actual rendered sizes.
7. Store prompt, reference roles, generation mode and correction log in the campaign Asset Register.
