# Функціональна специфікація — <campaign>

## Runtime і delivery

| Item | Decision | Source/version | Owner |
|---|---|---|---|
| Framework/runtime | | `package.json` | |
| Rendering | SSG / SSR / SPA | | |
| Integration mode | embed / iframe / standalone | | |
| Hosting target | | | |
| Browser/device baseline | | | |

## Реєстр функціональності

| ID | User story | Trigger/input | States & errors | Expected result | Analytics ID | Acceptance test | Owner |
|---|---|---|---|---|---|---|---|
| F-001 | | | loading/empty/error/success | | | | |

## Контракт CTA і навігації

| Action ID | Label source | Destination | iframe/top-level behavior | Auth state | Event | Fallback |
|---|---|---|---|---|---|---|
| | | | | | | |

## Продуктові інтеграції

Для кожної інтеграції зафіксуй SDK/API version, environments, owner, межу secrets, allowlists,
timeouts, retries, offline/guest behavior і посилання на stage evidence.

### Чекліст Smartico (лише коли застосовно)

- [ ] `labelKey`, `brandKey`, script URL and owner recorded for stage/prod; secrets are not committed.
- [ ] iframe auth/token contract and allowed `postMessage` origins documented.
- [ ] `ext_user_id` source, guest behavior and login/logout/reload behavior confirmed.
- [ ] Landing origins are allow-listed in Smartico for stage and production.
- [ ] API readiness, timeout, empty/error states and `onUpdate` behavior specified.
- [ ] Mission opt-in/claim/navigation flows have test data and expected error codes.
- [ ] Analytics, PII rules, reduced-motion/performance impact and cleanup are covered.

Довідка: `methodology/SMARTICO-INTEGRATION.md` і `methodology/IFRAME-BRIDGE-INTEGRATION.md`.

## Нефункціональні вимоги

- Performance budgets:
- Accessibility:
- Security/privacy/CSP:
- Localization/timezone:
- Analytics/consent:
- Failure and recovery behavior:

## Критерії завершення

- [ ] Every approved design interaction maps to a functional ID.
- [ ] Loading, empty, partial, error, unauthorized and success states are designed and implemented.
- [ ] API/integration assumptions have owner-backed evidence.
- [ ] Automated and manual acceptance tests reference functional IDs.
- [ ] Production build and static delivery contract pass.
