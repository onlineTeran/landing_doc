# Starter-архітектура

Мета: вирішити, які частини високоякісного інтерактивного промо-лендінга (Nuxt 3 / Vue 3 / TS, SSG, embeddable) стають **переюзабельним starter**-ом — і, що не менш важливо, які частини мають лишатися унікальними (bespoke) для кожної кампанії.

> Умовність маркування (за каноном §0): **Спостережено** = побачено в референсній сесії/коді; **Виведено** = логічний висновок; **Рекомендовано** = погляд наперед. Ніколи не читай Рекомендовано/Виведено як факт.

---

## 1. Ключова теза

Промо-лендінг — це дві речі, склеєні разом:

1. **Переюзабельне шасі доставки** — shell, tokens, primitives, робота з медіа, motion-обв'язка, дисципліна reduced-motion, performance-дефолти, embed-контракт, QA-гейти. Це 60–70% *інженерії* і майже нічого з *ідентичності*. **Рекомендовано:** винести це.
2. **Унікальна art direction** — концепція hero, одна центральна візуальна метафора, фірмовий motion сцени, копірайт, палітра. Це ~100% того, що робить сторінку *хорошою* й запам'ятовуваною. **Спостережено:** у референсній сесії фірмова сцена (написана вручну орбітальна сцена на `requestAnimationFrame`) була вкрай унікальною й не піддавалася узагальненню без вихолощення того, що робило її робочою. **Не** заганяй її в starter.

Завдання starter-а — зробити пункт #1 безкоштовним і швидким, щоб уся енергія йшла в #2. Starter, який намагається ввібрати #2, стає гіршим інструментом, ніж порожня папка.

Правило великого пальця: **якщо частина кодує *те, як сторінка поводиться й лишається швидкою* — виноси її. Якщо частина кодує *те, чим є кампанія* — лишай її як приклад, а не як фреймворк.**

---

## 2. Таблиця вироків щодо винесення

Кожен кандидат позначений своїм evidence-лейблом і вироком щодо винесення.

| Частина | Evidence | Винести в starter? | Нотатки |
|---|---|---|---|
| App shell (`app.vue`, root на ~20 рядків + `<main>`) | Спостережено | **Так** | Тонкий shell зі списком секційних компонентів працював добре; тримай його тонким. |
| Шар design-token (`tokens.css`) | Спостережено | **Так (як порожній scaffold)** | Постач *категорії* та *назви* змінних; постач placeholder-значення, а не реальні. |
| Container primitive | Виведено | **Так** | Тривіальний max-width + inline-gutters; потрібен кожній сторінці. |
| Section wrapper | Виведено | **Так** | Стандартизує вертикальний ритм, `id`-якорі, reveal-хук, z-index-шарування. |
| Responsive-утиліти (fluid scale, `dvh`/`svh`-хелпери) | Спостережено | **Так** | `clamp()`-шкала + safe-area + no-overflow-хелпери універсальні. |
| Button primitive (pill, розмірні варіанти) | Спостережено | **Так** | Стиль через tokens; форма/варіанти переюзабельні, кольори — tokens. |
| Typography primitives (display/UI-накреслення, heading-шкала) | Спостережено | **Так** | Два font-*слоти*; фактичні накреслення — це config. |
| Media / responsive image компонент | Спостережено | **Так** | `srcset`/`sizes`, явні dims, lazy+async-дефолти, LCP-override. |
| Video-компонент (IO-gated, `preload="none"`, RM-poster, Save-Data) | **Спостережено** | **Так — висока цінність** | Найбільш переюзабельний performance-несучий компонент. |
| Animation-composables (GSAP context lifecycle, matchMedia-гейт) | Спостережено | **Так (як тонкі хелпери)** | Виноси *патерн lifecycle/cleanup*, а не конкретні timelines. |
| IntersectionObserver-хелпер | Спостережено | **Так** | Reveal-on-scroll + offscreen-pause обидва його потребують. |
| Обробка reduced-motion (`useMotionPrefs` + idle-sections plugin) | **Спостережено** | **Так — обов'язково** | Реактивний RM-прапор + спільний observer, що паузить offscreen ambient CSS. |
| Iframe bridge composable | **Рекомендовано** | **Так (opt-in модуль)** | НЕ відпрацьовано в референсній сесії (використовувався full-page embed). Постач, вимкненим за замовчуванням. |
| Analytics-адаптер | **Рекомендовано** | **Так (opt-in, no-op дефолт)** | Не реалізовано в сесії. Дай інтерфейс + null-адаптер. |
| Error boundary | Рекомендовано | **Так** | Fallback рівня секції, щоб одна зламана сцена не занулила сторінку. |
| Performance monitoring-хук | Рекомендовано | **Так (opt-in)** | Web-vitals-репортер, підключений до analytics-адаптера. |
| Content config-шар | **Рекомендовано** | **Так — відсутній шар** | Сесія захардкодила копірайт у компонентах; config-шар робить заміни дешевими. |
| Концепція hero / центральна візуальна метафора | Спостережено | **Ні** | Лише приклад. Це art direction. |
| Motion фірмової сцени (bespoke rAF-сцена) | **Спостережено** | **Ні** | Вкрай унікальна; узагальнення її руйнує. Постач як *опрацьований приклад*. |
| Копірайт секцій, значення палітри, реальні асети | Спостережено | **Ні** | Контент per-campaign, живе в config/content, а не у фреймворку. |

---

## 3. Що НЕ можна робити універсальним

**Спостережено + Виведено.** Спокуса — абстрагувати доти, доки "hero" й фірмова сцена не стануть конфігурованими. Стримайся.

- **Art direction і центральна візуальна метафора.** Причина, з якої промо-лендінг заслуговує уваги, — одна відкомітена концепція. Starter, який постачає "конфігурований hero з 6 layout-пресетами", породжує генеричні сторінки. Постач *один* приклад hero й видали-щоб-замінити його.
- **Motion фірмової сцени.** Спостережено: орбітальна сцена поєднувала унікальну геометрію (виміряні смуги зазорів, рівноперіодні movers із рознесенням фаз, пауза/відновлення з збереженням time-continuity, гейтинг cursor-parallax). Її коректність походила з обмежень, специфічних для *тієї* композиції. Генеричний prop bag "particle field" був би і важчим, і гіршим. Тримай її як **reference implementation** у `sections/examples/`, а не як core-компонент.
- **Копірайт, цифри, юридичний текст.** Ніколи не запікай копірайт кампанії в спільний компонент. Він належить content config (§6) і змінюється щокампанії.
- **Реальні значення палітри.** Постач *назви й категорії* tokens; постач нейтральні placeholder-значення. Брендова палітра — це override-файл per-project.
- **Фіксована послідовність секцій.** *Ролі* секцій (канон §15: Hero → Value/Explanation → Mechanics/Benefits → Visual storytelling → Proof/Trust → FAQ/Legal → Final CTA) — це **система прийняття рішень**, а не обов'язковий порядок. Starter пропонує ролі як доступні секційні слоти; сторінка обирає та впорядковує їх.

> Крос-реф: `DECISION-LOG-TEMPLATE.md` — фіксуй, *чому* конкретний лендінг лишив чи прибрав кожну секційну роль і де він відхилився від дефолтів starter-а.

---

## 4. Рекомендована структура директорій starter-а

**Рекомендовано.** Виведено зі Спостереженого плаского-але-тонкого shell-layout, реорганізовано так, щоб генеричні primitives були відокремлені від example-секцій і data-driven контенту. Подавай це як стартову точку, а не мандат.

```
landing-starter/
  app.vue                      # thin shell: root class + <main> renders configured sections
  nuxt.config.ts               # SSG, @nuxt/fonts (subset), app.head (LCP preload, meta)
  assets/css/
    tokens.css                 # token layer — CATEGORIES + NAMES, placeholder values
    base.css                   # reset, primitives, reduced-motion CSS, ambient keyframes
  components/                  # GENERIC, campaign-agnostic primitives
    BaseContainer.vue
    BaseSection.vue
    BaseButton.vue
    BaseMedia.vue              # responsive <img>
    BaseVideo.vue              # IO-gated, preload=none, RM poster, Save-Data
    RevealItem.vue             # reveal-on-scroll wrapper
  sections/                    # PAGE sections (swap freely per campaign)
    examples/                  # worked examples — delete/replace, do not import as-is
      HeroExample.vue
      SignatureSceneExample.vue   # the bespoke scene, as REFERENCE ONLY
    SectionValue.vue
    SectionMechanics.vue
    SectionFaq.vue
    SectionFinalCta.vue
  motion/
    useGsapContext.ts          # gsap.context lifecycle + cleanup helper
    useMotionPrefs.ts          # reactive reduced-motion flag        (Observed)
    useReveal.ts               # IO-based reveal composable
    useMagnetic.ts             # optional pointer-parallax helper    (Observed)
    tokens.ts                  # motion durations/easings mirrored from CSS tokens
  plugins/
    gsap.client.ts             # register ScrollTrigger; refresh after fonts
    lenis.client.ts            # smooth scroll via gsap.ticker; skip under RM
    idle-sections.client.ts    # ONE IntersectionObserver pausing offscreen ambient (Observed)
  integrations/                # OPT-IN, off by default
    useIframeBridge.ts         # child-side embed contract           (Recommended)
    parent-embed-snippet.md    # copy-paste parent code              (Recommended)
    analytics.ts               # adapter interface + no-op default   (Recommended)
    useWebVitals.ts            # perf reporter → analytics adapter   (Recommended)
  config/
    site.config.ts            # global: fonts, embed mode, feature flags, routes
    sections.config.ts        # which sections render, in what order
  content/
    en.ts                     # copy/asset refs (i18n-ready shape)   (Recommended)
  utils/
  types/
  public/img, public/video    # local assets (mirrored to CDN at deploy)
```

Крос-реф: `CHECKLISTS.md` — гейти "чи правильно ми це підключили" per-phase для скафолдингу, motion, асетів і embed.

---

## 5. API компонентів і composables (псевдокод)

Сигнатури у стилі TypeScript. Лише props/slots/events — реалізації це робота starter-а, а не цього документа.

### 5.1 BaseContainer — Виведено

```ts
// Centered max-width wrapper with responsive gutters.
interface ContainerProps {
  as?: keyof HTMLElementTagNameMap   // default 'div'
  width?: 'default' | 'narrow' | 'wide' | 'bleed'  // maps to --container tokens
}
// slot: default
```

### 5.2 BaseSection — Виведено

```ts
// Standardizes vertical rhythm, anchor id, z-index layering, reveal grouping.
interface SectionProps {
  id: string                          // anchor + analytics section id
  tone?: 'base' | 'surface'           // background token bucket
  padded?: boolean                    // default true → --space-section
  reveal?: boolean                    // default true → children can use RevealItem
}
// slots: default, 'decor' (rendered at --z-decor, always behind content)
```

### 5.3 BaseButton — Спостережено (форма) / tokens (колір)

```ts
interface ButtonProps {
  as?: 'button' | 'a'
  href?: string                       // when as='a'; external → rel="noopener noreferrer"
  variant?: 'primary' | 'secondary' | 'ghost' | 'alert'  // color via tokens only
  size?: 'lg' | 'md' | 'sm' | 'xs'    // maps to pill height tokens
  block?: boolean
  target?: '_self' | '_top' | '_blank' // '_top' matters under iframe embed (§7)
}
// events: click
// slot: default (label); optional 'icon-start' / 'icon-end'
```

### 5.4 BaseMedia (responsive image) — Спостережено

```ts
interface MediaProps {
  src: string
  srcset?: string
  sizes?: string
  width: number                       // REQUIRED — CLS control
  height: number                      // REQUIRED
  alt: string
  priority?: boolean                  // true → eager + fetchpriority=high (LCP only)
                                      // false (default) → loading=lazy, decoding=async
}
```

### 5.5 BaseVideo — Спостережено (високоцінний primitive)

```ts
// Never autoplays on mount. IntersectionObserver is the SOLE play driver.
interface VideoProps {
  src: string                         // + optional multiple <source> for WebM/AV1 + H.264
  poster: string                      // shown under reduced-motion / Save-Data / no-JS
  width: number
  height: number
  rootMargin?: string                 // IO pre-roll, default '200px'
  respectSaveData?: boolean           // default true → skip download if navigator.connection.saveData
}
// Behavior (all Observed):
//   preload="none"; muted; loop; playsinline
//   plays when >= threshold in view, pauses when out
//   prefers-reduced-motion: reduce  → never plays, poster stays
//   Save-Data on                    → never downloads, poster stays
// events: 'playing', 'poster-shown'
```

### 5.6 Motion-composables — Спостережений патерн

```ts
// Reactive reduced-motion flag (SSR-safe: false on server, hydrates on client).
function useMotionPrefs(): { reduced: Ref<boolean> }   // Observed

// GSAP lifecycle wrapper: scoped context + guaranteed teardown.
function useGsapContext(
  scope: Ref<HTMLElement | null>,
  build: (ctx: gsap.Context, reduced: boolean) => void
): void
// - registers ScrollTrigger on client only
// - runs `build` inside gsap.context(scope) with a matchMedia gate
// - reduced path sets FINAL states instantly (autoAlpha:1, y:0) — no scrub/pin/parallax
// - onUnmounted → ctx.revert() + ScrollTrigger.kill()   (Observed cleanup discipline)

// Reveal-on-scroll (opacity/translate only; semantic text never hidden pre-JS).
function useReveal(el: Ref<HTMLElement | null>, opts?: { once?: boolean }): void
```

### 5.7 idle-sections plugin — Спостережено

```
// ONE shared IntersectionObserver for the whole page.
// Toggles a class on each registered section that sets
// `animation-play-state: paused` on its ambient CSS @keyframes when offscreen.
// Honors "no infinite offscreen ambient animation" (canon §5).
```

### 5.8 Iframe bridge — Рекомендовано (НЕ відпрацьовано цієї сесії)

> **Чесність щодо інтеграції:** референсна сесія використала **full-page embed** (продукт дає header+footer, лендінг заповнює середину, без iframe, CTA — звичайні лінки на роути продукту, краї підігнані під темний chrome продукту за кольором). Усе в цьому підрозділі — контракт із поглядом наперед, а не те, що сесія валідувала. Див. §7 щодо правила вибору між двома режимами.

```ts
// CHILD side (inside the iframe).
function useIframeBridge(opts: {
  allowedParentOrigins: string[]      // origin allow-list (required)
}): {
  ready: () => void                   // send { source:'landing', type:'landingReady' }
  requestNavigate: (url: string) => void   // parent performs top-level nav
  reportHeight: () => void            // debounced; ResizeObserver on documentElement
  emit: (type: string, payload?: unknown) => void  // e.g. forward analytics events
}
// Versioned message envelope: { source:'landing', v:1, type, payload }
// Height autosize: child measures own scrollHeight → postMessage → parent resizes iframe.
// Standalone mode: if window.top === window.self, bridge is inert (page also works alone).
```

```ts
// PARENT side (product page) — shipped as parent-embed-snippet.md, not a Vue file.
// - creates the iframe (width 100%, allow="autoplay")
// - listens for {source:'landing'} messages, verifies event.origin ∈ allow-list
// - on 'landingReady' → hide loader; on height → set iframe.style.height
// - on 'navigate' → top.location = url (validated); on error → show fallback
```

### 5.9 Analytics-адаптер — Рекомендовано

```ts
interface AnalyticsAdapter {
  track(event: string, props?: Record<string, unknown>): void
  pageview(path: string): void
}
const nullAdapter: AnalyticsAdapter    // default: no-op, zero bytes
// Section CTAs call analytics.track('cta_click', { section, variant }).
// Under iframe embed, adapter can forward via useIframeBridge().emit (§5.8).
```

### 5.10 Error boundary — Рекомендовано

```ts
// Section-level: onErrorCaptured → render a minimal static fallback for THAT section,
// keep the rest of the page alive. A broken signature scene must not blank the landing.
```

---

## 6. Принципи кастомізації

**Головна директива: рестайл через редагування tokens + content config, а не компонентів.**

1. **Палітра / типографіка / spacing → лише `tokens.css`.** Вигляд нової кампанії змінюється через override *значень* CSS custom property. Якщо рестайл вимагає редагування розмітки компонента — компонент протік захардкодженим значенням, яке мало би бути token-ом. (Спостережений урок, канон §11: глобальний `img{max-width:100%}` і глобальна зміна title-token обидва спричинили переробку — глобальні правки б'ються з навмисними винятками. Надавай перевагу tokens + явним escape hatches.)
2. **Копірайт / асети / CTA-роути → `content/*.ts` + `site.config.ts`.** Жоден копірайт, URL чи цифра не живе у `<script setup>` компонента. (Спостережена слабкість: сесія захардкодила контент у компонентах; цей шар — виправлення.)
3. **Які секції, в якому порядку → `sections.config.ts`.** Додавання/видалення секційної ролі — це config-правка, а не переписування шаблону.
4. **Інтенсивність motion → motion-tokens + RM-гейт.** Durations/easings — це tokens; reduced-шлях автоматичний. Кампанія крутить motion через `--t-*`/`--ease-*`, а не переписуючи timelines.
5. **Фірмова сцена копіюється, потім присвоюється.** Дублюй `sections/examples/SignatureSceneExample.vue`, перейменуй і переписуй вільно. Вона *не* призначена конфігуруватися ззовні — це задумано.
6. **Feature flags гейтять opt-in модулі.** Iframe bridge, analytics, web-vitals і Lenis smooth scroll вимкнені/no-op за замовчуванням і вмикаються в `site.config.ts`. Сторінка, якій жоден із них не потрібен, не постачає жодного їхнього байта.

Опрацьований приклад (генеричний — вигаданий лендінг "event countdown"):

```ts
// tokens.css override
:root {
  --color-bg: /* dark chrome to match parent */;
  --color-accent: /* the campaign's one accent */;
  --font-display: 'ExampleDisplay';
}
// content/en.ts
export default {
  hero: { kicker: 'Countdown', title: 'Doors open in…', cta: { label: 'Get notified', href: '/signup' } },
  faq: [ /* items */ ],
}
// sections.config.ts
export default ['hero', 'value', 'mechanics', 'faq', 'finalCta']  // no 'signatureScene' this time
```

Ніщо вище не чіпає файл компонента. Це і є цільовий стан.

---

## 7. Embed mode: рішення, яке starter має відкрити назовні

**Спостережено vs Рекомендовано.** Starter має підтримувати обидва режими embedding і робити вибір явним у `site.config.ts` (`embedMode: 'full-page' | 'iframe'`).

| | Full-page embed (**Спостережено**) | Iframe embed (**Рекомендовано / Виведено**) |
|---|---|---|
| Chrome | Продукт дає header + footer; лендінг заповнює середину | Лендінг ізольований усередині iframe |
| Стилізація | Scoped під одним root-класом; краї підігнані під продукт за кольором | Повністю ізольовано; parent керує розмірами |
| CTA | Звичайні лінки на роути продукту | `target="_top"` або `postMessage({type:'navigate'})` |
| Висота | Природний document flow | Child вимірює + `postMessage`-ить; parent ресайзить |
| Зв'язаність | Ділить CSP/origin продукту, без message bus | Cross-origin; версіонований контракт повідомлень |
| Статус сесії | **Використано й валідовано цієї сесії** | **Не відпрацьовано — контракт із поглядом наперед** |

**Правило рішення (Виведено):** обирай **full-page embed**, коли лендінг постачається в *той самий* codebase/origin, що й продукт, і може перейняти його chrome та CSP — простіше, без message bus, чистіший шов. Обирай **iframe embed**, коли лендінг має лишатися ізольованим (інший origin, незалежний темп деплою, недовірений чи locked-down parent, або переюз між кількома host-продуктами). Starter за замовчуванням `full-page`, бо це валідований шлях; `iframe` вмикає `useIframeBridge` і parent-сніпет.

---

## 8. Ризики надмірної абстракції

**Виведено / Рекомендовано.** Starter провалюється у протилежному напрямку від copy-paste-каші: через надмірну хитромудрість.

- **Передчасна генеральність.** Побудова системи "підтримує будь-який hero-layout" до того, як існує друга реальна кампанія, гарантує, що абстракція неправильна. **Виноси на другому використанні, не на першому.** Постач патерни референсної сесії; узагальнюй частину лише коли *нова* лендінг-сторінка справді потребує її інакше.
- **Протікаючі primitives.** `BaseVideo`, який тихо автоплеїть, або `BaseSection`, який хардкодить колір фону, змушують правити компоненти per-campaign — перекреслюючи token-контракт (§6). Кожен primitive має повністю керуватися з props + tokens, або це не primitive.
- **Config складніший за код, який він замінює.** Якщо `sections.config.ts` обростає міні-DSL із умовами й slots-as-data, він став гіршою мовою програмування, ніж Vue. **Запобіжник:** config має бути пласкими даними (які секції, який копірайт, які прапори). Щойно йому потрібна логіка — ця логіка належить компоненту, а не config-у.
- **Надмірно конфігурований motion.** Виставлення кожного GSAP-параметра як token породжує сторінки, які ніхто не може зробити *смачними*. Виставляй інтенсивність/тривалість/easing і RM-гейт; тримай саму хореографію в коді (і bespoke для фірмових сцен).
- **Поглинання art direction.** Найбільший ризик: starter, який постачає стільки hero-пресетів і опцій сцен, що команди перестають art-директувати й починають вибирати з меню. Це породжує саме формулу "centered hero + gradient + три картки + glassmorphism", уникати якої існує ця методологія. Starter має зробити *шасі* безкоштовним і лишити *ідентичність* навмисно порожньою.

**Лакмусовий тест для будь-якого запропонованого винесення:** *Чи дві візуально різні, добре art-директовані кампанії обидві використали б цю частину без змін?* Якщо так → starter. Якщо вона підходить лише сторінкам, які виглядають однаково → це art direction у костюмі фреймворку; лиши її як приклад.

---

## 9. Підсумок

- **Виносимо (шасі, підкріплене Спостереженим):** shell, tokens (порожні), container, section wrapper, responsive-утиліти, button, типографіка, media, **video (IO-gated / `preload=none` / RM-poster / Save-Data)**, motion-composables, IO-хелпер, **обробка reduced-motion (`useMotionPrefs` + idle-sections plugin)**.
- **Виносимо як opt-in (Рекомендовано):** iframe bridge, analytics-адаптер, error boundary, web-vitals-хук, **content config-шар**.
- **Ніколи не універсалізуємо (Спостережено):** концепція hero, центральна візуальна метафора, **bespoke фірмова сцена**, копірайт, значення палітри, фіксований порядок секцій.
- **Кастомізуй через tokens + content config, а не правки компонентів.**
- **Підтримуй обидва режими embed;** full-page — валідований дефолт, iframe — задокументований контракт із поглядом наперед.
- **Надмірна абстракція — це failure mode**, якого варто боятися більше за дублювання: виноси на другому використанні, тримай config пласким і тримай ідентичність порожньою навмисно.

> Пов'язані документи в цьому пакеті: `CHECKLISTS.md` (гейти per-phase), `DECISION-LOG-TEMPLATE.md` (фіксація відхилень і вибору секційних ролей).
