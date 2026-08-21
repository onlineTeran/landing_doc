# Задача для QA — <campaign> / <version>

## Build для тестування

- Commit/build:
- Environment and URL:
- Figma target/version:
- Copy/Claims Matrix version:
- Product/brand/asset version:
- Test accounts/data (secure location, never credentials here):

## Scope і ризики

- Primary user journey:
- Changed functional IDs:
- Integrations (Smartico/iframe/analytics/other):
- Highest-risk areas:
- Explicit out of scope:

## Сценарії приймання

| ID | Priority | Preconditions | Steps | Expected result | Viewports/browsers | Evidence | Status/bug |
|---|---|---|---|---|---|---|---|
| QA-001 | P0 | | | | | | TODO |

Обов'язкове покриття: content/legal, visual fidelity, CTA/navigation, auth/guest, loading/empty/error/success,
analytics deduplication, accessibility, performance, reduced motion, iframe origin/height і top-10 devices.

## Перевірки інтеграцій

Для Smartico додайте: authorized/guest, прострочений token, invalid token, відсутній whitelist, API timeout, empty
missions, `onUpdate`, opt-in/already-opted-in, claim, logout/user switch and no token/PII in logs.

## Критерії виходу

- [ ] P0/P1 scenarios pass or have signed waivers.
- [ ] Zero console/hydration errors, missing assets and horizontal overflow.
- [ ] Final same-viewport visual comparisons are attached.
- [ ] CTA routes and analytics events verified with evidence.
- [ ] Legal/Product/Brand/Design/Technical approvals are linked.
- [ ] QA owner records `APPROVED`, build SHA, date and residual risks.

## Розділення корпоративних Stage / Production

### Stage readiness

- [ ] Exact Stage build marker/SHA recorded.
- [ ] Page load, primary function, responsive/GEO matrix, redirects, changed tracking, runtime errors
      and critical integrations pass.
- [ ] QA owner explicitly confirms readiness for Production; Critical/Blocker count is zero.

### Production smoke

- [ ] Public URL, primary UI, CTA redirects, tracking and integrations pass after deploy.
- [ ] Served build marker matches the release immediately and after the documented cache window.
- [ ] Critical/Blocker count is zero, or authorized rollback/hotfix decision is linked.
