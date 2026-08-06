# Branching Intake: опитувальник для промо-лендінгу

Мета опитування — не зібрати максимум інформації, а прибрати дорогі невідомі у правильному порядку.
Проводь його короткими раундами. Після кожного раунду відтворюй розуміння й називай blockers.

## 0. Routing — визнач маршрут за 5 хвилин

1. Для якого destination product робимо сторінку: CATBET чи SlotCity?
2. Де вона живе: всередині того самого продукту, на партнерському host-продукті чи standalone?
3. Тип задачі: нова promo-механіка, перезапуск існуючої, cross-brand traffic bridge чи інформаційна сторінка?
4. Чи вже погоджені продукт, GEO, аудиторія, механіка й legal copy?
5. Що треба віддати: Figma, окремі асети, код, live URL — у яких комбінаціях?

### Рішення

- Якщо продукт/GEO/ЦА відомі й незмінні — познач `Fast Track` і **не став повторні persona-питання**.
- Якщо host і destination різні — обов'язковий Brand Bridge.
- Якщо механіка або legal не зафіксовані — Product Truth стає blocker-ом до концепції.
- Якщо потрібен лише дизайн — не активуй implementation/deploy-гілку.

## Раунд 1. Бізнес і scope — ставиться завжди

1. Який один вимірюваний результат визначає успіх лендінгу?
2. Яка одна основна дія користувача? Який її точний destination URL/route?
3. Яка роль сторінки у воронці: пояснити, зацікавити, перевести, зареєструвати, активувати бонус?
4. Який traffic source і host? Чи бачить сторінку весь трафік або сегмент?
5. Які header, footer, navigation і overlays залишаються від host-продукту?
6. Які deliverables і viewport-и потрібні?
7. Хто апрувить продукт, дизайн, бренд, legal, аналітику й release?
8. Дедлайн і проміжні review dates?

**Вихід:** Project Brief, owner map, Full/Fast Track, Integration Boundary.

## Раунд 2. Product Truth і compliance — ставиться завжди

1. Хто ліцензований advertiser, який brand рекламуємо, де host і куди веде CTA?
2. Це same-brand, same-group cross-brand чи third-party relationship? Де письмове Legal confirmation?
3. Який channel/placement і як забезпечено 21+ та виключено спрямування на вразливі групи?
4. Дай canonical source механіки: актуальна promo page, rules, ticket або legal-документ.
5. Поясни механіку однією фразою, потім покроково без маркетингових прикрас.
6. Які числа, бонуси, thresholds, wager, строки й умови є обов'язковими?
7. Які claims уже погоджені **дослівно**, а які мають статус `APPROVED EDITABLE`?
8. Що заборонено рекламувати у цьому placement/GEO?
9. Які license, 21+, responsible gambling, dates і rules links обов'язкові? Що Legal вважає
   advertising unit для warning-area treatment?
10. Що робить користувач, якщо механіка залежить від верифікації, депозиту, місії або каналу?
11. Який головний приз/вигода має домінувати? Які деталі другорядні?
12. Хто й коли ставить `LEGAL APPROVED` для exact copy version і final URL?

### Mechanics Model

Для кожної сутності заповни:

| Сутність | Тригер | Вибір користувача | Нагорода | Умова | Строк | Джерело |
|---|---|---|---|---|---|---|
| Promo / Box / Mission | | | | | | |

Якщо дизайнер не може пояснити таблицю product owner-у без Figma, дизайн механіки починати рано.

**Вихід:** Placement Classification, Mechanics Model, Claims Matrix, Legal Block, do-not-advertise
list і review за [PlayCity copy rules](../PLAYCITY-COPYWRITING-RULES.md).

## Раунд 3. Brand і visual evidence

1. Дай Figma/design system кожного бренду з **точними node-id**, а не лише посиланням на файл.
2. Дай 3–5 live reference pages усередині host-продукту: типові й найкращі.
3. Дай canonical logos, fonts, CTA components, backgrounds, mascots, icons і 3D asset libraries.
4. Які елементи незмінні: форма персонажа, колір хутра, пропорції, знак, material, одяг?
5. Що можна адаптувати: поза, scene, props, lighting, costume, animation?
6. Якщо брендів два: що має відчуватися від host, а що від destination product?
7. Який один візуальний конфлікт треба розв'язати: палітри, маскоти, матеріали, типографіка?
8. Які минулі лендінги подобаються і **що саме**: тайтли, ритм, hero, картки, motion, density?
9. Які рішення не подобаються: бордери, glass, забагато кольорів, агресивний персонаж, обрізання?
10. Який hero medium: still, video, loop, interactive scene? Чи буде він анімований окремо?
11. Чи надано current Tone of Voice вибраного продукту? Якщо ні — познач `TOV PENDING` і не
    винаходь brand voice.

### Додатково для video hero

- Чи має бути текст у самому відео? За замовчуванням — ні.
- Де safe zone персонажів? Що може обрізатися по краях?
- На mobile відео `contain` без crop чи `cover` із погодженим alternate crop?
- Який poster, autoplay, mute, loop і reduced-motion fallback?
- Чи потрібні окремі шари для аніматора?

**Вихід:** evidence pack, Product KB snapshot, Brand Bridge, asset invariants.

Selected evidence реєструється через [Brand Archive](../brand-archive/README.md), а не лишається
набором посилань у чаті.

## Раунд 4. Контент, структура і CTA

1. Який approved текст є базою? Яке джерело має пріоритет при конфлікті?
2. Яке речення має запам'ятати користувач після hero?
3. Які 3–5 фактів достатньо для рішення? Що можна сховати в правила?
4. Яка правильна послідовність: hook → пояснення → механіка → вибір → додатковий офер → CTA → legal?
5. Де користувач природно готовий натиснути CTA? Які label-и для верхнього й нижнього CTA?
6. Які блоки заборонені: SEO text, FAQ, license card, final CTA, sticky CTA?
7. Чи потрібна numbering/progress-система? Що означає кожен номер?
8. Який блок має бути signature moment, а які повинні бути спокійними?
9. Наскільки деталізувати нагороди: headline, дві фрази, tier table або повні умови?
10. Які тексти не можна перефразовувати AI?

**Вихід:** Content Map, CTA Map, storyboard, content priority (`P0/P1/P2`).

## Раунд 5. Responsive, build, analytics і handoff

1. Контекстні viewport-и: host screenshot, content desktop 1440, mobile 440/430/375.
2. Чи актуальний зріз у `DEVICE-TEST-MATRIX.md`? Якщо ні — хто надає свіжий top-10?
3. Full-page embed, iframe чи component mount? Хто володіє scroll, height, background і navigation?
4. Який стек і версії? Де репозиторій? Які заборонені залежності?
5. Де живуть content, CTA routes, analytics ids і legal copy?
6. Які asset formats потрібні: transparent PNG, transparent WebP, AVIF/WebP, MP4/WebM?
7. Чи треба передати masters, prompt log, source references й окремі animation layers?
8. Які analytics events і cross-domain attribution потрібні?
9. Які performance budgets і device floor?
10. Де local preview, staging і production? Хто дає release approval?

**Вихід:** Technical Brief, Analytics Plan, Delivery Matrix, Release Route.

## Правила хорошого інтерв'ю

- Не став 40 питань одним повідомленням. Один раунд — максимум 5–10 коротких питань.
- Не перепитуй те, що можна прочитати у наданій Figma, live page або approved copy.
- Після відповіді відтворюй рішення: `Зафіксував X; відкритими лишилися Y і Z`.
- Не пропонуй візуальні рішення, доки не зрозуміла механіка.
- Якщо користувач дає новий reference, записуй, **яку роль** він виконує: identity, composition,
  material, typography, motion або content.
- Якщо feedback суперечить попередньому, найновіше явне рішення перемагає; Decision Log зберігає історію.

## Stop conditions

Зупини перехід до Concept, якщо:

- немає canonical source механіки;
- claims Matrix містить `BLOCKED` у P0-контенті;
- незрозуміло, який бренд володіє CTA/оболонкою;
- немає canonical mascot/logo/font source;
- немає точного primary CTA destination;
- legal просить рекламувати те, що заборонено у placement.

Зупини перехід до Build, якщо:

- не погоджено hero;
- немає повного desktop 1440;
- mobile 440/430/375 не спроєктовані;
- assets ще змінюють форму, стиль або формат;
- текст не має version/status;
- невідомий integration boundary.
