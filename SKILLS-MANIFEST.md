# Mandatory Skills & Capabilities Manifest

Список описує capability contract, а не прив'язує фреймворк назавжди до marketplace name.
`Required gate` означає: без verified capability цей гейт не відкривається.

## Repository-owned: встановлюються автоматично

| Skill | Required gate | Contract | Source |
|---|---|---|---|
| `promo-landing-framework` | G0–G12 | routing, immutable sequence, artifacts, gates, QA/release discipline | `skills/promo-landing-framework/` |
| `brand-design-base` | any brand task; G3/G5–G8 in landing | product/surface routing, evidence precedence, tokens/components/art, rights and visual QA | `skills/brand-design-base/` |
| `playcity-copy-review` | G2, G10–G11 | placement/claims/CTA/art/metadata/legal red-team; no self-approval | `skills/playcity-copy-review/` |

## Mandatory external capabilities

| Capability | Required gate | Verified examples in current Codex environment | Acceptance evidence |
|---|---|---|---|
| Source/browser inspection | G1–G3, G10–G11 | `browser:control-in-app-browser` | exact URL/node capture, date, runtime evidence |
| Image-based visual ideation | G5 | `product-design:ideate` | exactly 3 source-grounded image directions |
| Bitmap generation/editing | G8 when assets are new | `imagegen` | prompt/reference log, alpha/slot QA |
| Faithful image-to-code | G9 | `product-design:image-to-code` | same-viewport target/implementation comparison |
| Design QA | G7, G10 | Product Design review/design-qa workflow | ranked visual diff, fixes, second comparison |
| Nuxt/Vue engineering | G9 | built-in coding capability or audited Nuxt/Vue skill | pinned-version build/tests, no framework drift |
| Accessibility | G7, G10 | audited a11y capability | blockers/nits, keyboard/reduced-motion/zoom evidence |
| Performance/CWV | G9–G10 | audited performance capability | production measurements vs budget |
| Analytics | G4, G10 | audited analytics capability | event plan and runtime event evidence |

## Conditional capabilities

| Capability | Trigger | Current Codex example | Contract |
|---|---|---|---|
| Brief stress-test | incomplete/high-risk brief | `grilling` | contradictions/blockers after initial intake; no endless interview |
| Creative director | visual direction/full-design editorial review | `creative-director` | reject generic/incoherent work; no extra direction after selection |
| Iframe integration | iframe mode | audited integration/security capability | origin, height, navigation, token/privacy QA |
| Motion | concept includes motion | audited motion capability | static design first, purpose, teardown, reduced motion |
| Security/privacy | external scripts, iframe, auth, postMessage | audited security capability | no token/PII leak; origin/CSP review |
| Deployment/hosting | live URL required | `sites:sites-hosting` or approved Vercel capability | exact reviewed version; explicit G11 approval |

## Platform notes

### Codex

The current working environment was verified to expose `grilling`, `creative-director`, `imagegen`,
Product Design ideation/image-to-code workflows, in-app browser control and Sites hosting. Availability is
session/plugin-dependent: record what the **new project** actually exposes in `SKILL-AUDIT.md`.

### Claude Code

Use [CLAUDE-CODE-SKILLS.md](CLAUDE-CODE-SKILLS.md) as the existing discovery/audit library. Names and
versions may differ from Codex. Install only from an approved source, pin version/SHA and preserve the
same output contract from this manifest.

## Veto rules

- Legal approval remains human even when the copy skill is green.
- Art direction remains human even when ideation scores a winner.
- Accessibility blocker prevents release.
- Product version/package file overrides an external framework skill.
- Deployment requires explicit approval for exact version and target.
