# Case Study: BETON × CATBET traffic-bridge landing

Це process retrospective, а не reusable visual template. Конкретні claims і promo mechanics треба
перевіряти заново.

Exact host/product/design/asset sources and slot contracts are recorded in
[BETON-CATBET-ASSET-MAP.md](BETON-CATBET-ASSET-MAP.md).

## 1. Задача

- Замінити інформаційну сторінку на BETON кастомним embedded landing.
- Залишити header/footer/navigation BETON.
- Зацікавити користувачів партнерським CATBET і перевести їх через CTA до реєстрації.
- Використати погоджений legal-copy з наявної сторінки як головне джерело.
- Зробити hero як окреме анімоване відео без тексту; текст і CTA — HTML нижче.
- Віддати content-only desktop 1440, mobile 430/375, окремі assets і Nuxt/Vue implementation; новий
  framework додає 440 як обов'язковий mobile design target із реальної матриці.

## 2. Що спрацювало

### Чіткий cross-brand bridge

Персонаж BETON тримає canonical CATBET cat; бетон стає фізичним постаментом/середовищем для CATBET
об'єктів. Це дало обом брендам роль без 50/50 змішування всього UI.

### Host-native CTA

CATBET offer не став причиною винаходити нову кнопку. Салатова/фіолетова CTA з BETON design system
залишила сторінку частиною host-продукту.

### Product-specific asset language

Після підключення точних Figma nodes і reference icons іконки стали волохатими, об'єкти — оптично
узгодженими, а title language — CATBET-specific, не generic casino.

### Static design → element extraction → Nuxt

Коли дизайн став цілісним, окремі assets можна було підготувати з альфою, інтегрувати й перевірити.
Final build пройшов desktop/mobile QA та public deployment.

## 3. Де втрачався час

### 3.1 Механіку зрозуміли надто пізно

Перші візуали змішували deposit sequence, CatBox package tier і reward. Користувач уточнив: пакет —
це рівень за сумою, а людина взаємодіє з механікою протягом п'яти депозитів. Висновок: Mechanics Model
потрібний до storyboard і numbering.

### 3.2 Legal змінив доступний контент

Візуально опрацьований `місяць без депозитів` довелося видалити з рекламного placement. Пізніше legal
block повернувся в іншій формі наприкінці сторінки. Висновок: Claims Matrix зі статусами й версіями,
а не переписка, має бути source of truth.

### 3.3 Brand invariants не були записані на старті

AI робив котів іншої форми, накачаними або в різному стилі; іконки не мали спільної волохатої фактури.
Висновок: mascot invariants + one approved style lock icon до масової генерації.

### 3.4 Красивий isolated asset не гарантує інтеграцію

З'являлися чіткі прямокутні краї CatBox images, black backgrounds, glossy toy concrete і різна optical
weight іконок. Висновок: alpha QA, real-slot contact sheet і side-by-side page review до asset freeze.

### 3.5 Full-page design gate був недостатньо жорстким

Після початку верстки ще змінювалися порядок блоків, secondary offer, step icons, material, marker,
hero blending і legal. Висновок: G7 має вимагати весь 1440/440/430/375 із фінальним legal volume.

### 3.6 Hero/video contract сформувався ітеративно

Потрібно було окремо уточнити: no text in video, central safe zone, edges may crop, потім навпаки — на
mobile не crop; video має бути full-width, без border, з radial edge blend, а наступний блок заходить на
відео. Висновок: framing map і object-fit contract до анімації.

### 3.7 Відступи й бордери маскували відсутність системи

Перші sections були окремими bordered cards і відчувалися різними промо-банерами. Після видалення
бордерів, ущільнення vertical rhythm і повторення матеріалів сторінка стала ціліснішою.

## 4. Рішення, що стали правилами Framework 2.0

| Спостереження | Нове правило |
|---|---|
| Product/GEO/ЦА вже відомі | Fast Track пропускає зайве дослідження, але не Product Truth/Brand/Legal |
| Approved copy був головним | Claims Matrix має precedence і `verbatim` status |
| Два бренди | Обов'язковий Brand Bridge |
| Hero анімуватиметься окремо | Layer/animation/framing requirements у Asset Register |
| Mascot drift | Identity reference + immutable/adaptable/forbidden table |
| Icon style drift | One approved real-slot style lock + family contact sheet |
| Візуали з фоном | Alpha channel validation і real-background QA |
| Deposit number ≠ tier | Mechanics Model до IA |
| CTA мала лишитися BETON | Host CTA owner записується у Brand Bridge |
| Mobile title/button завеликі | 440/430/375 повністю дизайняться до коду |
| Reveal animation дратувала | Motion не застосовується глобально за замовчуванням |
| Deploy потрібен після всіх правок | Release approval — окремий зовнішній гейт |

## 5. Рекомендований порядок для наступного схожого лендінгу

1. Fast Track routing.
2. Canonical promo/legal source + Mechanics Model + Claims Matrix.
3. Capture BETON/host chrome and CTA component.
4. Load CATBET or SlotCity Product KB and exact Figma nodes.
5. Brand Bridge with 2–3 anchors from each brand and one bridge device.
6. Content map with P0/P1/P2 detail level.
7. Three image-based directions; select one.
8. Hero contract and approval, including mobile/video framing.
9. Full static design 1440/440/430/375 + final legal.
10. Asset Register, style lock, generation, alpha/slot QA.
11. Nuxt implementation without host chrome.
12. Side-by-side design QA, runtime QA, analytics QA.
13. Explicit release approval, publish and live verification.

## 6. Artifact checklist from the case

- Host context design.
- Content-only 1440.
- Content-only 440/430/375 у наступних проєктах; у цьому кейсі фактично було 430/375.
- Hero video + poster.
- Transparent mission/step/CatBox/podium assets.
- Prompt log and asset references.
- Nuxt content-only implementation.
- Public URL without owner-only auth.
- Final legal copy.
- QA report.

## 7. Outcome

Фінальний результат став значно кращим не через більшу кількість ефектів, а через точні source assets,
правильну механіку, один cross-brand сюжет, host-native CTA, матеріальну цілісність і повний responsive QA.
Саме ці рішення перенесено у Framework 2.0.
