# Чеклісти

> Призначення: готові до вставки go/no-go чекбокси для кожної фази побудови high-end інтерактивного промо-лендінга (Nuxt 3 / Vue 3 / TS, SSG, embeddable). Скопіюй секцію й відмічай по ходу.

Легенда: **[O]** Спостережено цієї сесії · **[I]** Виведено · **[R]** Рекомендовано. Назви фаз відповідають спільному канону (Discovery → … → Post-launch review). Крос-референси (реальні файли в цій теці): `LANDING-WORKFLOW.md`, `PHASE-PROMPTS.md` та `LANDING-DEVELOPMENT-METHODOLOGY.md` — останній охоплює tech stack (§6), motion (§8), адаптив (§10), iframe/embedding (§11), performance (§12), асети (§9) і деплой (у межах §16 QA / та PHASE-PROMPTS §16).

---

## Перед стартом (Discovery → Нормалізація вимог)

- [ ] Названо одну конверсійну ціль; кожна CTA веде на реальний продуктовий роут (без плейсхолдерів). **[O]**
- [ ] Реальний контент отримано (копірайт, цифри, legal) — нічого не вигадано. **[O]**
- [ ] Обрано режим вбудовування: **full-page embed** vs **iframe embed** (див. правило вибору в `LANDING-DEVELOPMENT-METHODOLOGY.md` §11). **[O]**
- [ ] Якщо full-page embed: висоти продуктового header/footer + кольори тла країв отримані від продуктової команди. **[O]**
- [ ] Точні URL для CTA, дозволені origin-и асетів (CSP) та очікування щодо аналітики узгоджені з командою. **[O]**
- [ ] Стек запінено: `nuxt@^3` (НЕ 4), Vue 3, TS, ціль SSG. Package manager + версія Node зафіксовані; lockfile закомічено. **[O]**
- [ ] Зі стейкхолдером узгоджено постійний гейт: **перевіряй на localhost, не деплой до явного апруву.** **[O]**
- [ ] Занотовано застереження щодо скілів (напр. скіл, згенерований під Nuxt 4 → ігнорувати `app/` srcDir; React-приклади → транслювати у Vue). **[O]**
- [ ] Перелічено compliance/legal-обмеження (маркування віку, ліцензія, посилання на правила), якщо застосовно. **[O]**

## Перед написанням коду (Концепція → Розкадровка → Технічний план → Дизайн-основи → Скафолдинг)

- [ ] Ролі секцій розкадровані: Hero → Value → Mechanics → Visual storytelling → Proof → FAQ/Legal → Final CTA (система прийняття рішень, а не фіксований список). **[O]**
- [ ] Design tokens спершу визначені в `assets/css/tokens.css`: color, type scale (`clamp()`), spacing, `--radius-pill`, motion `--t-*` / `--ease-*`, z-index scale, `--container`. **[O]**
- [ ] Задокументовано **z-index scale**, щоб декор лишався під контентом (fixed декор `--z-decor` < контент `--z-content`). **[O]**
- [ ] Тонкий `app.vue` shell (root-клас + `<main>` зі списком секцій); один компонент на секцію; жодної animation-логіки в темплейтах. **[O]**
- [ ] Наперед вирішено mobile-трактування для кожної секції (окрема art direction, не scale-down). **[O]**
- [ ] Motion-модель для будь-якого елемента, «затиснутого між двома краями», вирішена як **measured**, а не як частка viewport. **[O]**
- [ ] На місці `html.js`-гейтинг (inline head-скрипт), щоб семантичний контент показувався без JS. **[O]**
- [ ] Обрано єдиний scoped root-клас (напр. `.landing-root`); жодних агресивних глобальних reset-ів, що можуть протекти в продуктовий chrome. **[O]**

## Після hero (Реалізація Hero)

- [ ] LCP — це адаптивний poster **`<img>`**, а не відео. **[O]**
- [ ] Poster preload-нуто з `imagesrcset`/`imagesizes` + `fetchpriority="high"`. **[O]**
- [ ] Немає зайвого `<video poster=…>`, що подвійно фетчить poster. **[O]**
- [ ] Hero-відео (якщо є) `preload="none"`, IntersectionObserver — єдиний драйвер `.play()`, Save-Data гейт. **[O]**
- [ ] Явні width/height (або `aspect-ratio`) на hero-медіа → без CLS. **[O]**
- [ ] Reduced-motion-шлях: статичний poster, без autoplay/parallax. **[O]**
- [ ] Немає console-помилок на першому paint; above-the-fold перевірено в браузері. **[O]**

## Після кожної секції (Реалізація секцій → Motion)

- [ ] Секція володіє власним animation lifecycle: `gsap.context(scope)` + `ctx.revert()` + `ScrollTrigger.kill()` в `onUnmounted`. **[O]**
- [ ] Reveal використовує лише opacity/transform; семантичний текст ніколи не ховається до JS. **[O]**
- [ ] Немає GSAP-твіну, створюваного щокадру scroll — твін лише на зміні стану всередині `onUpdate`. **[O]**
- [ ] rAF-сцени: лише transform на кадр, `will-change:transform` тільки на рухомих елементах, без per-frame алокацій, без read/write reflow-трешингу. **[O]**
- [ ] Декоративні primitive-и приймають `uid` prop, щоб уникнути колізій SVG id при повторному використанні. **[O]**
- [ ] CTA в секції ведуть на реальні роути; зовнішні лінки `rel="noopener noreferrer"`. **[O]**
- [ ] Контент-дані, що варіюватимуться між кампаніями, винесені в бік config/content-шару. **[R]**

## Адаптив (Адаптив)

- [ ] Перевірено на 320 / 360 / 375 / 390 / 768 / 1024 / 1440 + landscape. **[O]**
- [ ] **Немає горизонтального overflow**, підтверджено вимірюванням `scrollWidth - clientWidth === 0` (не на око). **[O]**
- [ ] `svh`/`dvh` використано з fallback-ами; safe-area insets враховано. **[O]**
- [ ] Cursor-parallax / hover-ефекти обмежені `(hover:hover) and (pointer:fine)`. **[O]**
- [ ] Елементи, прив'язані до різних країв: вільна зона виводиться runtime `measure()` на mount + `ResizeObserver`, а не частками viewport. **[O]**
- [ ] Циклічні рухомі елементи: однаковий кутовий період + рівномірно розподілені фази (константний інтервал), per-mover radius для глибини; відсутність колізій доведена математичною симуляцією. **[O]**
- [ ] Mobile — це окрема art direction, а не стиснутий desktop. **[O]**

## Motion (Motion)

- [ ] `gsap.matchMedia('(prefers-reduced-motion: no-preference)')` гейтить усю scroll-анімацію; reduced-шлях виставляє фінальні стани миттєво. **[O]**
- [ ] **Reduced-motion перераховується на resize** — винести reduced-прапорець нагору, перезапустити layout на `ResizeObserver`. **[O]**
- [ ] Ambient `@keyframes` — лише compositor-only (transform/opacity/rotate). **[O]**
- [ ] **Ambient-анімації паузяться offscreen** через один спільний IntersectionObserver, що перемикає `animation-play-state: paused`. **[O]**
- [ ] rAF-сцени паузяться offscreen **зі збереженням часової неперервності** (акумулюй паузований час, щоб рух відновлювався безшовно). **[O]**
- [ ] Lenis (якщо використовується) керується через `gsap.ticker`; повністю пропускається під reduced-motion. **[O]**
- [ ] Плагіни реєструються лише на клієнті; жодних дубльованих timeline-ів/listener-ів після навігації. **[O]**
- [ ] Шви циклу приховані: точки входу/виходу винесені за екран. **[O]**

## Асети (Оптимізація асетів)

- [ ] Кожен медіа-елемент має явні width/height або `aspect-ratio`. **[O]**
- [ ] Статичні кадри як WebP з адаптивними `srcset`/`sizes`; non-LCP зображення `loading="lazy"` + `decoding="async"`. **[O]**
- [ ] Відео: `preload="none"`, play гейтований через IO, статичний poster під reduced-motion, Save-Data гейт. **[O]**
- [ ] QA відео-циклу: перший кадр ≈ останній кадр (безшовно); без видимого бандингу. **[R]**
- [ ] Прозорий декор протестовано і на світлому, і на темному тлі. **[R]**
- [ ] **Шрифти субсетнуто** — аудит *збілдженого HTML*: кількість `@font-face` осмислена (немає випадково інлайнених CJK/невживаних unicode-range зрізів); надано повний алфавіт, що реально рендериться, щоб жоден glyph не впав у fallback. **[O]**
- [ ] `font-display: swap` + metric-matched fallback (`size-adjust`/`ascent-override`) для near-zero swap CLS. **[O]**
- [ ] Нові бінарні асети розміщені на дозволеному CDN (presign → PUT → confirm → URL); референсуються за URL, а не base64-inline. **[O]**
- [ ] Глобальний `img{max-width:100%}` не обрізає навмисно-збільшену графіку — додати escape hatch `max-width:none` там, де потрібно. **[O]**

## Iframe / embed (Iframe/embed-інтеграція)

Full-page embed **[O]** — використано цієї сесії:
- [ ] Немає власного header/footer; лендінг заповнює простір між продуктовим chrome. **[O]**
- [ ] Тло країв кольорово підігнане під темний продуктовий chrome для безшовного шва. **[O]**
- [ ] Стилі scoped під root-класом; жодні глобальні reset-и не протікають у продукт; продуктові cookies/localStorage не чіпаються. **[O]**
- [ ] ScrollTrigger-offset-и враховують висоту продуктового sticky-header. **[O]**
- [ ] CTA — це звичайні лінки на продуктові роути; postMessage/auto-resize не потрібні. **[O]**

Iframe embed — за **офіційним контрактом продукту** (`IFRAME-BRIDGE-INTEGRATION.md`; ще не відпрацьовано в реальному лендінгу):
- [ ] `iframe-bridge.js` скопійовано без змін (з `assets/`), підключено ДО app-коду; `IframeBridge.init()` викликано один раз. **[R]**
- [ ] `loaded`/`height` відлітають автоматично; висота стабілізується — немає resize-петлі. **[R]**
- [ ] Жодних `100vh/svh/dvh`-розмірів (авторозмірний iframe = петля зворотного зв'язку). **[I]**
- [ ] Motion не залежить від внутрішнього скролу: IO-reveal-и + time-based ambient; без scrub/pin/Lenis. **[I]**
- [ ] Дії в продукті — через `sendMessage('event_action', '<id>')` (перелік id — від контент-менеджерів); зовнішні лінки — `<a target="_blank" rel="noopener noreferrer">`. **[R]**
- [ ] `token` — через `onParentMessage('token', …)`; `hasAuth/locale/theme` — з `IframeBridge.config`. Сам token НІКОЛИ не в query. **[R]**
- [ ] Домен лендінга у whitelist ядра або переданий через `init({ allowedParentOrigins })`. **[R]**
- [ ] Standalone-відкриття (без iframe/query) не ламається: `sendMessage` тихо ігнорується, дефолти застосовуються. **[R]**
- [ ] Заповнювати 100% ширини; ніколи не припускати фіксовану px-ширину. **[R]**

## Перед деплоєм (QA → Деплой)

- [ ] Справжній **production build** (`nuxi generate`) — вимірюй реальні розміри JS/CSS/HTML/шрифтів, ніколи не dev-режим. **[O]**
- [ ] Бюджети дотримані (напр. JS ≤ ~180KB gzip; худий `index.html` після субсету шрифтів). **[O]**
- [ ] Нуль console-помилок на збілдженому output. **[O]**
- [ ] LCP/CLS/reduced-motion/no-overflow — усе переперевірено на білді. **[O]**
- [ ] `experimental.payloadExtraction: false`, якщо роут — одна статична сторінка без даних. **[O]**
- [ ] Заміна шляхів асетів: кожен локальний `/img` `/video` → CDN URL, включно з динамічно побудованими шляхами (`prefix+name`, `${var}` шаблони). **[O]**
- [ ] **Валідуй трансформований білд**: запиши в temp-теку із symlink на `node_modules`, запусти `nuxi generate`, переконайся, що **0 локальних шляхів асетів** і очікувана кількість `@font-face`. **[O]**
- [ ] Кожен висновок adversarial-review перевірено на correctness/framework-validity/design-safety/net-win перед застосуванням. **[O]**
- [ ] Явний апрув на деплой отримано від стейкхолдера. **[O]**

## Після деплою (Деплой → Post-launch review)

- [ ] Деплой через deploy MCP з **пропущеним teamId** (передача його → 403). **[O]**
- [ ] **Перевір live URL**: curl/завантаж його — переконайся в наявності title, тексту CTA, референсів CDN-асетів, відсутності error-сторінки, відсутності console-помилок. **[O]**
- [ ] Шов вбудовування переперевірено в реальному продуктовому контексті (chrome + лендінг), а не лише standalone. **[O]**
- [ ] Spot-check адаптиву + reduced-motion на живому сайті. **[O]**
- [ ] Оновлено rework-лог; рішення, які варто було front-load-ити (обсяг зміни, mobile-трактування, motion-модель секції), зафіксовано для наступного лендінга. **[O]**
- [ ] Переглянуто таксономію аналітики/подій (цієї сесії був gap — заплануй, якщо потрібно). **[R]**
