# Iframe-інтеграція: офіційний контракт продукту (IframeBridge)

> **Провенанс:** це технічна документація фронтенд-команди батьківського продукту щодо вбудовування
> промо-лендінгів через iframe (отримано 2026-07-16). Це — **авторитетний контракт**: реалізацію на боці
> продукту вже зроблено, лендінг має лише під'єднати ядро `iframe-bridge.js` і викликати `IframeBridge.init()`.
>
> **Статус у термінах методології:** сам контракт — факт (наданий командою продукту); його застосування в
> реальному лендінгу на нашому боці ще не відпрацьоване, тож адаптаційні розділи наприкінці позначені
> **Виведено**/**Рекомендовано**. Після першої реальної iframe-інтеграції — підняти мітки й версію (MINOR).
>
> Готове до копіювання ядро лежить у [`assets/iframe-bridge.js`](assets/iframe-bridge.js) — копіювати без змін.
> Узагальнена модель у §11 головного документа лишається довідкою; **для реальної інтеграції використовуй цей контракт.**

---

## Швидкий старт

1. Підключи в свій проєкт лендінга файл [`iframe-bridge.js`](#iframe-bridgejs-ядро-не-редагувати) без змін, **раніше** за свій власний скрипт — це "ядро", воно вже реалізує весь обов'язковий протокол (`loaded`, `height`, прийом `token`, перевірку `origin`).
2. У своєму скрипті (`app.js` або будь-якому іншому) виклич `IframeBridge.init()` — без цього виклику ядро не почне працювати.
3. Далі використовуй глобальний об'єкт `IframeBridge`, щоб:
   - надсилати власні `event_action`
   - отримувати `token`, коли він прийде від батьківської сторінки
   - читати `locale`/`theme`/`hasAuth` з query-параметрів через `IframeBridge.config`

```html
<script src="./iframe-bridge.js"></script>
<script src="./app.js"></script>
```

```js
// app.js
IframeBridge.init()
```

Після виклику `init()` більше нічого налаштовувати не треба — `loaded` і `height` відправляються автоматично.

---

## Публічний API (`IframeBridge`)

Все, з чим працює конкретний лендінг, зосереджено в одному глобальному об'єкті `window.IframeBridge`.

| Властивість                                    | Тип        | Опис                                                          |
|-------------------------------------------------|------------|------------------------------------------------------------------|
| [`init(options?)`](#ifamebridgeinitoptions)      | `function` | Ініціалізація ядра. Викликати один раз на початку `app.js`.       |
| [`config`](#iframebridgeconfig)                  | `object`   | Розпарсені query-параметри (`hasAuth`, `locale`, `theme`).        |
| [`sendMessage(type, payload)`](#iframebridgesendmessagetype-payload) | `function` | Надсилає повідомлення батьківській сторінці.        |
| [`onParentMessage(type, handler)`](#iframebridgeonparentmessagetype-handler) | `function` | Реєструє обробник вхідних повідомлень від батьківської сторінки. |

### `IframeBridge.init(options?)`

Ініціалізує ядро: підписується на `load`/`resize`, починає слухати повідомлення від батьківської сторінки, обчислює `parentOrigin`. **Обов'язково викликати один раз** на самому початку `app.js` — без цього `sendMessage`/`onParentMessage` не працюватимуть.

```js
IframeBridge.init()
```

Якщо лендінг треба вбудовувати на домені, якого немає у whitelist ядра за замовчуванням, передай його через `options.allowedParentOrigins`:

```js
IframeBridge.init({
  allowedParentOrigins: ['https://my-custom-landing-domain.com'],
})
```

Повторний виклик `init()` ігнорується — ініціалізація відбувається лише один раз.

| Параметр                     | Тип        | Обов'язковий | Опис                                                              |
|-------------------------------|------------|--------------|---------------------------------------------------------------------|
| `options.allowedParentOrigins`| `string[]` | Ні           | Додаткові origin, яким можна довіряти, — додаються до дефолтного whitelist ядра. |

---

### `IframeBridge.config`

Готовий об'єкт з уже розпарсеними query-параметрами. Доступний одразу після підключення скрипта, парсити query вручну не треба.

```js
console.info(IframeBridge.config)
// { hasAuth: true, locale: 'uk', theme: 'dark' }
```

| Поле      | Тип       | Опис                                                        |
|-----------|-----------|----------------------------------------------------------------|
| `hasAuth` | `boolean` | Прапорець "чи авторизований користувач" (з query-параметра `auth`). **Це не сам токен**, а лише ознака, чи варто його чекати. Токен приходить окремо через `IframeBridge.onParentMessage('token', ...)`. |
| `locale`  | `string`  | Поточна локаль користувача. За замовчуванням `'en'`.            |
| `theme`   | `string`  | Поточна тема оформлення. За замовчуванням `'light'`.            |

---

### `IframeBridge.sendMessage(type, payload)`

Надсилає повідомлення батьківській сторінці через `postMessage`. Якщо `parentOrigin` не вдалося визначити (наприклад, лендінг відкрито напряму, не в iframe) — повідомлення тихо ігнорується.

```js
IframeBridge.sendMessage('event_action', 'event_action/cashier')
```

| Аргумент  | Тип      | Опис                                                |
|-----------|----------|--------------------------------------------------------|
| `type`    | `string` | Тип повідомлення (`'loaded'`, `'height'`, `'event_action'` тощо). |
| `payload` | `any`    | Дані повідомлення, залежать від `type`.                |

> `loaded` та `height` ядро надсилає автоматично — самостійно викликати `sendMessage` для них не потрібно.

---

### `IframeBridge.onParentMessage(type, handler)`

Реєструє обробник для повідомлень, що приходять від батьківської сторінки. На кожен `type` — один обробник; повторна реєстрація того самого `type` перезаписує попередній.

```js
IframeBridge.onParentMessage('token', (payload) => {
  // payload: string | null
  // збережи токен і використовуй його для авторизованих запитів до свого бекенду
})
```

| Аргумент  | Тип        | Опис                                                    |
|-----------|------------|-------------------------------------------------------------|
| `type`    | `string`   | Тип повідомлення, яке слухаємо (наразі підтримується `'token'`). |
| `handler` | `function` | Викликається з `payload` кожного разу, коли приходить відповідне повідомлення. |

> Ядро вже перевіряє `origin`/`source` вхідних повідомлень — у самому `handler` додатково нічого перевіряти не треба.

---

## Параметри

Під час відкриття лендингу в iframe до URL автоматично додаються GET-параметри.

| Параметр      | Тип                  | Обов'язковий | Опис                                                        |
|---------------|----------------------|--------------|--------------------------------------------------------------|
| `auth`        | `'true' / 'false'`   | Так          | Прапорець, чи авторизований користувач. Сам токен через query **не передається** — див. `postMessage` нижче. |
| `locale`      | `string`             | Так          | Поточна локаль користувача (`uk`, `en`, `ru` тощо).           |
| `theme`       | `string`             | Так          | Поточна тема оформлення (`dark`, `light`).                    |
| `parentOrigin`| `string`             | Так          | Origin батьківської сторінки. Використовується як `targetOrigin` для відповідей через `postMessage`. |

Приклад:

```text
https://example.com?auth=true&locale=uk&theme=dark&parentOrigin=https%3A%2F%2Fyourapp.com
```

> Читати ці параметри вручну не потрібно — вони вже доступні через [`IframeBridge.config`](#iframebridgeconfig).

---

## PostMessage: лендінг → батьківська сторінка

```ts
type T_IframeMessage =
  | { type: 'loaded'; payload: undefined }
  | { type: 'height'; payload: number }
  | { type: 'event_action'; payload: string }
```

### `loaded` — обов'язкове

Надсилається автоматично одразу після повного завантаження лендингу. Самостійно викликати не потрібно.

### `height` — обов'язкове

Надсилається автоматично після завантаження сторінки та при кожній зміні висоти контенту. Використовується батьківською сторінкою для підстройки висоти iframe без появи внутрішнього скролу.

| Поле      | Тип      | Опис                                  |
|-----------|----------|-----------------------------------------|
| `payload` | `number` | Поточна висота контенту в пікселях.     |

### `event_action` — опціональне

Використовується для передачі дій із лендингу в основний застосунок (наприклад, відкрити касу поповнення).

```js
IframeBridge.sendMessage('event_action', 'event_action/cashier')
```

| Поле      | Тип      | Опис                  |
|-----------|----------|------------------------|
| `payload` | `string` | Ідентифікатор дії.    |

Повний перелік підтримуваних `event_action` — в окремій документації (Confluence / запит контент-менеджерам).

Для переходу на зовнішні домени краще використовувати нативний тег `<a>`, а не `event_action`:

```html
<a href="https://www.google.com" target="_blank">google</a>
```

---

## PostMessage: батьківська сторінка → лендінг

```ts
type T_ParentMessage =
  | { type: 'token'; payload: string | null }
```

### `token`

Приходить один раз, одразу після того, як лендінг надіслав `loaded`. Значення — `null`, якщо користувач не авторизований.

```js
IframeBridge.onParentMessage('token', (payload) => {
  // збережи токен і використовуй його для авторизованих запитів до свого бекенду
})
```

> Токен приходить лише з дозволеного `origin` — повідомлення з будь-якого іншого джерела ігноруються ядром автоматично.

---

## Мінімальний обов'язковий сценарій

Після завантаження лендинг повинен:

1. Викликати `IframeBridge.init()`.
2. Надіслати `loaded` — робиться автоматично.
3. Надіслати поточну висоту через `height` — робиться автоматично, і при кожній зміні розміру контенту теж.

Все це вже реалізовано в `iframe-bridge.js` — самому писати нічого не треба, окрім виклику `init()`.

Надсилання `event_action` та обробка `token` виконуються лише за потреби, у своєму `app.js`.

---

## Приклад лендінга

Структура файлів:

```text
/custom-promo/index.html
/custom-promo/iframe-bridge.js   ← ядро, копіювати без змін
/custom-promo/app.js             ← кастомна логіка конкретного лендінга
```

### `iframe-bridge.js` (ядро, не редагувати)

Перевіряє `origin`/`source` вхідних повідомлень, шле `loaded`/`height` автоматично, парсить query-параметри, надає публічний API.

```js
;(function () {
  // default whitelist, always active — extend it via IframeBridge.init() if needed
  const DEFAULT_ALLOWED_PARENT_ORIGINS = [
    'http://localhost:3000',
    'https://yourapp.com',
    // ...інші дозволені домени
  ]

  let allowedParentOrigins = [...DEFAULT_ALLOWED_PARENT_ORIGINS]
  let parentOrigin = null
  let initialized = false

  const parentMessageHandlers = {}

  const queryParams = new URLSearchParams(window.location.search)
  const config = {
    hasAuth: queryParams.get('auth') === 'true',
    locale: queryParams.get('locale') || 'en',
    theme: queryParams.get('theme') || 'light',
  }

  function resolveParentOrigin() {
    // read parentOrigin from the query string, trust it only if it's in the whitelist
    const requestedOrigin = queryParams.get('parentOrigin')
    parentOrigin = allowedParentOrigins.includes(requestedOrigin) ? requestedOrigin : null
  }

  function sendMessage(type, payload) {
    if (!parentOrigin) return
    window.parent.postMessage({ type, payload }, parentOrigin)
  }

  function sendHeight() {
    const height = Math.max(
      document.body.scrollHeight,
      document.documentElement.scrollHeight,
      document.body.offsetHeight,
      document.documentElement.offsetHeight
    )

    // type height
    sendMessage('height', height)
  }

  function initHeightReporting() {
    window.addEventListener('load', () => {
      sendMessage('loaded')
      sendHeight()
    })

    window.addEventListener('resize', sendHeight)

    new ResizeObserver(sendHeight).observe(document.body)
  }

  function handleParentMessage(e) {
    // still validate incoming messages independently — never trust the query param alone
    if (!allowedParentOrigins.includes(e.origin)) return
    // only accept messages sent from the actual parent window
    if (e.source !== window.parent) return

    const { type, payload } = e.data || {}
    const handler = parentMessageHandlers[type]
    if (handler) handler(payload)
  }

  function initParentMessages() {
    window.addEventListener('message', handleParentMessage)
  }

  // options.allowedParentOrigins — extra origins to trust, added on top of the defaults above.
  // Call this once from your app.js, before relying on sendMessage/onParentMessage.
  function init(options) {
    if (initialized) return
    initialized = true

    const extraOrigins = (options && options.allowedParentOrigins) || []
    allowedParentOrigins = [...DEFAULT_ALLOWED_PARENT_ORIGINS, ...extraOrigins]

    resolveParentOrigin()
    initHeightReporting()
    initParentMessages()
  }

  // public API for the custom part below
  window.IframeBridge = {
    init,
    config,
    sendMessage,
    onParentMessage(type, handler) {
      parentMessageHandlers[type] = handler
    },
  }
})()
```

### `app.js` (кастомна логіка лендінга)

```js
// initialize the bridge — required before sendMessage/onParentMessage will work.
// pass extra allowedParentOrigins here if this landing needs to be embedded
// on a domain that isn't in the bridge's default whitelist
IframeBridge.init({
  allowedParentOrigins: [],
})

console.info('Iframe config from query', IframeBridge.config)

// прийом токена від батьківської сторінки
IframeBridge.onParentMessage('token', (payload) => {
  console.info('Token received', payload ? payload.slice(0, 12) : null)
  // збережи payload і використовуй для авторизованих запитів
})

// відправка власних подій
document.getElementById('customButton').addEventListener('click', () => {
  IframeBridge.sendMessage('event_action', 'event_action/cashier')
})
```

### `index.html`

```html
<script src="./iframe-bridge.js"></script>
<script src="./app.js"></script>
```

---

## Часті питання

**Чому `origin` перевіряється, а не просто довіряємо всім повідомленням?**
Без перевірки будь-яка сторінка, яка знає URL лендінга, теоретично може надіслати підроблене повідомлення (наприклад, з чужим `token`). Перевірка `e.origin`/`e.source` гарантує, що повідомлення прийшло саме від батьківської сторінки, яка реально відкрила цей iframe.

**Чи можна не додавати `iframe-bridge.js`, а писати `postMessage` вручну?**
Можна, але не рекомендовано — `iframe-bridge.js` вже враховує всі security-нюанси (whitelist origin, throttling через `ResizeObserver`) і однаковий для всіх лендінгів, що спрощує підтримку.

**Чому `IframeBridge.init()` треба викликати вручну, а не він відпрацьовує сам?**
Ядро підключається одним файлом і не знає заздалегідь про домени конкретного лендінга. Явний виклик `init()` з `app.js` дозволяє передати додаткові `allowedParentOrigins`, якщо дефолтного whitelist недостатньо.

**Що робити, якщо потрібен новий тип повідомлення від батьківської сторінки?**
Додай його в `T_ParentMessage` на боці застосунку та обробай через `IframeBridge.onParentMessage('новий_тип', handler)` у своєму `app.js` — ядро (`iframe-bridge.js`) редагувати не потрібно.

**Якщо потрібні додаткові дані з боку батьківської сторінки (нові поля в query, нові типи `postMessage` тощо)?**
Такі зміни реалізуються на боці застосунку (команда батьківського застосунку), тож звертайтесь до розробників батьківського застосунку — самостійно додати новий тип вхідного повідомлення чи query-параметр без змін на боці батьківської сторінки не вийде.


---

# Адаптація до методології (наші розділи)

## A. Підключення в Nuxt 3 лендінг — Рекомендовано

Ядро — vanilla JS із глобальним `window.IframeBridge`, його треба завантажити **до** коду застосунку:

1. Поклади копію ядра в `public/js/iframe-bridge.js` (з [`assets/iframe-bridge.js`](assets/iframe-bridge.js), без змін).
2. Підключи його через `app.head` у `nuxt.config.ts` — head-скрипт виконується до hydration bundle:

```ts
// nuxt.config.ts
app: {
  head: {
    script: [{ src: '/js/iframe-bridge.js' }], // ядро; БЕЗ defer — має бути готове до app-коду
  },
},
```

3. Ініціалізація та обробка token — у client-плагіні:

```ts
// plugins/iframe-bridge.client.ts
declare global {
  interface Window {
    IframeBridge?: {
      init: (o?: { allowedParentOrigins?: string[] }) => void
      config: { hasAuth: boolean; locale: string; theme: string }
      sendMessage: (type: string, payload?: unknown) => void
      onParentMessage: (type: string, handler: (payload: unknown) => void) => void
    }
  }
}

export default defineNuxtPlugin(() => {
  const bridge = window.IframeBridge
  if (!bridge) return // standalone-відкриття без ядра — лендінг має працювати й так

  bridge.init() // + { allowedParentOrigins: [...] } якщо домен лендінга не в whitelist ядра

  let token: string | null = null
  bridge.onParentMessage('token', (payload) => { token = (payload as string) ?? null })

  return { provide: { iframeBridge: bridge, getToken: () => token } }
})
```

4. `IframeBridge.config` (`hasAuth`/`locale`/`theme`) читається одразу — придатне для умовного контенту
   (напр., різні CTA для авторизованих) ще до приходу token.

## B. Наслідки для motion-дизайну в авторозмірному iframe — Виведено (перевірити на першій реальній інтеграції)

Батько підлаштовує висоту iframe під `height`-повідомлення → **iframe не має внутрішнього скролу**.
Скролиться батьківська сторінка. З цього випливає:

- **`window`-scroll усередині iframe не рухається** → GSAP ScrollTrigger scrub/pin/parallax, прив'язані до
  скролу лендінга, **не спрацюють**. Lenis усередині iframe — теж безглуздий.
- **IntersectionObserver працює** і в cross-origin iframe: браузер кліпає перетин по top-level viewport →
  reveal-и, пауза offscreen-анімацій і lazy-медіа лишаються робочими. Тож для `INTEGRATION_METHOD = iframe`
  проєктуй motion як **IO-тригеровані reveal-и + time-based ambient + hover**, без scrub/pin. Це рішення
  фази Discovery/Концепція, не пізніше.
- **Заборони viewport-висоти:** `100vh/svh/dvh` в авторозмірному iframe = висота iframe = висота контенту →
  **петля зворотного зв'язку** (hero з `min-height:100svh` розтягує iframe → svh росте → знову росте
  контент). Розміри секцій — через контентні одиниці/`clamp()` у px/rem, не через viewport-висоту.
- `position: fixed` усередині iframe позиціонується відносно iframe (= весь документ), а не екрана
  користувача — «липкі» до екрана ефекти всередині iframe неможливі.

## C. CTA та навігація — Рекомендовано

- **Дія всередині продукту** (відкрити касу, реєстрацію тощо): `IframeBridge.sendMessage('event_action', '<id>')` —
  повний перелік id — у контент-менеджерів/Confluence (див. контракт вище).
- **Зовнішній перехід**: звичайний `<a href="…" target="_blank" rel="noopener noreferrer">` (за контрактом).
- Плейсхолдерів немає й тут: перелік `event_action`-id — це тепер частина Discovery-чекліста (як раніше «точні URL»).

## D. Доповнення до QA-чекліста iframe-інтеграції — Рекомендовано

- [ ] `iframe-bridge.js` підключено без змін, ДО app-коду; `IframeBridge.init()` викликано один раз.
- [ ] `loaded` і `height` відлітають автоматично (перевірити в DevTools → повідомлення у батька).
- [ ] Домен лендінга є у whitelist ядра або переданий через `init({ allowedParentOrigins })`.
- [ ] `token` обробляється через `onParentMessage('token', …)`; `null` = неавторизований — UI це переживає.
- [ ] `hasAuth/locale/theme` з `IframeBridge.config` застосовані (тема/локаль лендінга відповідає продукту).
- [ ] Жодних `100vh/svh/dvh`-розмірів; немає внутрішнього скролу; висота стабілізується (немає resize-петлі).
- [ ] Motion не залежить від внутрішнього скролу (IO-reveal-и працюють, scrub/pin відсутні).
- [ ] Standalone-відкриття (без iframe, без query-параметрів) не ламається: `sendMessage` тихо ігнорується, дефолти `locale/theme` застосовуються.
