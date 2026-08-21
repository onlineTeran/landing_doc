---
name: promo-landing-framework
description: Покрокове планування, дизайн, виробництво асетів, реалізація, QA та реліз бренд-точних промо-лендінгів CATBET або SlotCity, зокрема продуктових промо, вбудованих сторінок і кросбрендових переходів.
---

# Framework промо-лендінгів

Проведіть проєкт через продуктову правду, бренд-докази, візуальне погодження, asset freeze, реалізацію,
QA та реліз. Джерелом правди є поточні артефакти проєкту, а не пам’ять чату.

Спочатку визначте корінь методології: у репозиторії лендінгу використовуйте `./methodology/`; якщо поточний
репозиторій сам містить `EXECUTION-PROTOCOL.md`, використовуйте його корінь. Усі scripts і runbooks
методології шукайте від цього кореня, не припускаючи, що обидві структури існують одночасно.

## Завантаж джерела

Читайте [gates.md](references/gates.md) для кожного нового проєкту або зміни фази.

За потреби прочитайте:

- [product-routing.md](references/product-routing.md) — під час вибору CATBET/SlotCity або поєднання брендів.
- [artifact-contracts.md](references/artifact-contracts.md) — під час intake, handoff або status review.
- [review-rubric.md](references/review-rubric.md) — до вибору напряму, погодження асетів або QA.
- [corporate-git.md](references/corporate-git.md) — до зміни `landings.json`, відкриття корпоративного
  MR, підготовки Stage/Production deploy, rollback або видалення.

Якщо проєкт містить рекламу азартних ігор, активуйте репозиторний skill `playcity-copy-review` до G2 і
повторно перед релізом. Прочитайте Product KB, snapshot Brand Archive і Tone of Voice вибраного бренду;
якщо ToV ще очікується, не вигадуйте його. Активуйте `brand-design-base` для бренд-доказів, візуальних
напрямів, виробництва арту, вибору компонентів і visual QA. Погодження арту не замінює послідовні гейти лендінгу.

## Визнач маршрут запиту

Виберіть один scope:

1. **Full Track:** новий продукт/GEO/аудиторія/механіка/host або відсутні brand/legal evidence.
2. **Fast Track:** відомі продукт і аудиторія, погоджені mechanic/copy, наявні host і бренд-джерела.
3. **Phase-only:** користувач просить одну обмежену фазу; завантажте попередні погоджені артефакти й не
   відкривайте їх повторно, якщо суперечність не блокує потрібну фазу.

Для Fast Track пропустіть зайві запитання про продукт/GEO/персону. Однак перевірте механіку, claims,
маршрут CTA, бренд-інваріанти, межі інтеграції та deliverables.

## Створи контрольну поверхню

Створіть або оновіть `PROJECT-STATE.md`, що містить:

- бренд хоста, продукт призначення й режим інтеграції;
- основну конверсію й точний destination CTA;
- поточну phase/gate;
- посилання owner/status/version для кожного артефакта;
- відкриті питання, рішення й change requests.

Після кожної суттєвої відповіді користувача оновлюйте контрольну поверхню й зазначайте решту блокерів.
Виконуйте `<methodology-root>/EXECUTION-PROTOCOL.md` як робочий цикл. Кожна фаза має завершуватися
репозиторним артефактом, доказом перевірки та зафіксованим рішенням людини; відповідь у чаті не завершує фазу.

## Проведи intake раундами

Ставте не більше 5–10 коротких запитань за раунд:

1. scope/business/deliverables;
2. механіка/claims/legal;
3. brand/visual evidence/assets;
4. content/story/CTA;
5. responsive/integration/analytics/release.

Не розпитуйте користувача про факти, які можна отримати з наданого джерела. Спочатку перевірте точні
Figma nodes, live-сторінки, погоджений copy та канонічні асети. Призначте кожному візуальному референсу
роль: identity, style, composition, typography, material, motion, mechanics або legal.

## Зафіксуй продуктову й legal-правду

Створіть:

- Mechanics Model, що розділяє trigger, вибір користувача, sequence/tier, reward, умову й час;
- Claims Matrix зі статусами `APPROVED VERBATIM`, `APPROVED EDITABLE`, `PENDING`, `PROHIBITED`, `EXPIRED`
  і `SUPERSEDED`;
- порядок пріоритету джерел і окремий для кампанії список do-not-advertise.

До погодження copy класифікуйте рекламодавця, рекламований бренд, host, destination, channel, позначення
21+ і юридичні зв’язки між брендами. Legal wording і продуктова правда мають вищий пріоритет, ніж аргумент
кампанії та Tone of Voice бренду.

Ніколи не вигадуйте, не виводьте зі старого арту й не переписуйте мовчки актуальні числа, tiers, wager,
дати, умови винагород, legal-текст або маршрути CTA. Зупиніть концепт, якщо P0 claims чи механіки заблоковані.

## Зафіксуй бренд-докази

Завантажте знання вибраного продукту й актуальні канонічні джерела. Для кросбрендового лендінгу створіть
Brand Bridge, який визначає відповідальність за chrome, background/container, CTA, typography, mascot,
матеріали асетів, motion і legal.

Зафіксуйте правила immutable/adaptable/forbidden для кожного канонічного маскота, логотипа, персонажа
хоста, CTA і сімейства асетів. Ніколи не замінюйте канонічного персонажа типовим двійником.

## Спочатку дизайн, потім build

Дотримуйтеся такого порядку:

1. content map і storyboard;
2. рівно три візуальні напрями на основі зображень і зафіксованих джерел;
3. вибір одного напряму за review rubric;
4. дизайн і погодження Hero, включно з mobile/video framing;
5. дизайн повної content-only сторінки на 1440, 440, 430 і 375;
6. окремий context frame із chrome хоста для embedded-сценарію;
7. freeze повного дизайну до генерації production-асетів або коду.

Не створюйте каркас, не реалізуйте компоненти й не оголошуйте дизайн готовим лише за текстовим описом.
Не сприймайте mobile як зменшений desktop. Великий логотип не компенсує слабку продуктову візуальну мову.

## Створи ассети

До генерації створіть Asset Register. Для кожного асета вкажіть реальний розмір слота, ролі референсів,
identity lock, camera/material/light, alpha/background, safe area, mobile-варіант, animation layers,
формат master/delivery і ліміт ваги.

Перед генерацією сімейства погодьте один style-lock асет. Зберігайте точні prompts, references, mode,
output та історію коригувань. Перевіряйте справжній alpha, забруднення країв, оптичну вагу й вигляд у
реальному слоті на 1440/440/430/375. Відхиляйте raw-генерації, видимі прямокутники та style drift.

## Реалізуй погоджений target

Використовуйте зафіксований стек проєкту; за замовчуванням — Nuxt 3 + Vue 3 + TypeScript + SSG.
Залишайте `app.vue` тонким, обмежуйте scope стилів, розділяйте content/actions/legal/analytics config і
не додавайте chrome хоста до content-only коду.

Зберігайте погоджений copy, відповідальність за CTA-компонент, ідентичність асетів і responsive layouts.
Будь-який redesign під час реалізації стає change request і повторно відкриває відповідні design-гейти.

До реалізації заповніть `FUNCTIONAL-SPEC.md`. Змоделюйте кожну інтеграцію (включно зі Smartico)
зі станами loading, empty, partial, error, unauthorized і success, точним API/SDK ownership, межею
secrets, allowlists, analytics та acceptance tests.

## Проведи QA з доказами

Проведіть три окремі проходи:

1. content/legal truth;
2. visual fidelity через об’єднані порівняння target/implementation в однаковому viewport;
3. технічна поведінка на 1440/440/430/375 і виведена з аналітики top-10 матриця пристроїв.

Підтвердьте відсутність missing assets і horizontal overflow, помилок console/hydration, правильний ratio
відео, реальні маршрути CTA, reduced-motion, повний legal-текст і analytics events. Після виправлень
повторіть візуальне порівняння; один screenshot не є QA. Створіть `QA-TASK.md` для точного build під тестом
із functional IDs, передумовами, кроками, очікуваними результатами, покриттям device/browser, test data й evidence.

## Реліз лише після погодження

Сприймайте Stage і Production як окремі зовнішні дії. Stage deploy можливий після G9 лише з явним Stage
approval, бо Stage evidence потрібен для G10; він не дає дозволу на Production. До публікації завершіть
локальні зміни, production build, тести, visual QA, погодження legal/brand/product/analytics і підготовку
live-route. Вимагайте явне release approval для точної версії й target. Дочекайтеся terminal result deploy,
потім перевірте публічний URL без owner-only authentication. У `GIT-DELIVERY.md` зафіксуйте branch, commit
SHA, CI, явне approval, target, rollback і post-deploy smoke evidence. Дозвіл на реалізацію не є дозволом
на push, merge або deploy. Для `cb/ai_landings` перевірте `landings.json`, збережіть Stage-approved build
identity, вимагайте ручні Stage і Production jobs та окремо зафіксуйте Stage QA і Production smoke у `RELEASE-TASK.md`.

## Зафіксуй навчання

Після релізу зафіксуйте пізні зміни, повторно згенеровані асети, блокери, розбіжності design/build, дані
воронки й повторно використовувані знання. Оновіть знання CATBET/SlotCity, шаблони або цей skill, а не
залишайте урок лише в чаті кампанії.
