# Контракт генерації арту SlotCity

**Design System version:** `0.9`

## Обов'язковий алгоритм

1. Classify the role: 3D icon, hero, promo, horizontal/vertical/square card, section background or
   decorative cutout.
2. Search canonical components and approved campaign assets for the same meaning.
3. Select one style group; never blend groups without an approved reference.
4. Lock target ratios and content safe zones before prompting.
5. Record the closest evidence reference and its assigned role.
6. Define subject count/placement, palette, materials, camera, light, depth, crop and mobile behavior.
7. Generate art without text, logo, UI, watermark or fabricated brand marks.
8. Validate desktop and mobile separately. Desktop >2:1 sets `mobileRecomposition: true`.
9. If no evidence-backed role fits, return `DESIGN_SYSTEM_GAP`.

## Універсальний prompt для 3D-іконки

```text
Створіть 3D-іконку [OBJECT] у візуальній системі SlotCity. Використайте компактний округлий силует із виразною
volume, medium detail and forms readable at [28–84 | 72–132 | 160–360] px. Use a saturated violet,
magenta and cyan base with one [ACCENT], glossy colored plastic/metal and limited translucent glass.
Використовуйте послідовний фронтальний або м’який 3/4 ракурс із неглибокою перспективою, cyan/magenta rim light,
restrained white highlights, subtle internal glow and a short soft colored shadow. Use one dominant
object or up to three tightly related objects, filling 60–80% without crop. Output [RATIO] with
[transparent | dark navy-violet radial glow] background. Avoid matte clay, natural/photoreal textures,
complex environment, character, thin details, text, long black shadow, pastel/earth colors, deep
isometry, uncontrolled bloom and excessive chrome.
```

## Універсальний prompt для hero/banner

```text
Створіть SlotCity [STYLE_GROUP] [hero | promo] банер із [SUBJECT]. Використайте [1–2 | 1–3 пов’язані]
primary subjects placed on [SIDE] across [55–70 | 40–65]% of the canvas and reserve the opposite
[30–40 | 30–45]% as a dark low-detail safe zone for external heading and CTA. Use a dark navy/violet
base with [CONTROLLED ACCENT], coherent [MATERIALS], eye-level or soft low/three-quarter camera, one
directional key light, restrained colored rim/bloom, soft grounded shadow and [2–3] depth planes.
Залишайте обличчя, руки, приз і визначальні ознаки всередині safe core. Виведіть [DESKTOP RATIO] і
[DEDICATED MOBILE RATIO/COMPOSITION]. Avoid baked text, logos, watermark, UI, random colors,
incompatible materials, duplicate/deformed parts, competing focal points and critical crop.
```

## Універсальний prompt для картки

```text
Створіть SlotCity [STYLE_GROUP] фон для [horizontal | vertical | square] картки з
[SUBJECT]. Use one focal group and reserve [SAFE-ZONE CONTRACT] for external copy. Use dark brand
surfaces, one controlled accent, coherent glossy/cinematic materials, shallow-to-medium depth,
three-quarter camera, directional key, restrained rim glow and contact shadow. Keep the defining
silhouette readable after [CROP CONTRACT]. Output [RATIO]. Avoid text, logo, UI, unrelated props,
high-frequency texture under copy, random colors, harsh glare, excessive bloom and clipped features.
```

## Універсальний prompt для декоративного тла

```text
Створіть декоративний фон SlotCity для [SCENARIO] без головного сюжетного суб’єкта. Використайте одну пов’язану
group of 2–3 related [cyan/ice-blue/lilac | single campaign family] fields near [EDGES/POSITION] on a
dark navy-black base. Keep [40–60]% of the content zone neutral and low contrast. Use contour blur
5–30 px, support glow 50–100 px and main atmosphere 150–250 px; component opacity 20–50%, up to 70%
only for an approved campaign accent. Optionally add one restrained texture, particles, noise or pattern.
Виведіть [RATIO]. Уникайте тексту, логотипів, watermark, UI, впізнаваного суб’єкта позаду copy, рівних hotspots,
rainbow color, dense particles, visible grain, tiling seams, hard banding and uncontrolled bloom.
```

## Негативний список QA

`text, letters, numbers, fake logo, watermark, signature, UI, incompatible color families, accidental
style mixing, multiple equal hotspots, clipped face/hands/prize, duplicate or deformed parts, deep scene
inside a small card, dense particles, visible noise, high-contrast pattern behind content, hard banding,
muddy transitions, bright content-zone center`.

Використовуйте [templates/ART-BRIEF.md](../../templates/ART-BRIEF.md) і
[templates/ART-QA.md](../../templates/ART-QA.md); save exact prompt/settings and correction history.
