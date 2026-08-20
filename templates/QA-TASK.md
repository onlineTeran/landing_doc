# QA Task — <campaign> / <version>

## Build under test

- Commit/build:
- Environment and URL:
- Figma target/version:
- Copy/Claims Matrix version:
- Product/brand/asset version:
- Test accounts/data (secure location, never credentials here):

## Scope and risk

- Primary user journey:
- Changed functional IDs:
- Integrations (Smartico/iframe/analytics/other):
- Highest-risk areas:
- Explicit out of scope:

## Acceptance scenarios

| ID | Priority | Preconditions | Steps | Expected result | Viewports/browsers | Evidence | Status/bug |
|---|---|---|---|---|---|---|---|
| QA-001 | P0 | | | | | | TODO |

Required coverage: content/legal, visual fidelity, CTA/navigation, auth/guest, loading/empty/error/success,
analytics deduplication, accessibility, performance, reduced motion, iframe origin/height and top-10 devices.

## Integration-specific checks

For Smartico include: authorized/guest, late token, invalid token, missing whitelist, API timeout, empty
missions, `onUpdate`, opt-in/already-opted-in, claim, logout/user switch and no token/PII in logs.

## Exit criteria

- [ ] P0/P1 scenarios pass or have signed waivers.
- [ ] Zero console/hydration errors, missing assets and horizontal overflow.
- [ ] Final same-viewport visual comparisons are attached.
- [ ] CTA routes and analytics events verified with evidence.
- [ ] Legal/Product/Brand/Design/Technical approvals are linked.
- [ ] QA owner records `APPROVED`, build SHA, date and residual risks.

## Corporate Stage / Production split

### Stage readiness

- [ ] Exact Stage build marker/SHA recorded.
- [ ] Page load, primary function, responsive/GEO matrix, redirects, changed tracking, runtime errors
      and critical integrations pass.
- [ ] QA owner explicitly confirms readiness for Production; Critical/Blocker count is zero.

### Production smoke

- [ ] Public URL, primary UI, CTA redirects, tracking and integrations pass after deploy.
- [ ] Served build marker matches the release immediately and after the documented cache window.
- [ ] Critical/Blocker count is zero, or authorized rollback/hotfix decision is linked.
