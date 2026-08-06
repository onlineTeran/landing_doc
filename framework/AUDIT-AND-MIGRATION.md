# Audit of v1.10.1 and migration to Framework 2.0

## Executive finding

The previous methodology is technically mature but visually under-constrained. It contains roughly
7,300 lines across 20+ top-level documents, with strong implementation, motion, iframe, analytics and QA
guidance. Its weakest part is the contract between `brief` and `code`: brand evidence, legal status,
cross-brand ownership, visual targets, asset invariants and responsive approval are described as ideas,
not enforced artifacts.

That gap explains why a compliant process can still produce a generic or stylistically incorrect page.

## What v1 already does well

- Explicit phase names and deploy approval.
- Nuxt 3/Vue 3/SSG architecture.
- Content/CTA config patterns.
- Iframe bridge and Smartico integration.
- Motion/reduced-motion discipline.
- Device matrix and runtime assertions.
- GA event specification.
- AI icon technical methodology.
- Decision log, retrospective and methodology versioning.

Framework 2.0 preserves these as the technical library.

## Main gaps

### 1. Brand-neutral guidance used inside brand-specific concept work

The old concept prompts explicitly request brand-neutral token roles and generic subjects. That is useful
for shared code, but harmful when choosing a real CATBET or SlotCity direction. Framework 2.0 separates
neutral technical standards from product-specific visual knowledge and requires real sources at G3.

### 2. No product knowledge split

CATBET and SlotCity had no dedicated canonical files, so every session had to reconstruct mascot, font,
CTA, material and source precedence from chat. Framework 2.0 adds independent Product KBs.

### 3. Textual concept before visual evidence

The old process can approve a prose concept/storyboard without image-based alternatives. Generic layouts
survive because they are not seen until implementation. Framework 2.0 requires three visual directions,
then hero and full responsive design approvals.

### 4. Code starts before full design approval

The old workflow scaffolds and implements Hero/sections after design tokens, but does not require a complete
1440/440/430/375 page. Framework 2.0 makes G7 mandatory and postpones production assets/code.

### 5. Legal is a checklist, not a versioned claim system

The old discovery asks about compliance, but lacks claim-level statuses, source precedence and verbatim
protection. Framework 2.0 adds Claims Matrix and legal freeze.

### 6. Cross-brand ownership is missing

Matching page edges to host chrome is documented, but there is no decision system for host CTA versus
destination typography, mascot, colors and materials. Framework 2.0 adds Brand Bridge.

### 7. Asset methodology is not connected tightly enough to page slots

The icon guide is deep, but the overall workflow does not require slot dimensions, identity/style reference
roles, alpha validation, real-size contact sheets and master/delivery mapping for every asset. Framework 2.0
adds Asset Register and G8 Asset Freeze.

### 8. Questionnaire is universal rather than branching

The old discovery checklist asks audience/GEO/product questions even when the team works inside a known
product with approved content. Framework 2.0 adds Full/Fast Track and round-based conditional questions.

### 9. Skill catalog is tied to a previous Claude setup

Some named skills may not exist or may change. Framework 2.0 defines capability contracts and provides a
portable `$promo-landing-framework` skill plus `$playcity-copy-review`, with Codex/Claude bootstrap.

### 10. Technical decisions dominate the entrypoint

The old README opens with stack and Awwwards-level implementation. Product designers need an entrypoint
that starts with business truth, brand evidence and visual approvals. Framework 2.0 moves technical depth
behind a dedicated layer.

## Migration map

| v1 artifact | Framework 2.0 role |
|---|---|
| LANDING-PROMPT-TEMPLATE | replaced as primary entry by Questionnaire + Project Brief |
| LANDING-WORKFLOW | retained as deep technical runbook; operating gates live in framework/README |
| PHASE-PROMPTS | retained; use only after current gate inputs exist |
| CLAUDE-CODE-SKILLS | retained as historical catalog; capability routing in framework/SKILLS |
| ICON-GENERATION-METHODOLOGY | retained; Asset Register connects it to real slots |
| GA-ANALYTICS-SPEC | retained; framework/ANALYTICS connects events to funnel |
| DEVICE-TEST-MATRIX | retained as canonical runtime source; Technical Standard references it and separates design targets |
| CHECKLISTS | retained; release ownership/evidence added in QA-RELEASE |
| DECISION/RETRO templates | retained; Project State becomes daily control surface |

## Recommended repository cleanup after team trial

Do not delete v1 documents immediately. Run Framework 2.0 on one CATBET and one SlotCity landing, then:

1. mark duplicated v1 sections as `legacy/deep reference`;
2. replace old master prompt with the custom skill entrypoint;
3. move product-agnostic technical docs under `technical/`;
4. keep only one canonical definition of gates, viewports and status vocabulary;
5. add real SlotCity brand evidence and case study;
6. release v2.0.0 after the two-product trial.

## Success criteria for the methodology itself

- Designer reaches G5 without writing code.
- No visual concept is generated without exact brand evidence.
- Product/legal changes after G2 are measured and rare.
- First implementation contains no placeholder art.
- 1440/440/430/375 are approved before build; runtime QA follows the current analytics top-10.
- Asset re-generation count drops because style lock and invariants exist.
- Time from approved full design to public preview decreases.
- Retrospectives update Product KB and skill, not only the campaign repo.
