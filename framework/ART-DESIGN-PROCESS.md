# Art Design Process

Isolated art uses a compact gated flow. It may be run independently or as the Asset phase of an
approved landing. Production generation still requires a human-selected concept and exact slot.

## A0 — Route

Create `ART-BRIEF.md`. Lock product, asset role, target placement, dimensions/ratios, desktop/mobile
relationship, deadline, owner and intended delivery. Output: `ROUTED` or blockers.

## A1 — Evidence lock

Load Brand Archive. Assign each reference exactly one role: identity, style, composition, material,
camera/light, color, motion or negative evidence. Record checksum/node/path and rights. If the requested
role or character is absent, return `DESIGN_SYSTEM_GAP`.

## A2 — Creative contract

Select one approved style group and define:

- subject/object count and hierarchy;
- composition, content safe zone and crop tolerance;
- palette via tokens/controlled accents;
- material, camera, light, depth and background;
- immutable identity features;
- forbidden elements and negative prompt;
- dedicated mobile recomposition when required.

Do not blend historical style groups by default.

## A3 — Concept set

Produce exactly three meaningfully different, source-grounded concepts unless the user explicitly asks
for one constrained execution. Keep the same locked message and identity; vary composition or treatment,
not product truth. Label each concept with evidence and risks.

## A4 — Human selection

Record `APPROVED` with owner, date, concept/version and exact scope. Feedback is not approval. No
production family generation before selection.

## A5 — Master production

Create one style-lock master first. Save prompt, model/tool, references, seed/settings when available,
edits and source output. Put copy/logo/UI in editable layout layers unless canonical source requires baked
content. Reuse canonical component/assets before generating substitutes.

## A6 — Variants and delivery

Create only listed variants. Desktop >2:1 requires a dedicated mobile composition unless the selected
brand contract explicitly permits a shared safe core. Preserve masters; optimize delivery separately.

## A7 — Art QA

Complete `ART-QA.md` at real slot size:

1. identity and product correctness;
2. style group, materials, camera/light and palette;
3. subject count, hierarchy, safe zone, crops and mobile recomposition;
4. anatomy/geometry/text/logo/watermark defects;
5. alpha, edge contamination, dimensions, color profile, format and byte budget;
6. same-family consistency and accessible contrast behind external content;
7. owner approval for exact master and delivery set.

An attractive preview is not sufficient evidence.

## A8 — Register and learn

Write the asset into `ASSET-REGISTER.md` with source/master/delivery paths, rights, prompt provenance,
campaigns used, QA evidence and last verified date. Reusable new rules go through design-system owner
review before entering Brand Archive.
