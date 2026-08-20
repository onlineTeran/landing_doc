# Artifact contracts

## ART

Required: `ART-BRIEF.md`, evidence table, three concepts or explicit constrained-execution rationale,
selection approval, source/master/delivery paths, prompt provenance and `ART-QA.md`.

Stop when product, slot, identity source, modification rights, style group, safe zone or approver is
missing. Return `DESIGN_SYSTEM_GAP` for missing system evidence.

## PRODUCT_UI

Required: UX brief, user/state flow, loading/empty/error/unauthorized/success model, canonical token and
component map, responsive/accessibility rules, editable design/prototype and handoff acceptance criteria.

Do not use a landing layout as an application behavior spec. A new component needs design-system owner
review and migration impact.

## COMPONENT

Required: problem/semantic role, source library, anatomy, variants, properties, states, token map,
content constraints, accessibility/keyboard/touch behavior, responsive rules, do/don't, migration and
owner approval. Component name alone is not identity; record set/component key.

## AUDIT

Required: exact target/version/viewports, screenshots or source evidence, findings with severity and
affected users, canonical rule, remediation and confidence. Audit status is not approval to mutate.

## Approval record

Every approval contains exact quote, owner, date, artifact/version and scope. Feedback, tool output and
agent scoring are not human approval.
