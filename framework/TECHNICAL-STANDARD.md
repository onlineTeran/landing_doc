# Shared Technical Standard

Цей шар спільний для CATBET і SlotCity. Product KB визначає вигляд і контент; Technical Standard —
контракт реалізації. Якщо конкретний host має інший контракт, він фіксується в Project Brief і
Decision Log, а не тихо змінює стандарт.

## 1. Базовий стек

- Nuxt 3, Vue 3, TypeScript, `<script setup lang="ts">`.
- SSG через `nuxi generate`, якщо немає обґрунтованої server requirement.
- Компонентний CSS або root-scoped CSS із CSS custom properties.
- Без Tailwind/UI-kit за замовчуванням; host CTA/component можна інтегрувати через adapter.
- GSAP/ScrollTrigger лише коли motion не реалізується простіше й дешевше.
- Content, actions, legal і analytics identifiers не хардкодяться хаотично в template.

`package.json` конкретного проєкту — source of truth. Не переносіть Nuxt 4 conventions у Nuxt 3.

## 2. Integration modes

| Mode | Landing owns | Host owns | Критичні перевірки |
|---|---|---|---|
| Content component / full-page embed | content sections | header, footer, nav, global routing | CSS isolation, seam, sticky chrome offsets |
| Iframe | full child document | outer chrome, iframe sizing | bridge, height, navigation, origins, token/analytics |
| Standalone | весь document | нічого | header/legal/meta, direct navigation |

Embedded landing не містить дубль host header/footer/navigation. Для Figma може бути окремий context
frame з chrome, але production code постачає лише погоджений boundary.

## 3. Рекомендована структура

```text
app.vue
components/
  base/
  media/
  promo/
sections/
composables/
  useAnalytics.ts
  useCtaAction.ts
  useMotionPreferences.ts
  useIframeBridge.ts        # лише для iframe
content/
  copy.json
  actions.json
  legal.json
config/
  actions.ts
  analytics.ts
  campaign.ts
assets/css/
  tokens.css
  base.css
  landing.css
public/assets/
tests/
docs/
  PROJECT-STATE.md
  ASSET-REGISTER.md
  ANALYTICS-PLAN.md
  DESIGN-QA.md
```

`app.vue` — thin shell. Одна секція не повинна ставати монолітом із контентом, motion, asset routing і
legal logic одночасно.

## 4. Viewport standard

### Design deliverables

- Mobile-first source: **375 px**, потім **430 px**, потім **440 px**.
- Content-only desktop після mobile approval: **1440 px**.
- Context frame із host chrome: актуальна ширина продуктового desktop.

### Engineering QA

- Канонічне джерело — [DEVICE-TEST-MATRIX.md](../DEVICE-TEST-MATRIX.md), не список «типових»
  breakpoint-ів зі стелі.
- Поточний обов'язковий top-10: **393×873, 384×832, 390×844, 360×800, 414×896, 384×854,
  430×932, 393×852, 440×956, 402×874**.
- Додатково: 320 px smoke, 873×393 і 800×360 landscape, desktop 1440 та host context.
- Перед кожним новим лендінгом перевірити дату snapshot. Якщо продуктові аналітики дали новий top-10,
  оновити DEVICE-TEST-MATRIX і проєктний QA plan; не розводити другий список у цьому документі.

Viewport — це CSS px. Не плутайте з physical resolution або screenshot scaling.

## 5. Responsive contract

- CSS пишеться mobile-first: base rules для 375+, `min-width` enhancement для ширших mobile/desktop.
- 375 визначає hierarchy, reading order, title/button scale і touch targets; desktop її не перепризначає.
- Mobile має власний layout note для кожної секції.
- Заголовки й кнопки мають mobile token scale, не випадкові overrides.
- Жодного horizontal overflow: `scrollWidth - clientWidth === 0` на всій матриці.
- Media має explicit width/height або `aspect-ratio` для CLS.
- Safe-area враховується лише на контейнерах, що реально можуть потрапити під chrome; padding на root
  заради одного overlay — anti-pattern.
- Hero video: `contain` і пропорційна висота, якщо crop заборонений; `cover` тільки з approved crop map.
- Decorative layers не можуть бути єдиним носієм змісту.

## 6. Content і CTA config

`content/copy.json` і `content/actions.json` обов'язкові для кожного лендінгу, навіть з однією мовою.
Components не містять campaign copy, CTA labels або destination URLs. Config має `version`, `status`,
редакторську інструкцію й Claims Matrix IDs для чисел/legal-sensitive тез.

Кожен CTA має:

```ts
type PromoAction = {
  id: string
  label: string
  href?: string
  eventAction?: number
  location: 'hero' | 'intro' | 'mechanics' | 'offer' | 'final'
  destinationProduct: 'catbet' | 'slotcity'
}
```

`CtaButton` зберігає host shape, states, typography і accessibility. Label та route приходять із config.
Не підміняйте host button style «красивішим» destination-gradient.

Approved legal copy зберігається окремо з version/source/status. Якщо текст треба показати меншим
шрифтом, це layout-рішення, а не дозвіл скорочувати.

Для CATBET/SlotCity copy config зберігає Claims Matrix IDs і layer (`legal/product`, `campaign`,
`brand-tov`). Вимоги до тексту та mandatory blocks — у
[PLAYCITY-COPYWRITING-RULES.md](../PLAYCITY-COPYWRITING-RULES.md).

## 7. Video contract

- `muted`, `playsinline`, `loop` за brief-ом.
- `preload="none"` або `metadata`; poster завантажується пріоритетно, якщо це LCP.
- Не завантажувати desktop і mobile video одночасно.
- `prefers-reduced-motion`, Save-Data і unsupported autoplay отримують poster.
- Немає border/radius, якщо hero має зливатися з background.
- Edge blend робиться overlay/gradient із кольором реального landing background, не чорним прямокутником.
- На mobile ширина може виходити на `100vw`, якщо це погоджений full-bleed element.

## 8. Motion contract

- Motion має purpose: attention, explanation, feedback або continuity.
- Reveal-on-scroll не вмикається за замовчуванням для всіх блоків.
- Не більше одного dominant motion у viewport.
- Transform/opacity preferred; layout-affecting properties — виняток.
- Reduced-motion показує фінальний статичний стан без втрати контенту.
- Кожен observer, listener, RAF, GSAP context і timer має teardown.
- У iframe не перехоплювати host scroll і не створювати scroll-jacking.

## 9. Performance budget

Базові цілі; проєкт може зробити їх жорсткішими:

| Метрика | Ціль |
|---|---:|
| LCP p75 | ≤ 2.5 s |
| INP p75 | ≤ 200 ms |
| CLS p75 | ≤ 0.1 |
| Initial route JS | ≤ 180 KB gzip |
| Hero poster | бажано ≤ 300 KB mobile / ≤ 500 KB desktop |
| Hero video | за project budget; окремий mobile source preferred |
| Fonts | лише потрібні family/weights/glyphs |

Build-перевірка виконується на production output, не в dev mode.
Повний mobile-first optimization, WebP/alpha policy, CSS → video → sequence decision і static delivery
contract визначені у [PERFORMANCE-OPTIMIZATION.md](PERFORMANCE-OPTIMIZATION.md).

## 10. Accessibility

- Одна логічна heading hierarchy.
- CTA і links керуються клавіатурою, мають visible focus і descriptive accessible name.
- Touch target ≥ 44×44 CSS px, якщо host standard не вимагає більше.
- Alt описує функцію/зміст, декоративні assets мають порожній alt.
- Контраст перевіряється на реальному composite background.
- 200% zoom не втрачає CTA, legal або механіку.
- Responsible gaming text не можна робити фактично нечитабельним через opacity/size.

## 11. Security і privacy

- Жодних credentials/tokens у repo, query string або prompt log.
- Cross-origin messages перевіряють `origin`, source і schema.
- Analytics не містить PII.
- External links використовують коректні target/rel.
- Asset origins узгоджені з host CSP.

## 12. Definition of Feature Complete

- Усі approved sections і content version інтегровані.
- 1440/440/430/375 відповідають design target; top-10 із DEVICE-TEST-MATRIX пройдено runtime.
- CTA routes реальні, tracked і доступні.
- Немає missing assets, console errors, hydration errors або overflow.
- Hero video має poster/fallback і правильний aspect contract.
- Legal text повний і відповідає approved source.
- Host seam, header/footer offsets та background перевірені.
- Production build і unit/integration checks зелені.
- `copy.json`/`actions.json` є єдиним джерелом campaign copy і route-ів.
- Production результат відкривається як static HTML+assets; delivery allow-list не містить raw,
  source, contact-sheet або unused legacy assets.
- Editable Figma frames 375/430/440/1440/context відповідають exact copy version і asset IDs.

Деталі: [STARTER-ARCHITECTURE.md](../STARTER-ARCHITECTURE.md),
[IFRAME-BRIDGE-INTEGRATION.md](../IFRAME-BRIDGE-INTEGRATION.md),
[CONTENT-CONFIG.md](../CONTENT-CONFIG.md), [CTA-AND-LINKS.md](../CTA-AND-LINKS.md).
