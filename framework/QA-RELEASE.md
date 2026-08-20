# QA & Release: доказ, а не враження

QA має три окремі шари: content/legal truth, design fidelity і technical behavior. Зелений build не
доводить, що персонаж правильний; красивий screenshot не доводить, що CTA або mobile працюють.

## 1. Content & Legal QA

- Approved-copy IDs і version збігаються з Claims Matrix.
- `verbatim` не перефразовано.
- Заборонені claims відсутні у text, image, video, alt і metadata.
- Механіка, thresholds, wager, строки й головний приз актуальні.
- Legal/licence/responsible-gaming ownership відповідає Integration Boundary: landing-owned блок
  повний і читабельний; host-owned блок не дублюється, але підтверджений capture/node/owner-ом.
- CTA label і destination відповідають placement approval.
- Немає SEO/FAQ/final CTA, якщо brief їх заборонив.
- Advertiser/brand/placement/cross-brand relationship відповідають G2 approval.
- Hero art, video, alt, metadata й OG пройшли той самий PlayCity copy/message audit, що й body.

## 2. Design QA

### Reference comparison protocol

1. Захопити source target і implementation в однаковому viewport/state.
2. Поставити їх поруч в один comparison board/input.
3. Оцінити різниці по surface-ах, не загальним «схоже».
4. Виправити видимі помилки.
5. Повторити comparison і зберегти final evidence.

### Required surfaces

- Hero framing і edge blend.
- Typography: family, weight, line-height, line breaks.
- CTA: host-native shape, size, vertical position, states.
- Section spacing і background continuity.
- Asset identity/material/optical weight.
- Deposit/progress numbering і markers.
- Legal density.
- Mobile 440/430/375.
- Editable Figma: 375/430/440/1440/context frames, editable text, Auto Layout/components/styles,
  correct copy version; жодного page-wide flattened screenshot як «handoff».

### Visual anti-regression

- Немає випадкових border/card frames.
- Немає прямокутних країв transparent assets/video.
- Немає нового непогодженого кольору або gradient.
- Canonical mascot не деформований.
- Host/destination brand balance відповідає Brand Bridge.
- Decorative elements не перекривають цифри, CTA або legal.

## 3. Technical QA matrix

### Viewports

Канонічна матриця — [DEVICE-TEST-MATRIX.md](../DEVICE-TEST-MATRIX.md). Поточний top-10:
393×873, 384×832, 390×844, 360×800, 414×896, 384×854, 430×932, 393×852, 440×956, 402×874.
Додатково: 320 px smoke, 873×393 і 800×360 landscape, content desktop 1440 та host context.
Якщо snapshot оновлено, QA використовує новий top-10, а не цей історичний перелік.

### Browsers/devices

- iOS Safari — мінімум один реальний або device farm.
- Android Chrome.
- Desktop Chrome/Safari; Firefox/Edge за audience matrix.
- Reduced motion, Save-Data/slow network, keyboard-only, 200% zoom.

### Runtime assertions

- `scrollWidth - clientWidth === 0`.
- 0 missing images/video posters.
- 0 console errors і hydration warnings.
- Усі CTA видимі, focusable, ведуть у правильний top-level destination.
- Video aspect ratio відповідає approved contract; mobile не crop-ить заборонене.
- No layout shift від media/font swap.
- Iframe height/bridge/origin і overlay safe area працюють.
- Analytics events не дублюються.

## 4. Performance QA

- Production build, не dev.
- LCP/INP/CLS у межах budget або є задокументований waiver.
- LCP asset preloaded/eager, нижні assets lazy.
- Video не вантажиться двічі й має poster/fallback.
- Font weights/glyphs відповідають фактичному використанню.
- Delivery assets у межах Asset Register budget.
- Offscreen ambient motion paused.
- Mobile 375 перевірено першим; desktop не використано як єдиний performance profile.
- Production raster delivery — WebP; alpha-потрібні cutouts перевірено; background media має окремий
  crop/safe-zone contract.
- Static output містить лише delivery allow-list; source/raw/unused versions відсутні.
- Bundle, fonts, images, poster і video bytes записані `target / actual / status`.
- CSS/video/frame-sequence рішення збігається з brief recommendation; Save-Data/RM fallback працює.

Повний гейт — [PERFORMANCE-OPTIMIZATION.md](PERFORMANCE-OPTIMIZATION.md).

## 5. Interaction QA

- CTA hover/active/focus/disabled (якщо є) відповідають host system.
- Scroll не перехоплюється.
- Motion не ховає контент до JS.
- Reduced-motion показує завершений стан.
- Повторні visits/back navigation не лишають блоки невидимими.
- Video autoplay failure не залишає чорний прямокутник.
- External navigation з iframe відкриває top-level destination.

## 6. Release Gate

До production потрібні окремі approvals:

| Approval | Owner | Evidence |
|---|---|---|
| Product truth | Product | Mechanics Model + final content |
| Legal | Legal/compliance | Claims Matrix + final page capture |
| Brand | Brand owner | design comparison + asset contact sheet |
| Design | Product design | 1440/440/430/375 final |
| Analytics | Analyst | event QA |
| Technical | Frontend/QA | build/test/browser report |
| Editable design handoff | Product design | Figma link + 375/430/440/1440/context node IDs |
| Publish | Release owner | exact version + target URL |

`Publish` дозволяє зовнішню зміну стану. Не виводьте production URL із локального preview автоматично.

## 7. Release runbook

For corporate delivery, [CORPORATE-GIT-RUNBOOK.md](../CORPORATE-GIT-RUNBOOK.md) is authoritative.
Its `stage` → mandatory Stage QA → `prod` → Production smoke sequence and manual CI jobs are required;
the generic steps below do not authorize skipping them.

1. Freeze content, assets і version.
2. Clean production build.
3. Run automated tests і static assertions.
4. Run browser matrix та design comparison.
5. Get product/legal/brand/design/analytics approvals.
6. Prepare deployment from exact reviewed commit/source state.
7. Deploy only after release approval.
8. Poll deployment to terminal success/failure.
9. Open public URL without owner-only authentication.
10. Assert title, CTA, assets, legal, analytics and no errors.
11. Record live URL/version/date in PROJECT-STATE.

## 8. Hotfix discipline

- Legal/route/availability issue: block або hotfix із release owner.
- Visual polish без conversion/legal impact: наступна version, якщо release вже стабільний.
- Hotfix не має містити unrelated cleanup.
- Після hotfix повторити affected QA й live verification.

## 9. Retrospective inputs

Зберіть:

- кількість ітерацій на кожному гейті;
- зміни, що повертали проєкт назад;
- assets, які перегенеровували найбільше;
- невідомі, які можна було закрити в questionnaire;
- design-vs-build mismatches;
- analytics funnel і error data;
- reusable additions до CATBET/SlotCity KB;
- зміни до skill і templates.

Технічні чеклісти: [CHECKLISTS.md](../CHECKLISTS.md), [DEVICE-TEST-MATRIX.md](../DEVICE-TEST-MATRIX.md),
[DEPLOY-AND-LAUNCH.md](../DEPLOY-AND-LAUNCH.md).
