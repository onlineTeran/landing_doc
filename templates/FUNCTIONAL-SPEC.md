# Functional Specification — <campaign>

## Runtime and delivery

| Item | Decision | Source/version | Owner |
|---|---|---|---|
| Framework/runtime | | `package.json` | |
| Rendering | SSG / SSR / SPA | | |
| Integration mode | embed / iframe / standalone | | |
| Hosting target | | | |
| Browser/device baseline | | | |

## Functional inventory

| ID | User story | Trigger/input | States & errors | Expected result | Analytics ID | Acceptance test | Owner |
|---|---|---|---|---|---|---|---|
| F-001 | | | loading/empty/error/success | | | | |

## CTA and navigation contract

| Action ID | Label source | Destination | iframe/top-level behavior | Auth state | Event | Fallback |
|---|---|---|---|---|---|---|
| | | | | | | |

## Product integrations

For every integration record SDK/API version, environments, owner, secrets boundary, allowlists,
timeouts, retries, offline/guest behavior and a stage evidence link.

### Smartico checklist (use only when applicable)

- [ ] `labelKey`, `brandKey`, script URL and owner recorded for stage/prod; secrets are not committed.
- [ ] iframe auth/token contract and allowed `postMessage` origins documented.
- [ ] `ext_user_id` source, guest behavior and login/logout/reload behavior confirmed.
- [ ] Landing origins are allow-listed in Smartico for stage and production.
- [ ] API readiness, timeout, empty/error states and `onUpdate` behavior specified.
- [ ] Mission opt-in/claim/navigation flows have test data and expected error codes.
- [ ] Analytics, PII rules, reduced-motion/performance impact and cleanup are covered.

Reference: `methodology/SMARTICO-INTEGRATION.md` and `methodology/IFRAME-BRIDGE-INTEGRATION.md`.

## Non-functional requirements

- Performance budgets:
- Accessibility:
- Security/privacy/CSP:
- Localization/timezone:
- Analytics/consent:
- Failure and recovery behavior:

## Definition of Done

- [ ] Every approved design interaction maps to a functional ID.
- [ ] Loading, empty, partial, error, unauthorized and success states are designed and implemented.
- [ ] API/integration assumptions have owner-backed evidence.
- [ ] Automated and manual acceptance tests reference functional IDs.
- [ ] Production build and static delivery contract pass.
