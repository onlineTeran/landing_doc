# Інтеграція Smartico (гейміфікація) у лендінг: місії, user id, підводні камені

> Призначення: як з лендінгу (що працює як iframe усередині продукту) під'єднати гейміфікацію-
> платформу **Smartico** і показати місії/бейджі авторизованого користувача власним UI — без
> дефолтного віджета Smartico. Головна складність не в API місій, а в **отриманні id
> авторизованого користувача крізь межу iframe**. Усе нижче — **Спостережено** на реальному
> продукті (ланцюг token → user id → getMissions відпрацьовано end-to-end), якщо не позначено інакше.
> Мітки: **Спостережено** / **Виведено** / **Рекомендовано**.

---

---

## ⛔ ГОЛОВНЕ ПРАВИЛО: межа iframe

**Якщо код працює всередині iframe продукту — `_smartico.dp()` викликати ЗАБОРОНЕНО.**

Віджет Smartico це оверлей: `position: fixed` усередині iframe позиціонується
відносно **iframe**, а не сторінки. Тож віджет відкриється обрізаним усередині
вбудованого блоку (у Daily Hub — усередині 250px). Виглядає як «нічого не
працює», хоча дія відпрацювала.

Замість цього дію делегуємо батьківському продукту:

```js
IframeBridge.sendMessage('event_action', `event_action/smartico/${deepLink}`)
```

**Спостережено** (продакшн-бандл `catbet.com.ua/_static/build/BoYNaukL.js` →
`g8WYdFKN.js`, і живий запит `GET /event_action/smartico/dp:gf_missions` → `302`
+ cookie `event_action`): продукт приймає повідомлення, розбирає payload і
викликає `window._smartico.dp(...)` **на своїй сторінці**. Інстансом Smartico
володіє продукт.

Обмеження парсера продукту (`payload.replace(/^\//,'').split('/')`, третій
сегмент обрізається по `?`):

- префікс `event_action/` **обов'язковий** — потрібно ≥2 сегменти, інакше тихий no-op;
- `dp:`-стрічку слати **як є, БЕЗ `encodeURIComponent`** — гілка `smartico` не декодує;
- `&`, `=`, `{`, `}`, `"` проходять; структурні лише `/` і `?`;
- `dp:go&url=https://…` через цей канал **недосяжний** (`//` розриває payload);
- дія `isUser: true` — неавторизованому продукт відкриє **модалку логіну**,
  збереже дію в cookie на 30 с і перевикличе після входу.

**Три випадки, які треба розрізняти в коді:**

| Контекст | Що робити |
|---|---|
| Standalone-сторінка (`window.parent === window`) | локальний `_smartico.dp()` — оверлей володіє всім в'юпортом, це коректно |
| В iframe, батько підтвердив, що слухає | `sendMessage('event_action', …)` |
| В iframe, підтвердження ще немає | `window.open('https://<product>/event_action/smartico/<dp>', '_top')` — 302 + cookie, плагін продукту виконає дію після завантаження |

Рукостискання безкоштовне: на `loaded` продукт **безумовно** відповідає `token`
(payload `null` для гостя). Будь-який отриманий `token`-фрейм доводить, що
слухач живий і origin-перевірки проходять в обидва боки. Окремого типу
повідомлення для цього не треба.

**Чого канал НЕ дає:** підтвердження виконання. `dp()` падає мовчки, повідомлення
fire-and-forget, події віджета (`gf_starting`/`gf_closing`/`gf_ux`) спрацьовують
на інстансі ПРОДУКТУ і в iframe не потрапляють без нового типу повідомлення,
який може додати лише команда продукту.

> Історія, щоб не повторювати: цю відповідь знайшли на третій ітерації Daily Hub,
> уже після двох релізів, де віджет відкривався всередині 250px-фрейму. При цьому
> `assets/EVENT-ACTIONS.md` документував `event_action/smartico/:id` увесь цей
> час, а §11 нижче радив викликати `dp()` самому. Два документи суперечили один
> одному — тому це правило тепер стоїть тут, до всіх прикладів коду.

---

## 0. Коли це потрібно

Оператор уже використовує Smartico (місії, бейджі, турніри, лідерборди, магазин балів), а промо-
лендінг хоче показати місії користувача **своїм дизайном** (не вбудованим віджетом Smartico).
Лендінг рендериться як iframe на **своєму** origin, продукт — на своєму.

## 1. Ключі та завантаження скрипта

Smartico ініціалізується трьома значеннями оператора: `labelKey`, `brandKey`, URL скрипта.
**Де взяти (Спостережено):** на живому сайті оператора — у конфізі сторінки трапляється
`smartico:{ labelKey:"…", brandKey:"…", scriptUrl:"…" }`, або в мережі — завантаження
`libs.smartico.ai/smartico.js` (лейбли часто мають CDN-копію на кшталт `…cloudfront.net/sN.js`).

```js
// loader (verbatim з help.smartico.ai, extended integration):
(function (d, r, b, h, s) { h = d.getElementsByTagName('head')[0]; s = d.createElement('script'); s.onload = b; s.src = r; h.appendChild(s); })(
  document, SCRIPT_URL, function () {
    window._smartico.init(LABEL_KEY, { brand_key: BRAND_KEY })
  },
)
```

**Рекомендовано:** вантажити скрипт **лениво** (лише коли блок гейміфікації реально потрібен), не в
head лендінга — це важкий third-party, не місце в LCP-шляху промо-сторінки.

## 2. Порядок бутстрапа (важливий — кожен крок Спостережено)

```
1) window._smartico_user_id = <ext_user_id | null>   ← ДО завантаження скрипта
   window._smartico_language = 'uk'                    (ISO 639-1)
2) <script smartico.js>  →  _smartico.init(labelKey, { brand_key })
3) дочекатись, поки з'явиться window._smartico.api     ← НЕ синхронно!
4) _smartico.api.getMissions({ onUpdate }) → TMissionOrBadge[]
```

- **`_smartico.api` = null до завершення init-хендшейку** (Спостережено: одразу після `init()`
  `api` ще `null`, звідси `Cannot read properties of null`). Чекати появи `_smartico.api`
  (або `_smartico.checkSuccessfullyIdentify() === true`) поллінгом ~250ms.
- **Зміна user id після init не працює** — ядро логує `init for already initialised session.
  Skipped`. Інший користувач = перезавантаження сторінки / нова ініціалізація.
- **Анонім:** `window._smartico.vapi(lang).getMissions()` (visitor mode). Але **місії показуються
  лише авторизованому** — для гостя список зазвичай порожній; ставку робити на авторизованого.

## 3. ⭐ Отримання id авторизованого користувача крізь межу iframe (головний урок)

**Проблема (Спостережено):** місії Smartico потребують `ext_user_id` — id користувача в системі
оператора. У продукту токен авторизації лежить у **cookie/сховищі на origin ПРОДУКТУ**. Лендінг —
iframe на **іншому** origin, тож cross-origin він цю cookie **прочитати не може** (політика браузера).

**Рішення:** id приходить крізь межу iframe **тільки** через явну передачу від продукту:

1. Продукт передає **токен** дитині через контракт iframe-інтеграції (postMessage; у нашому
   контракті — `onParentMessage('token', payload)`). Без цього лендінг про користувача не знає.
2. Лендінг дістає `ext_user_id` **з токена** двома способами (за пріоритетом):
   - **Декод JWT на клієнті** (найпростіше, без мережі): `id` зашитий у payload токена
     (Спостережено: типові поля `user_id` / `sub` / `uid` / `id` / `player_id`). Підпис НЕ
     перевіряємо — потрібен лише id; токен нікуди не надсилаємо, не логуємо, не зберігаємо.
   - **Фолбек — профільний ендпоінт продукту:** `GET {productApiBase}/profile/info` з заголовком
     `Authorization: Bearer {token}` → у відповіді id. Крос-оріджин → **потрібен CORS** на боці
     продукту; токен шлемо ЛИШЕ на його ж origin.

```ts
// декод id з JWT (payload = друга частина, base64url); підпис не перевіряємо
export function extractUserIdFromToken(token: string): string | null {
  try {
    const payload = token.split('.')[1]
    if (!payload) return null
    const b64 = payload.replace(/-/g, '+').replace(/_/g, '/')
    const json = JSON.parse(
      new TextDecoder().decode(
        Uint8Array.from(atob(b64 + '='.repeat((4 - (b64.length % 4)) % 4)), (c) => c.charCodeAt(0)),
      ),
    )
    for (const k of ['user_id', 'userId', 'player_id', 'ext_user_id', 'uid', 'id', 'sub']) {
      if (typeof json[k] === 'string' && json[k]) return json[k]
      if (typeof json[k] === 'number') return String(json[k])
    }
    return null
  } catch {
    return null
  }
}
```

**Безпека (Спостережено-правило):** токен — секрет. Тримати лише в пам'яті (реактивний стан),
**не** логувати, **не** класти в localStorage/URL/query, **не** надсилати нікуди, крім власного
origin продукту. У діагностиці показувати лише факт «токен отримано» і довжину, не значення.

## 4. ⭐ Блокер №1 запуску: origin whitelist лейбла Smartico

**Спостережено (найважливіше для запуску):** навіть з правильним user id `getMissions`
**мовчки таймаутиться**, якщо origin лендінга не в whitelist лейбла Smartico. WebSocket-канал
відкривається, `INIT` проходить (приходять `settings`), але **identify не завершується** — і
місій немає. Симптом ідентичний «немає авторизації».

- Діагностика (Спостережено): перехопити `WebSocket.prototype.send`/`onmessage` — видно `INIT`
  (cid 3) і `settings`, але не видно успішного identify.
- Фікс: **додати origin деплою лендінга** (напр. `https://<landing-host>`) у whitelist лейбла на
  боці Smartico/адміністратора продукту. `localhost` майже завжди не в whitelist → локально
  завжди «блокує», і це **очікувано**; фінальна перевірка — тільки в iframe на проді.

## 5. Форма об'єкта місії (для рендера)

`TMissionOrBadge` (verbatim з `github.com/smarticoai/public-api`, `src/WSAPI/WSAPITypes.ts`):

| Поле | Тип | Для UI |
|---|---|---|
| `id` | number | ключ, opt-in/claim |
| `type` | `'mission' \| 'badge'` | фільтр |
| `name` / `sub_header` / `description` | string | заголовок/підзаголовок/опис |
| `image` | string (256×256) | іконка |
| `reward` | string | нагорода (текст) |
| `is_completed` / `is_locked` | boolean | стан |
| `is_requires_optin` / `is_opted_in` | boolean | чи треба «взяти участь» |
| `unlock_mission_description` | string | умова розблокування |
| `time_limit_ms` / `active_from_ts` / `active_till_ts` / `dt_start` | number\|null | таймінги |
| `progress` | number (%) | прогрес-бар |
| `cta_action` / `cta_text` | string | кнопка (напр. `dp:deposit`) |
| `tasks[]` | TMissionOrBadgeTask[] | підзадачі: `progress`, `execution_count_expected/actual`, `points_reward`… |

- `onUpdate` віддає **повний оновлений масив** (не дифи) — перерендерюй з нього.
- Кеш ядра ~30s; серверний push `RELOAD_ACHIEVEMENTS_EVENT` = «дані змінились, перезапитай».

## 6. Повний API місій (surface)

```ts
_smartico.api.getMissions({ onUpdate?: (data: TMissionOrBadge[]) => void }): Promise<TMissionOrBadge[]>
_smartico.api.requestMissionOptIn(mission_id: number): Promise<{ err_code, err_message }>
//   0=ok · 40010=вже opted-in (трактувати як успіх) · 105=невірний id/видимість · 40013=не opt-in-able
_smartico.api.requestMissionClaimReward(mission_id: number, ach_completed_id: number): Promise<…>
//   передумови: is_completed && requires_prize_claim && !prize_claimed_date_ts && вікно claim не минуло
_smartico.vapi(language: string).getMissions()   // visitor mode (гості; Success Manager)
```

Суміжне на тому ж `api`: `getBadges`, `getTournamentsList`, `getLeaderBoards`, `getStoreItems`,
`getBonuses` — та сама механіка (чекати `api`, ловити timeout, whitelist).

## 7. Діагностика-first (як не бути сліпим у чужому iframe)

**Спостережено-патерн:** на етапі інтеграції зробити тест-блок **завжди видимим у embedded** з:
1. реактивною панеллю: `embedded / hasAuth / bridged / token отримано / user id`;
2. **сирим логом усіх `postMessage` від батька** (`window.addEventListener('message')`, тільки
   логування типів, значення токенів скорочувати) — одразу видно, чи/що продукт реально шле;
3. ручними шляхами: ввести `ext_user_id` напряму або вставити токен — щоб пройти ланцюг
   `token → id → getMissions` не чекаючи, поки продукт довиставить передачу токена.

Це знімає найбільшу проблему — «нічого не працює, і не видно чому».

## 8. Discovery-питання продуктовій команді (запитати ДО інтеграції)

- `labelKey`, `brandKey`, URL скрипта Smartico (prod і stage окремо).
- Формат токена: JWT? Яке поле містить `ext_user_id`? Приклад декодованого payload (без реальних даних).
- Продукт **точно передає токен** у iframe за контрактом (`token` postMessage)? Коли (після login)?
- Профільний ендпоінт як фолбек (`{apiBase}/profile/info`) — чи відкритий CORS для origin лендінга?
- **Origin лендінга доданий у whitelist лейбла Smartico?** (блокер №1)
- Чи потрібен auth-hash для identify, чи достатньо `ext_user_id`?

## 9. Чекліст інтеграції

- [ ] Ключі знайдено; скрипт вантажиться лениво, не в LCP-шляху.
- [ ] Бутстрап: глобали → init → **чекати `_smartico.api`** → getMissions (не викликати api синхронно).
- [ ] user id береться з токена (JWT-декод; фолбек profile/info); токен лише в пам'яті, не логується.
- [ ] Origin лендінга у whitelist лейбла (інакше silent timeout — перевірено в iframe на проді).
- [ ] Місії рендеряться з `onUpdate` (повний масив); стани completed/locked/opt-in враховані.
- [ ] Тимчасовий тест-блок прибрано перед релізом (він службовий і не в дизайні лендінга).

## 10. Прибирання тест-блоку

Тест-інтеграцію тримати ізольовано (окремий компонент + composable, позначені як «прибрати»),
щоб після підтвердження прибрати одним рухом. Постійна фіча гейміфікації — окрема, чиста
імплементація вже без діагностичного обвісу.

## 11. Deep links `dp:` — керування віджетом Smartico ззовні

**Спостережено** (перевірено проти офіційної сторінки
`help.smartico.ai/welcome/products/tools-and-guides/deep-links`; кожен рядок нижче знайдено
в документації дослівно, незалежним другим проходом).

Коли власний UI не має покривати все, віджет Smartico відкривається однією стрічкою:

```js
// ⛔ Лише для standalone-сторінок. В iframe — див. ГОЛОВНЕ ПРАВИЛО вгорі.
// dp() — це стрічковий роутер: помилка в назві падає МОВЧКИ, без throw і без
// значення, що повертається. Тому виклик завжди через guard.
if (window._smartico?.dp) _smartico.dp('dp:gf_missions');
```

| Дія | Що відкриває |
|---|---|
| `dp:gf` | головний екран гейміфікації (**не** місії) |
| `dp:gf_missions` | екран місій |
| `dp:gf_missions&id=123` | конкретну місію |
| `dp:gf_missions&id=123&opt_in=true` | місію + одразу opt-in |
| `dp:gf_missions&category=completed` | категорію місій |
| `dp:gf_section&id=329&liquidParams={"mission_id":123}` | кастомну секцію з місією всередині |
| `dp:gf_saw` / `dp:gf_saw&id=19` | Spin The Wheel / конкретний шаблон міні-гри |
| `dp:gf_jackpots` / `dp:gf_jackpots&id=123` | джекпоти / конкретний шаблон |
| `dp:gf_tournaments`, `dp:gf_store`, `dp:gf_badges`, `dp:gf_levels`, `dp:gf_activity`, `dp:inbox`, `dp:gf_clans`, `dp:gf_board&type=`, `dp:gf_bonuses&section=`, `dp:gf_matchx`, `dp:gf_quiz`, `dp:gf_raffle` | відповідні екрани |
| `dp:go&url=…&target=_blank` | зовнішнє посилання |

**Виведено:** документація каже лише «Opens mission with specific ID» — слова «модалка» там
немає. Чи це попап, чи повний екран, залежить від скіна бренду. Не обіцяй продукту модалку,
поки не побачив її на їхньому лейблі.

Альтернатива для вбудовування без оверлея — `_smartico.showWidget(type, params?)`, де `type` ∈
`missions | mini-game | achievements | tournaments | store | inbox | match-x-2 | quiz |
custom-section | inbox-widget | ui-widget | liquid`. Форма `params` **не задокументована**, тож
націлитись на конкретну місію через нього не вийде.

## 12. Міні-ігри (SAW) і джекпоти

**Спостережено** (офіційні `github.com/smarticoai/public-api` README + `docs/ui/minigames/`).

### ⛔ ПРАВИЛО: «лише модалка» = кастомна секція, а не екран місій

`dp:gf_missions&id=N` відкриває **весь віджет** — Smartico вставляє айфрейм
`gf/Achievements3.html?bridgeId=GamificationMain` на всю сторінку (1042×751 на
стейджі) і вже в ньому показує деталі місії зверху. Обв'язку віджета цим
викликом прибрати не можна.

**Спостережено** (жива сесія, stage.slotcity.ua, 2026-07-30): кастомна секція з
liquid-шаблоном рендериться інакше — компактна панель по центру, затемнений фон,
з елементів керування лише хрестик. Тобто «тільки модалка» — це секція:

```js
// весь віджет + деталі всередині
_smartico.dp('dp:gf_missions&id=' + missionId)

// сама лише модалка (секція з liquid-шаблоном)
_smartico.dp(`dp:gf_section&id=${sectionId}&liquidParams={"mission_id":${missionId}}`)
```

`liquidParams` слати **як є**: фігурні дужки, лапки, `=` і `&` проходять крізь
парсер продукту, структурні лише `/` і `?`.

Ціна: секцію та її шаблон створює оператор у бек-офісі Smartico. Тому в коді це
має бути конфігом із фолбеком на `dp:gf_missions&id=`, а не жорстким вибором.

**Перевірено й відкинуто** (щоб не шукали вдруге): `showWidget('missions', …)` з
трьома формами параметрів і `gamificationBlock({ container })` не рендерять
нічого; URL айфрейма віджета несе тільки `bridgeId`, тож екран задається
повідомленням через міст, а не адресою — з клієнта він не адресується.

**Побічно закрито:** подія `gf_ux` на живому лейблі приходить із полем
`screen_subname_id` (написання з репо, а не `screen_sub_name_id` з хелп-центру).
Екран місій — `screen_name_id: 2`, кастомна секція — `23` + `custom_section_id`.

### ⛔ ПРАВИЛО: міні-ігри рендеряться на рівні СЕКЦІЙ, не шаблонів

`getMiniGames()` **нічого не фільтрує** — повертає ВСІ шаблони лейбла (трансформ
SDK це голий `map`). Але фільтрувати їх за прапорцями шаблона — **пастка**.

**Спостережено** на живому лейблі SlotCity (авторизована сесія, stage, 2026-07-30):
33 шаблони, з них `flow_builder_only` — у **0**, `only_in_custom_section` — у **32**.
Тобто фільтр, який випливає з документації SDK, лишив би **одну** гру і спорожнив
би блок.

**Поле, яке насправді відповідає «чи допущена гра до проду», — `custom_section_id`,
звірений із `getCustomSections()`.** Шаблони посилаються на 14 секцій, з яких
опублікованих лише 7; у 7 «сиротинських» лежать саме зняті кампанії
(BLACK FRIDAY 1/2, BLACK DROP, LoveBox, test box, Щоденний бонус дроп, Test_New).

```js
const [sections, games] = await Promise.all([
  _smartico.api.getCustomSections(),   // тільки опубліковані
  _smartico.api.getMiniGames(),        // геть усі шаблони
])
// одна плитка на СЕКЦІЮ, а не на шаблон
const tiles = sections
  .map(sec => ({ sec, own: games.filter(g => g.custom_section_id === sec.id) }))
  .filter(x => x.own.length)
```

Це ще й той рівень, який показує сам продукт: кругла іконка — це `menu_img`
секції, підпис — `menu_name`, а тап відкриває `dp:gf_section&id=<id>`, не окремий
шаблон.

**Порожній стан беремо в оператора, не вигадуємо:** `no_attempts_message` шаблона
містить його власний текст («Виконуй місії для отримання спроб»). Обрізати краще
через CSS, повний рядок лишати в `title`.

Решта корисного по шаблону:

| Поле | Сенс |
|---|---|
| `thumbnail` | артворк 256×256, ніколи не порожній (**не** `ui_definition.img` — такого поля не існує) |
| `activeFromDate` / `activeTillDate` | epoch **ms**, не множити; невиставлене приходить як Long-сентинел ±9223372036854775807 |
| `saw_template_ui_definition.priority` | сортування, менше = вище |
| `saw_template_ui_definition.flow_builder_only` | доступна лише з кампанії |
| `section_type_id` (у секції) | на цьому лейблі `5` — секції міні-ігор; тестове сміття мало `10`/`11` |

Полів статусу (Active/Draft/Archived) у публічному об'єкті **немає**: сирий
`is_visible` не переживає трансформ.

```js
_smartico.api.getMiniGames({ onUpdate: cb }).then(games => …)
_smartico.api.playMiniGame(template_id, { acknowledge })  // → { err_code, request_id, prize }
_smartico.api.miniGameWinAcknowledgeRequest(request_id, { lose: true })
_smartico.api.getMiniGamesHistory() / playMiniGameBatch()
_smartico.miniGame(saw_template_id, params?, pending_message_id?)   // standalone-режим
_smartico.api.jackpotGet({ related_game_id? })   // ⚠ onUpdate тут НЕ підтримується
_smartico.api.jackpotOptIn / jackpotOptOut / getJackpotWinners / getJackpotEligibleGames
```

Поля стану міні-гри: `spin_count`, `next_available_spin_ts`, `saw_buyin_type`,
`buyin_cost_points|gems|diamonds`, і — так — `visibile_when_can_spin` (**друкарська помилка
в самому API Smartico**, писати саме так).

**Не існує:** `getSawMiniGames()`, `getJackpots()`. Правильні імена — `getMiniGames` і `jackpotGet`.

**⚠ Пастка, що коштувала часу:** кільце прогресу навколо іконки міні-гри на слот-сіті
(«4/7 депозитів для активації») **не має джерела в `getMiniGames`**. Там є `spin_count`, а не
крок 0–7. Ці кроки приходять з CMS оператора й джойняться до прогресу окремої *місії*. Або
підключай цей фід, або малюй бінарний стан «доступно / недоступно» з реальних полів — але не
вигадуй проміжні кроки.

## 13. Події віджета

**Спостережено.** `_smartico.on(key, handler, params?)` / `_smartico.off(key, handler)`:

- `gf_starting`, `gf_closing` — найкраще задокументовані (є і в help-центрі, і в репо);
  `gf_started` є лише в репо. Для «відкрито/закрито» бери першу пару.
- `gf_ux` — навігація всередині віджета: `{ screen_name_id, screen_subname_id, entity_id,
  custom_section_id }`. **Конфлікт написання:** help-центр показує `screen_sub_name_id`, репо —
  `screen_subname_id`. Залогуй payload один раз, перш ніж покладатись на ключ.
- Решта: `saw_starting`, `inbox_starting`, `mini_game_win`, `jackpot_win`, `ach_game_opening`,
  `init`, `label_init_completed`, `identify`, `login`, `logout`, `props_change`,
  `page_navigation`, `session_based_dp_detected`, `protocol_error`.

Окремої події «відкрито деталі місії» немає — якщо треба знати, що юзер туди дійшов,
підписуйся на `gf_ux` і читай `screen_name_id` / `entity_id`.
