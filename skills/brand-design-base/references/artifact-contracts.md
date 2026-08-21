# Контракти артефактів

## ART

Обов’язково: `ART-BRIEF.md`, таблиця доказів, три концепти або явне обґрунтування constrained execution,
selection approval, source/master/delivery paths, prompt provenance and `ART-QA.md`.

Зупиніться, якщо продукт, слот, identity source, права на зміни, style group, safe zone або approver
missing. Return `DESIGN_SYSTEM_GAP` for missing system evidence.

## PRODUCT_UI

Обов’язково: UX brief, user/state flow, модель loading/empty/error/unauthorized/success, канонічні token і
component map, responsive/accessibility rules, editable design/prototype and handoff acceptance criteria.

Не використовуйте layout лендінгу як специфікацію поведінки застосунку. Новий компонент потребує owner дизайн-системи
review and migration impact.

## COMPONENT

Обов’язково: проблема/semantic role, source library, анатомія, варіанти, властивості, стани, token map,
content constraints, accessibility/keyboard/touch behavior, responsive rules, do/don't, migration and
owner approval. Component name alone is not identity; record set/component key.

## AUDIT

Обов’язково: точний target/version/viewports, screenshots або source evidence, findings із severity та
affected users, canonical rule, remediation and confidence. Audit status is not approval to mutate.

## Запис погодження

Кожне approval містить точну цитату, owner, дату, artifact/version і scope. Feedback, tool output та
agent scoring are not human approval.
