# Design Process: як отримати стильний, брендово точний лендінг

Головна помилка generic AI-процесу — попросити «зроби красивий лендінг» після текстового брифа. Модель
заповнює прогалини середнім інтернет-стилем. Цей процес замінює смакові побажання evidence-based
артдирекшном і серією візуальних гейтів.

## 1. Evidence before ideas

До концепції зберіть Reference Pack:

| Тип джерела | Мінімум | Що витягуємо |
|---|---:|---|
| Product design system / Figma | 1 файл + точні node-id | fonts, colors, CTA, grid, surfaces |
| Canonical asset library | 1 | logos, mascot invariants, icon/3D style |
| Host live pages | 2–3 | chrome, background, container, section rhythm |
| Best-in-class promo pages цього бренду | 2–3 | ambition level, titles, density, motion |
| Approved content/legal source | 1 | claims, wording, required legal text |
| Mechanic source | 1 | correct hierarchy and step logic |

Reference Pack реєструється у selected [Brand Archive](../brand-archive/README.md): exact node/path,
source status, rights, owner, last verified і роль. Figma URL у чаті без capture/version не закриває G3.

Для кожного reference запишіть роль: `identity`, `composition`, `typography`, `material`, `iconography`,
`motion`, `mechanics` або `legal`. Посилання без ролі майже завжди починають використовувати не за
призначенням.

## 2. Product Truth board

До Figma створіть один board із чотирма зонами:

1. **One conversion:** мета, primary CTA, destination.
2. **Mechanic:** проста схема та пріоритет винагород.
3. **Claims:** approved verbatim / editable / pending / prohibited.
4. **Content hierarchy:** P0 must-see, P1 supporting, P2 rules-only.

Board апрувлять product і legal. Дизайнер не вирішує product truth композицією.

Copy проходить [PlayCity review](../PLAYCITY-COPYWRITING-RULES.md) до Brand ToV. У storyboard
зберігайте claim IDs, щоб art direction не створила заборонену обіцянку невербально.

## 3. Brand Bridge для кросбрендового лендінгу

Не змішуйте 50/50 дві айдентики. Призначте ролі:

| Шар | Host brand | Destination brand | Рішення проєкту |
|---|---|---|---|
| Header/footer/navigation | зазвичай 100% | 0% | |
| Page background / container | зазвичай host | може впливати локально | |
| CTA component shape/states | host | label веде у destination | |
| Offer typography | | часто destination | |
| Mascot / reward objects | | destination | |
| Scene / metaphor | може бути bridge | може бути bridge | |
| Legal / responsible gaming | placement owner | destination details | |

### Bridge formula

Визначте:

- **Host anchors (2–3):** елементи, завдяки яким сторінка органічно живе у host.
- **Destination anchors (2–3):** елементи, завдяки яким одразу видно промо-продукт.
- **One bridge device:** один сюжетний прийом, який фізично з'єднує бренди.
- **One exclusion:** що навмисно не змішуємо.

Приклад bridge device: персонаж host тримає canonical mascot destination; матеріал host стає
постаментом для reward objects destination. Це краще за випадкову суміш логотипів і кольорів.

## 4. Brand invariants і degrees of freedom

Створіть таблицю до ImageGen:

| Елемент | Immutable | Adaptable | Forbidden |
|---|---|---|---|
| Mascot | колір, форма, пропорції, обличчя | поза, approved одяг, props | нове тіло, інша порода, hypertrophy |
| Logo | знак, пропорції, clear space | scale, muted background use | перерисовка, деформація |
| CTA | форма, height, typography, states | label, placement | новий gradient/radius |
| Icon family | material, camera, lighting, fur length | предмет і secondary color | style drift між іконками |
| Host character | identity markers | поза й interaction | заміна generic-персонажем |

Цей документ стає частиною кожного generation prompt і review rubric.

## 5. Три візуальні напрями — тільки як зображення

Не приймайте prose-only directions. Кожен із трьох варіантів має містити:

- desktop above-the-fold mock;
- міні-фрагмент механіки або card language;
- palette roles з реальними brand colors;
- type specimen з реальними шрифтами;
- asset/material sample;
- mobile hero treatment;
- одну головну метафору;
- один контрольований ризик;
- anti-slop list.

Варіанти мають бути різними системами, а не одним layout у трьох палітрах.

### Scorecard напряму

Оцінка 1–5:

| Критерій | Вага |
|---|---:|
| Brand truth і впізнаваність | 25% |
| Ясність офера за 5 секунд | 20% |
| Сила bridge між брендами | 15% |
| Візуальна ієрархія та читабельність | 15% |
| Mobile viability | 10% |
| Asset feasibility / animation readiness | 10% |
| Distinctiveness без gimmick | 5% |

Direction не проходить, якщо brand truth або offer clarity нижче 3, незалежно від суми.

## 6. Hero gate

Hero проєктується й погоджується окремо до всієї сторінки.

### Hero contract

- роль: hook, не повний legal/механічний опис;
- одна dominant composition;
- characters/key object всередині погодженої mobile-safe zone;
- фон підтримує, не конкурує;
- logo не використовується як компенсація слабкої айдентики;
- video не містить тексту, якщо текст має лишатися HTML;
- CTA стоїть у природному decision moment і є host-native;
- poster і reduced-motion state погоджені;
- mobile crop/contain рішення визначено до анімації.

### Hero review

Перевіряйте в контексті host chrome і без нього. Показуйте мінімум:

- desktop із host header/navigation;
- content-only 1440;
- 440, 430 і 375;
- перший і останній кадр loop;
- frame із найширшим жестом/рухом;
- fallback poster.

## 7. Content architecture і storyboard

Кожна секція має одну роботу. Для промо traffic bridge типовий скелет:

1. Hero video/key art.
2. Approved intro + primary CTA.
3. Headline offer / core promise.
4. Short mechanics (`як це працює`).
5. Choice/progression visual.
6. Main reward або secondary promo.
7. Optional trust/supporting benefit.
8. Legal and responsible gaming.

Це не фіксований шаблон: FAQ, SEO text, license card або final CTA можуть бути заборонені brief-ом.
Рішення фіксується в Content Map.

### Section card

Для кожної секції заповніть:

- job-to-be-done;
- P0/P1/P2 content;
- approved copy ID;
- dominant visual;
- CTA presence/label/id;
- desktop layout;
- mobile layout;
- motion purpose;
- asset IDs;
- legal note;
- acceptance checks.

## 8. Full-page design gate

До коду потрібно погодити:

1. усю сторінку в контексті host chrome;
2. content-only desktop 1440;
3. content-only mobile 440;
4. content-only mobile 430;
5. content-only mobile 375;
6. interaction/motion notes;
7. legal block у фінальному обсязі;
8. CTA states і реальні labels;
9. asset map.

Не погоджуйте desktop, якщо mobile існує лише як словесна обіцянка.

## 9. Правила візуальної цілісності

- Один material vocabulary на asset family.
- Один accent має домінувати; другий використовується для смислових наголосів.
- Кольори host CTA не переписуються під destination без рішення Brand Bridge.
- Не обрамляйте кожен блок бордером. Відділяйте секції ритмом, фоном, масштабом або композицією.
- Повторювані картки мають однакову оптичну вагу, а не лише однаковий bounding box.
- Title style може бути expressive; body і legal лишаються максимально читабельними.
- Signature art один або два на сторінку. Решта підтримує.
- Decorative paws, fish, yarn, particles тощо мають системну роль і бюджет, а не заповнюють порожнечу.

## 10. Feedback protocol

Перетворюйте фразу на атомарні зміни:

| Feedback | Нормалізований change request |
|---|---|
| «Іконки жахливі» | звірити material/camera/light з node X; перегенерувати IDs A–E; preserve silhouette |
| «Кнопка низько» | підняти CTA у viewport; зберегти host component; перевірити 1440/440/430/375 |
| «Все синє» | застосувати orange лише до semantic emphasis; CTA лишити host lime |
| «Відео обрізане» | content width 100%; aspect-ratio source; `object-fit: contain`; edge blend overlay |

Після change request назвіть affected gates. Зміна механіки або claims завжди повертається до G2.

## 11. Заборони для AI

- Не починати код до G7.
- Не вигадувати mascot, шрифт, CTA, цифри, package tiers або legal text.
- Не перефразовувати `approved verbatim`.
- Не використовувати reference mascot лише як «натхнення»; зберігати invariants.
- Не створювати UI-іконки emoji/CSS-art/placeholder-ами, якщо потрібні брендовані assets.
- Не оголошувати дизайн готовим без side-by-side reference comparison.
- Не деплоїти, доки всі локальні правки й QA не завершені та release owner не погодив публікацію.
