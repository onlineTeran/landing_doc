---
name: promo-landing-framework
description: Plan, design, asset-produce, implement, QA, and release brand-accurate promotional landing pages for CATBET or SlotCity, including same-product promos, embedded pages, and cross-brand traffic bridges. Use when a user asks to create or improve a promo/action landing, prepare its questionnaire or methodology, turn approved campaign mechanics into a responsive design, generate production assets, build the Nuxt/Vue landing, or publish it through explicit approval gates.
---

# Promo Landing Framework

Guide the project through product truth, brand evidence, visual approval, asset freeze, implementation,
QA and release. Treat the current project artifacts as source of truth; do not rely on chat memory.

## Load references

Read [gates.md](references/gates.md) for every new project or phase change.

Read conditionally:

- [product-routing.md](references/product-routing.md) when selecting CATBET/SlotCity or combining brands.
- [artifact-contracts.md](references/artifact-contracts.md) during intake, handoff or status review.
- [review-rubric.md](references/review-rubric.md) before selecting a direction, approving assets or QA.

When the project contains gambling advertising copy, activate the repository-owned
`playcity-copy-review` skill before G2 and again before release. Read the selected brand's Product KB,
Brand Archive snapshot and Tone of Voice; if ToV is pending, do not invent it.

## Route the request

Choose one scope:

1. **Full Track:** new product/GEO/audience/mechanic/host or missing brand/legal evidence.
2. **Fast Track:** known product and audience, approved mechanic/copy, existing host and brand sources.
3. **Phase-only:** user asks for one bounded phase; load prior approved artifacts and do not reopen them
   unless a contradiction blocks the requested phase.

For Fast Track, skip redundant product/GEO/persona questions. Still verify mechanics, claims, CTA route,
brand invariants, integration boundary and deliverables.

## Establish the control surface

Create or update a `PROJECT-STATE.md` containing:

- host brand, destination product and integration mode;
- primary conversion and exact CTA destination;
- current phase/gate;
- owner/status/version links for each artifact;
- open questions, decisions and change requests.

After every material user answer, update the control surface and state the remaining blockers.

## Conduct intake in rounds

Ask at most 5–10 short questions per round:

1. scope/business/deliverables;
2. mechanics/claims/legal;
3. brand/visual evidence/assets;
4. content/story/CTA;
5. responsive/integration/analytics/release.

Do not interrogate the user for facts that a supplied source can answer. Inspect exact Figma nodes, live
pages, approved copy and canonical assets first. Assign every visual reference a role: identity, style,
composition, typography, material, motion, mechanics or legal.

## Lock product and legal truth

Build:

- a Mechanics Model separating trigger, user choice, sequence/tier, reward, condition and time;
- a Claims Matrix with `APPROVED VERBATIM`, `APPROVED EDITABLE`, `PENDING`, `PROHIBITED`, `EXPIRED` and
  `SUPERSEDED` statuses;
- a source precedence order and a campaign-specific do-not-advertise list.

Classify advertiser, advertised brand, host, destination, channel, 21+ treatment and cross-brand legal
relationship before approving copy. Treat legal wording and product truth as a higher layer than campaign
argument and brand Tone of Voice.

Never invent, infer from old artwork, or silently rewrite current numbers, tiers, wager, dates, reward
conditions, legal text or CTA routes. Stop concept work when P0 claims or mechanics remain blocked.

## Lock brand evidence

Load the selected product knowledge and current canonical sources. For a cross-brand landing, create a
Brand Bridge assigning ownership of chrome, background/container, CTA, typography, mascot, asset
material, motion and legal.

Record immutable/adaptable/forbidden rules for every canonical mascot, logo, host character, CTA and
asset family. Never substitute a generic lookalike for a canonical character.

## Design before build

Follow this order:

1. content map and storyboard;
2. exactly three image-based visual directions grounded in captured sources;
3. select one direction using the review rubric;
4. design and approve the Hero, including mobile/video framing;
5. design the full content-only page at 1440, 440, 430 and 375;
6. show a separate context frame with host chrome when embedded;
7. freeze the full design before production asset generation or code.

Do not scaffold, implement components or declare a design ready from prose alone. Do not treat mobile as
a scaled desktop. Do not allow a large logo to compensate for weak product-specific visual language.

## Produce assets

Create an Asset Register before generation. For every asset specify real slot size, reference roles,
identity lock, camera/material/light, alpha/background, safe area, mobile variant, animation layers,
master/delivery format and weight cap.

Use a single approved style-lock asset before generating a family. Save exact prompts, references, mode,
output and correction history. Verify true alpha, edge contamination, optical weight and real-slot
appearance on 1440/440/430/375. Reject raw generations, visible rectangles and style drift.

## Implement the approved target

Use the project's pinned stack; default to Nuxt 3 + Vue 3 + TypeScript + SSG. Keep `app.vue` thin, scope
styles, separate content/actions/legal/analytics config, and omit host chrome from content-only code.

Preserve approved copy, CTA component ownership, asset identity and responsive layouts. Any redesign
during implementation becomes a change request and reopens affected design gates.

## QA with evidence

Run three distinct passes:

1. content/legal truth;
2. visual fidelity using combined same-viewport target/implementation comparisons;
3. technical behavior across 1440/440/430/375 and the analytics-derived top-10 device matrix.

Assert zero missing assets, zero horizontal overflow, no console/hydration errors, correct video ratio,
real CTA routes, reduced-motion behavior, complete legal text and analytics events. Repeat visual
comparison after fixes; a screenshot alone is not QA.

## Release only after approval

Finish all local changes, production build, tests, visual QA, legal/brand/product/analytics approvals and
live-route preparation before publishing. Require an explicit release approval for the exact version and
target. Poll deployment to a terminal result, then verify the public URL without owner-only authentication.

## Capture learning

After release, record late changes, regenerated assets, blockers, design/build mismatches, funnel data and
reusable knowledge. Update CATBET/SlotCity knowledge, templates or this skill instead of leaving the lesson
only in the campaign chat.
