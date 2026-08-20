# SlotCity Art Generation Contract

**Design System version:** `0.9`

## Mandatory algorithm

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

## Universal 3D icon prompt

```text
Create a 3D icon of [OBJECT] in the SlotCity visual system. Use a compact rounded silhouette with thick
volume, medium detail and forms readable at [28–84 | 72–132 | 160–360] px. Use a saturated violet,
magenta and cyan base with one [ACCENT], glossy colored plastic/metal and limited translucent glass.
Use a consistent front or soft three-quarter camera with shallow perspective, cyan/magenta rim light,
restrained white highlights, subtle internal glow and a short soft colored shadow. Use one dominant
object or up to three tightly related objects, filling 60–80% without crop. Output [RATIO] with
[transparent | dark navy-violet radial glow] background. Avoid matte clay, natural/photoreal textures,
complex environment, character, thin details, text, long black shadow, pastel/earth colors, deep
isometry, uncontrolled bloom and excessive chrome.
```

## Universal hero/banner prompt

```text
Create a SlotCity [STYLE_GROUP] [hero | promo] banner featuring [SUBJECT]. Use [1–2 | 1–3 linked]
primary subjects placed on [SIDE] across [55–70 | 40–65]% of the canvas and reserve the opposite
[30–40 | 30–45]% as a dark low-detail safe zone for external heading and CTA. Use a dark navy/violet
base with [CONTROLLED ACCENT], coherent [MATERIALS], eye-level or soft low/three-quarter camera, one
directional key light, restrained colored rim/bloom, soft grounded shadow and [2–3] depth planes.
Keep faces, hands, prize and defining features inside the safe core. Output [DESKTOP RATIO] and
[DEDICATED MOBILE RATIO/COMPOSITION]. Avoid baked text, logos, watermark, UI, random colors,
incompatible materials, duplicate/deformed parts, competing focal points and critical crop.
```

## Universal card prompt

```text
Create a SlotCity [STYLE_GROUP] background for a [horizontal | vertical | square] card featuring
[SUBJECT]. Use one focal group and reserve [SAFE-ZONE CONTRACT] for external copy. Use dark brand
surfaces, one controlled accent, coherent glossy/cinematic materials, shallow-to-medium depth,
three-quarter camera, directional key, restrained rim glow and contact shadow. Keep the defining
silhouette readable after [CROP CONTRACT]. Output [RATIO]. Avoid text, logo, UI, unrelated props,
high-frequency texture under copy, random colors, harsh glare, excessive bloom and clipped features.
```

## Universal decorative background prompt

```text
Create a decorative SlotCity background for [SCENARIO] with no main narrative subject. Use one connected
group of 2–3 related [cyan/ice-blue/lilac | single campaign family] fields near [EDGES/POSITION] on a
dark navy-black base. Keep [40–60]% of the content zone neutral and low contrast. Use contour blur
5–30 px, support glow 50–100 px and main atmosphere 150–250 px; component opacity 20–50%, up to 70%
only for an approved campaign accent. Optionally add one restrained texture, particles, noise or pattern.
Output [RATIO]. Avoid text, logos, watermark, UI, recognizable subject behind copy, equal hotspots,
rainbow color, dense particles, visible grain, tiling seams, hard banding and uncontrolled bloom.
```

## QA negative list

`text, letters, numbers, fake logo, watermark, signature, UI, incompatible color families, accidental
style mixing, multiple equal hotspots, clipped face/hands/prize, duplicate or deformed parts, deep scene
inside a small card, dense particles, visible noise, high-contrast pattern behind content, hard banding,
muddy transitions, bright content-zone center`.

Use [templates/ART-BRIEF.md](../../templates/ART-BRIEF.md) and
[templates/ART-QA.md](../../templates/ART-QA.md); save exact prompt/settings and correction history.
