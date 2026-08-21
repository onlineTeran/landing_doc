# Контракт генерації арту CATBET

**Design System version:** `0.9` · **Status:** `OWNER-SUPPLIED IDENTITY EVIDENCE`; every production
asset still needs campaign-scoped Brand approval.

## 1. Генерація — останній варіант

Спочатку знайдіть і експортуйте канонічні асети. Генеруйте лише тоді, коли потрібна поза, композиція або асет
does not exist and the modification is allowed. Keep a lossless/layered master and a campaign Asset
Register entry with prompt, seed/mode, references by role, correction log, owner and approval.

## 2. Обов'язкові вхідні дані prompt

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

Ніколи не використовуйте одне зображення одночасно як identity, style і composition reference. Позначайте кожну роль.

## 3. Каркас prompt — сцена з маскотом

> Create a CATBET [ASSET ROLE] for [SLOT/SIZE]. Preserve the exact identity from [IDENTITY REF]:
> canonical cyan fur, orange/red eyes, orange collar, face, species cues, natural body shape and
> proportions. Default to no clothing. Only [ALLOWED CHANGES] may vary.
> The cat [ACTION] with [CURRENT PRODUCT OBJECT] in one clear visual metaphor. Use the material,
> camera, lighting and shadow footprint from [STYLE REF], composition from [COMPOSITION REF], and keep
> [COPY/CTA/LEGAL/ANATOMY] safe zones clear. Deliver [MASTER/ALPHA/RESPONSIVE VARIANTS].

Блокуйте цей prompt, якщо немає identity reference, прав або матриці дозволених змін.

## 4. Каркас prompt — CatBox або reward object

> Create/compose the canonical CATBET [CLOSED/OPEN] CatBox for tier [APPROVED TIER] and reward state
> [APPROVED STATE], using [EXACT SOURCE]. Preserve form, label and CATBET material cues. The package
> tier must not visually imply deposit number [N]. Use [CAMERA/LIGHT/SHADOW], true alpha and safe zones
> for [COPY/CTA]. Do not invent rewards, labels, mechanics or additional currencies.

## 5. Каркас prompt — фіксація furry-стилю сімейства

> Produce one CATBET furry [ICON/GLYPH] style-lock sample for [ACTUAL SLOT]. Use [APPROVED CYAN/ORANGE
> TOKEN], fiber length [SOURCE VALUE], direction [SOURCE VALUE], density [SOURCE VALUE], camera
> [SOURCE], rim light [SOURCE] and shadow footprint [SOURCE]. Preserve readable silhouette at
> [RENDERED SIZE], true alpha and no rectangular matte. Do not batch the family until this sample is
> approved in context.

Відсутні значення джерела роблять задачу style exploration, а не виробництвом production-асета.

## 6. Базові негативні обмеження

Без типового синього кота; без зміни обличчя/виду/пропорцій; без м’язистої анатомії; за замовчуванням без одягу;
no costume without an explicit narrative role and approval;
no wrong fur hue; no random casino neon; no illegible furry glyph; no invented CatBox tier/reward; no
glossy plastic concrete; no black/white rectangular background; no clipped paws/ears/tail; no copy or
logo baked into the image unless explicitly approved; no visual guarantee for conditional/random value.

## 7. QA сімейства

До batch погодьте один асет у реальній секції. Потім порівняйте contact sheet на однаковому canvas
size and at real rendered sizes for identity, fiber/material, camera, light, shadow, optical weight,
alpha and product truth. Reject drift; do not normalize it with CSS filters.
