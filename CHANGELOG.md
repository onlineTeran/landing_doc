# Changelog

Формат натхнено [Keep a Changelog](https://keepachangelog.com/); версіонування — semver-подібне
(див. [`EVOLVING-THE-METHODOLOGY.md`](EVOLVING-THE-METHODOLOGY.md)).

## [1.12.0] — 2026-07-29

### Added
- SMARTICO — **ГОЛОВНЕ ПРАВИЛО «межа iframe»** винесено на початок документа, до
  всіх прикладів: усередині iframe продукту `_smartico.dp()` викликати заборонено
  (віджет це `position: fixed` оверлей — відкриється обрізаним у вбудованому
  блоці). Дію делегуємо через `event_action/smartico/<dp>`. Три випадки
  (standalone / батько підтвердив / підтвердження немає), обмеження парсера
  продукту, безкоштовне рукостискання через `token`, і чого канал не дає.
- SMARTICO §12 — правило фільтрації міні-ігор: `getMiniGames()` не фільтрує
  нічого, таблиця полів (`flow_builder_only`, `only_in_custom_section`,
  `activeFromDate`/`activeTillDate` у ms, `visibile_when_can_spin`), сортування
  за `priority`, і що артворк лежить у `thumbnail`, а не в `ui_definition.img`.

### Changed
- `assets/EVENT-ACTIONS.md` — рядок Smartico уточнено (RAW, без `/` і `?`) з
  робочим прикладом виклику.

### Fixed
- Усунено суперечність між документами: §11 радив лендінгу викликати `dp()`
  самому, тоді як `EVENT-ACTIONS.md` увесь час документував
  `event_action/smartico/:id`. Ця розбіжність коштувала трьох ітерацій Daily Hub
  і двох релізів, де віджет відкривався всередині 250px-фрейму. Локальний `dp()`
  тепер явно позначений як «лише для standalone».

## [1.11.0] — 2026-07-29

### Added
- SMARTICO §11 Deep links `dp:` — повний перевірений каталог (`dp:gf_missions`,
  `&id=`, `&opt_in=true`, `dp:gf_saw&id=`, `dp:gf_jackpots`, `dp:gf_section&liquidParams=`…),
  guard-патерн (dp() падає мовчки) і застереження: доки «модалка деталей місії» офіційно не
  обіцяна, це може бути повний екран — залежить від скіна бренду.
- SMARTICO §12 Міні-ігри (SAW) і джекпоти — `getMiniGames({onUpdate})`, `playMiniGame`,
  `miniGameWinAcknowledgeRequest`, `jackpotGet` (без onUpdate). Зафіксовано неіснуючі
  `getSawMiniGames`/`getJackpots` і друкарську помилку `visibile_when_can_spin` в самому API.
  ⚠ Кільце «4/7 депозитів» НЕ має джерела в `getMiniGames` — кроки приходять з CMS оператора.
- SMARTICO §13 Події віджета — `gf_starting`/`gf_closing` (найкраще атестовані), `gf_ux`
  з конфліктом написання `screen_subname_id` vs `screen_sub_name_id`, повний список подій.

Джерело: help.smartico.ai/.../deep-links + github.com/smarticoai/public-api. Кожне твердження
перевірено другим незалежним проходом; 22 з 25 викликів підтверджено дослівно, 0 спростовано,
2 позначені як непідтверджені прямо в тексті.

## [1.10.1] — 2026-07-22

### Changed
- IFRAME §E переписано за реальним запуском: правильний рецепт — margin-left:
  max((100%−maxW)/2, rail) ЛИШЕ на .container (full-width декор не чіпати); padding на root —
  зафіксований анти-патерн (зсував усе, ламав hero, відкочено).

## [1.10.0] — 2026-07-22

### Added
- IFRAME-BRIDGE-INTEGRATION.md §E — safe-area під overlay-хром хоста (Спостережено: сайдбар
  продукту налазив на контент): паддінги root дзеркалом брейкпоінтів хрому продукту, розміри
  в CSS-змінних; застереження про media queries в iframe (міряють ширину iframe).

## [1.9.0] — 2026-07-17

### Milestone: iframe + сторонні платформи → Спостережено
- Ланцюг «продукт → токен у iframe → user id → API сторонньої платформи» відпрацьовано end-to-end
  на реальному проді (Smartico: місії авторизованого користувача).

### Added
- **`SMARTICO-INTEGRATION.md`** — інтеграція гейміфікації Smartico у iframe-лендінг (усе Спостережено):
  бутстрап (`_smartico.api` = null до init-хендшейку → чекати; зміна user id після init не працює;
  vapi для гостя); **отримання id авторизованого користувача крізь межу iframe** — токен продукту
  лежить у cookie на його origin і cross-origin недоступний, тож приходить лише через контракт
  iframe (postMessage token) → id дістається JWT-декодом на клієнті або через `{apiBase}/profile/info`
  (Bearer); **блокер №1 — origin лендінга у whitelist лейбла** (інакше identify мовчки не проходить,
  getMissions таймаутиться — симптом як «немає авторизації»); форма `TMissionOrBadge`, повний API
  місій (getMissions/requestMissionOptIn/requestMissionClaimReward); діагностика-first (тест-блок
  завжди видимий + сирий лог усіх postMessage); Discovery-питання й чекліст; правило безпеки токена.

## [1.8.0] — 2026-07-17

### Added
- **`ANIMATION-PATTERNS.md`** — словник motion-патернів: левітація, паралакс, entrance/reveal,
  fade-in lazy-картинок, scrub-journey (+embedded-заміна time-based fill), marquee, ambient-дрейф,
  обертання, мікро-інтеракції. Головне правило «один власник на властивість на елемент»
  (Спостережено: shorthand `animation:` fade-in фолбека перекрив власні анімації картинок, а
  `animation: none` вимкнув їх назавжди; фікс — fade лише через opacity+transition і окрема
  обгортка під паралакс). Таблиця поведінки кожного патерна в embedded і reduced-motion.
- **`DEVICE-TEST-MATRIX.md`** — аналітика аудиторії як QA-гейт адаптиву (Спостережено, зріз
  2026-07): 100% mobile; Android 64% депозитів / iOS 36% (iOS «важчий» за гроші → Safari-регресії
  high-severity); топ-браузери (Chrome Mobile 60%, Mobile Safari 24%, ~5% in-app/WebView);
  топ-10 viewport-ів 360–440px з найважчою точкою 360×800 (бюджетні Android). Правило: адаптив
  перевіряється на топ-10 реальних розширень зі зрізу, не на «стандартних» брейкпоінтах.

### Спостережено (референсний лендінг)
- Паралакс усередині iframe не працює принципово: вікно iframe не скролиться (скрол у батька),
  ScrollTrigger не отримує подій — скрол-залежні ефекти в embedded пропускати або замінювати
  time-based варіантами.

## [1.7.0] — 2026-07-16

### Added
- **`CLAUDE-BOOTSTRAP.md`** — сценарій «порожня папка → Claude Code з методологією»: submodule
  на тег версії, шаблон CLAUDE.md нового лендінгу, встановлення й аудит скілів (INSTALLED_SKILLS.md,
  застереження версій фреймворку), стартовий бриф через LANDING-PROMPT-TEMPLATE, Definition of Ready.

### Changed
- **Повне знеособлення**: прибрано всі прив'язки до першого (референсного) лендінгу — назви
  кампанії/бренду, тематичні приклади (декор, назви CTA) замінено на generic-плейсхолдери
  (`<landing-name>`, `<brand>`, `<promo-term>`). Методологія тепер придатна для будь-якого
  наступного лендінгу без контексту попереднього.
- README: версія в шапці синхронізована з VERSION; «Швидкий старт» починається з кроку 0
  (CLAUDE-BOOTSTRAP).

## [1.6.0] — 2026-07-16

### Milestone: iframe-інтеграція → Спостережено
- Контракт IframeBridge відпрацьовано end-to-end на реальному стейджі продукту: авторозмір (~5300px),
  event_action, локаль. Блокер запуску був один — origin whitelist (продукт слав усе правильно).

### Added
- **`DEPLOY-AND-LAUNCH.md`** — runbook деплою і запуску (все Спостережено): git→Vercel як єдиний
  деплой-флоу (замість інлайн-передачі через AI-канал, яку рвуть 529); мультилендінговий Vercel-патерн
  (buildCommand ≤256 → npm script; NITRO_PRESET=static; compose-outdir); CDN-адреси закріплені в сорсі
  (репо == прод; Vite падає на нерезолвлених /img); заборона приватних submodules; біллінг-гігієна
  (SSR-деплой лендінга палить ISR Writes — тільки статика); порядок запуску iframe (origin-и продукту
  ДО першого тесту, hosted test-parent, діагностика через консоль iframe); таблиця 10 реальних
  інцидентів симптом→причина→фікс; go-live чекліст.

## [1.5.0] — 2026-07-16

### Added
- **`CONTENT-CONFIG.md`** — контент-система (Спостережено на референсному лендінгу): тексти в
  `content/copy.json` (блок → ключ → {ua, ru}, редагує копірайтер), кнопки в `content/actions.json`
  (label{ua,ru} + `ga`-мітка для аналітиків + action), `useCopy()` з locale продукту за контрактом,
  hydration-правило (локаль/auth/канал — ПІСЛЯ mount через app:mounted hook), процес хендофу
  копірайтеру, чекліст. CTA-AND-LINKS: лейбли кнопок переїхали в content-шар.

### Спостережено (референсний лендінг)
- Секції з власним opaque-фоном ховають глобальний декоративний фон (fixed-канвас/засвіти) — фон секцій має бути
  transparent (локальні дублі декору прибрано разом із opaque-фоном секції).
- Спред computed без `.value` (`[...items]`) — краш SSR «items is not iterable».
- Після `nuxi generate` в каталозі запущеного dev-сервера ламається `.nuxt`/Vite dep-кеш
  (`#app-manifest`) — лікується `rm -rf .nuxt node_modules/.vite` + рестарт.

## [1.4.0] — 2026-07-16

### Added
- **`assets/EVENT-ACTIONS.md`** — офіційна таблиця «Універсальні івенти» продукту (відновлена з PDF
  продуктової команди, SC+CB, Web/iOS/Android): усі `event_action`-id по розділах (auth/каса/
  верифікація/акції/профіль/ігри/бонуси/турніри/info), шаблони `:term`/`:id`/`section?subsection`,
  логіка auth-редіректу на боці продукту, deprecated-список. Закриває Discovery-пункт «перелік
  event_action-id» — тепер id беруться звідси, лише кастомні `promotions/:term` підтверджуються
  контентом. Лінки з IFRAME-BRIDGE-INTEGRATION §C та README.

### Спостережено (референсний лендінг)
- `scroll-behavior: smooth` у CSS несумісний з Lenis (вимога доки Lenis): браузер анімує кожен крок
  Lenis → лаг/дрейф позиції. Правило: з Lenis — тільки нативний scroll-behavior.
- Hosted test-parent (`/test-parent.html` на домені лендінгів, origin у whitelist) — обовʼязковий
  артефакт деплою: єдиний спосіб показати embed робочим без стенда продукту.

## [1.3.1] — 2026-07-16

### Added
- **`assets/IFRAME-BRIDGE-README.md`** — дослівний оригінал контракту фронтенд-команди (байт-в-байт,
  sha256 106e8b37…): канонічне джерело; анотована версія при розбіжностях поступається оригіналу.
- `IFRAME-BRIDGE-INTEGRATION.md`: **правило строгої відповідності** — лендінг шле лише типи з
  `T_IframeMessage`; нові типи (analytics_event) — тільки після підтвердження продуктом, до того канал
  вимкнено прапорцем; `hasAuth/locale/theme` в embedded — строго з `IframeBridge.config` (контрактні
  дефолти en/light), власні дефолти — лише standalone. Спостережено на референсному лендінгу.

## [1.3.0] — 2026-07-16

### Added
- **`CTA-AND-LINKS.md`** — керування кнопками й лінками через конфіг: усі дії (URL, `event_action`-id)
  в одному типізованому `config/actions.ts`; `useCtaAction()`-резолвер каналу за середовищем
  (`<a>` / `target="_top"` в iframe / `sendMessage('event_action')` / anchor, з `fallbackHref` для
  standalone); єдиний `<CtaButton action-id>` з обов'язковим `analyticsId`; правила станів кнопок.
  Зміна лінка = правка одного рядка конфігу, не компонента.
- **`GA-ANALYTICS-SPEC.md`** — GA4-специфікація для передачі продуктовим аналітикам: naming/ліміти GA4,
  словник подій із власниками (лендінг ніколи не шле `page_view`), спільні параметри
  (`landing_id`/`embed_mode`/`locale`/`theme`/`has_auth`; без PII/token), канали доставки за режимом
  вбудовування (full-page → `dataLayer` продукту; iframe → тип повідомлення узгодити з продуктом),
  `useAnalytics()`-адаптер «один track() → один канал», UTM/consent-правила, хендоф-чекліст.

### Changed
- §15 головного документа, `PHASE-PROMPTS.md` §14, `CHECKLISTS.md` (Discovery, секції, pre-deploy),
  `IFRAME-BRIDGE-INTEGRATION.md` §C — зшито з новими документами: `cta_id` в аналітиці == `analyticsId`
  у конфігу дій за побудовою; перелік `event_action`-id — пункт Discovery.

## [1.2.0] — 2026-07-16

### Added
- **`IFRAME-BRIDGE-INTEGRATION.md`** — офіційний контракт продукту для iframe-інтеграції (ядро
  `IframeBridge`: авто `loaded`/`height`, `event_action` → батько, `token` ← батько, query
  `auth/locale/theme/parentOrigin`, origin-whitelist) + наші адаптаційні розділи: підключення в Nuxt 3
  (head-script + client-плагін), наслідки для motion в авторозмірному iframe (без внутрішнього скролу →
  без scrub/pin/Lenis, лише IO-reveal + time-based; заборона `100vh/svh/dvh` через resize-петлю),
  мапінг CTA (`event_action` vs `<a target="_blank">`), QA-чекліст.
- **`assets/iframe-bridge.js`** — готове до копіювання ядро (копіювати в лендінг без змін).

### Changed
- §11 головного документа: банер про авторитетний контракт (він має пріоритет над узагальненою моделлю;
  формат повідомлень `{type, payload}`, прапорець `auth` у query дозволений — сам token у query ніколи).
- `CHECKLISTS.md`: iframe-блок переписано під офіційний контракт.
- `PHASE-PROMPTS.md` §13: у промпт додано вказівку на контракт і його пріоритет.

## [1.1.0] — 2026-07-16

### Added
- **`ICON-GENERATION-METHODOLOGY.md`** — методологія генерації AI-іконок (style lock, reference icon,
  optical sizes, true alpha, safe area, export matrix, повний QA). Дистильована з практичного досвіду
  генерації в ChatGPT; мітки гармонізовано під конвенцію пакета (Спостережено/Виведено/Рекомендовано).
  Крос-реф додано в §9 головного документа та в README.
- README: розділ **«Як підключити до нового лендінгу»** (submodule, запінений на тег; клонування з
  `--recurse-submodules`; оновлення версії; degit-альтернатива) і розділ **«Як доопрацьовувати
  методологію прямо з лендінгу»**.
- `EVOLVING-THE-METHODOLOGY.md` §5.1 — повний **submodule-flow доопрацювання з лендінгу**: швидкий
  режим (push у main) і безпечний (гілка + PR), правила проти detached HEAD і незакріплених комітів.

## [1.0.0] — 2026-07-16

### Added
- Перша версія методології (9 документів + README + процес еволюції): 18-розділовий головний документ,
  покроковий workflow, per-phase prompts, master-prompt зі змінними, чеклісти, шаблони decision-log і
  ретроспективи, starter-архітектура, аналіз Claude Code скілів/агентів/інструментів.
- Дистильовано з реального промо-лендінгу (Nuxt 3 SSG / Vue 3 / TS). Ключові патерни, винесені як
  правила: measured-band мобільний motion; same-period + phase-spread циклічні рухи (доведено симуляцією);
  font-subset аудит (index.html 54KB→14.6KB gzip); defer heavy video (IO-gated, `preload=none`, Save-Data);
  LCP = preloaded poster; пауза offscreen ambient-анімацій; CDN-хостинг асетів для inline-деплою;
  verify-by-simulation + adversarial «verify-before-fix».
- Українська локалізація як єдине джерело; код/токени/технічні терміни лишаються англійськими.

### Notes / відомі обмеження
- Референс-проєкт інтегрувався як **full-page embed** (хедер/футер продукту, без iframe). Тому весь
  **iframe**-матеріал позначено `Рекомендовано`/`Виведено`, ще не `Спостережено`. Перше відпрацювання
  iframe на реальному лендінгу → підвищення до `Спостережено` і версія MINOR.
- Ще не відпрацьовано на практиці: реальний iframe/parent-контракт, шар аналітики (event taxonomy),
  локальний медіа-тулчейн (транскод/subset на диску), content-config шар.
