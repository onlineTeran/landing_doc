# CATBET Art Generation Contract

**Design System version:** `0.9` · **Status:** `OWNER-SUPPLIED IDENTITY EVIDENCE`; every production
asset still needs campaign-scoped Brand approval.

## 1. Generation is the last option

Search and export canonical assets first. Generate only when the required pose, composition or asset
does not exist and the modification is allowed. Keep a lossless/layered master and a campaign Asset
Register entry with prompt, seed/mode, references by role, correction log, owner and approval.

## 2. Required prompt inputs

```yaml
asset_role: mascot | catbox_reward | furry_icon | furry_glyph | atmosphere | bridge
slot_and_dimensions:
desktop_safe_zone:
mobile_safe_zone:
identity_reference:
style_reference:
composition_reference:
content_source:
allowed_modifications: []
immutable_features: []
material_spec:
camera_and_lens:
lighting_and_shadow:
background_and_alpha:
negative_constraints: []
delivery_variants: []
```

Never use one image ambiguously as identity, style and composition reference. Label each role.

## 3. Prompt skeleton — mascot scene

> Create a CATBET [ASSET ROLE] for [SLOT/SIZE]. Preserve the exact identity from [IDENTITY REF]:
> canonical cyan fur, orange/red eyes, orange collar, face, species cues, natural body shape and
> proportions. Default to no clothing. Only [ALLOWED CHANGES] may vary.
> The cat [ACTION] with [CURRENT PRODUCT OBJECT] in one clear visual metaphor. Use the material,
> camera, lighting and shadow footprint from [STYLE REF], composition from [COMPOSITION REF], and keep
> [COPY/CTA/LEGAL/ANATOMY] safe zones clear. Deliver [MASTER/ALPHA/RESPONSIVE VARIANTS].

Block this prompt when the identity reference, rights or allowed modification matrix is missing.

## 4. Prompt skeleton — CatBox/reward object

> Create/compose the canonical CATBET [CLOSED/OPEN] CatBox for tier [APPROVED TIER] and reward state
> [APPROVED STATE], using [EXACT SOURCE]. Preserve form, label and CATBET material cues. The package
> tier must not visually imply deposit number [N]. Use [CAMERA/LIGHT/SHADOW], true alpha and safe zones
> for [COPY/CTA]. Do not invent rewards, labels, mechanics or additional currencies.

## 5. Prompt skeleton — furry family style lock

> Produce one CATBET furry [ICON/GLYPH] style-lock sample for [ACTUAL SLOT]. Use [APPROVED CYAN/ORANGE
> TOKEN], fiber length [SOURCE VALUE], direction [SOURCE VALUE], density [SOURCE VALUE], camera
> [SOURCE], rim light [SOURCE] and shadow footprint [SOURCE]. Preserve readable silhouette at
> [RENDERED SIZE], true alpha and no rectangular matte. Do not batch the family until this sample is
> approved in context.

Missing source values make this a style-exploration task, not a production asset.

## 6. Default negative constraints

No generic blue cat; no changed face/species/proportions; no muscular anatomy; no clothing by default;
no costume without an explicit narrative role and approval;
no wrong fur hue; no random casino neon; no illegible furry glyph; no invented CatBox tier/reward; no
glossy plastic concrete; no black/white rectangular background; no clipped paws/ears/tail; no copy or
logo baked into the image unless explicitly approved; no visual guarantee for conditional/random value.

## 7. Family QA

Approve one asset in the real section before a batch. Then compare a contact sheet at equal canvas
size and at real rendered sizes for identity, fiber/material, camera, light, shadow, optical weight,
alpha and product truth. Reject drift; do not normalize it with CSS filters.
