# Operating Model: від брифа до релізу

Цей документ — маршрут проєкту. Деталі живуть у сусідніх playbook-файлах, а статус конкретного
лендінгу — у копії [PROJECT-STATE.md](../templates/PROJECT-STATE.md).

## 1. Два режими роботи

### Full Track — нова кампанія або невідома територія

Використовуй, якщо змінюється продукт, GEO, аудиторія, позиціонування, механіка, visual language або
лендінг виходить на новий host. Орієнтир: 10–14 робочих днів до production-ready дизайну й збірки,
залежно від кількості асетів та апрувів.

### Fast Track — внутрішній лендінг готового продукту

Використовуй, якщо продукт, GEO, аудиторія й host уже відомі, механіка та legal-copy погоджені, а команда
робить нове оформлення в межах наявної екосистеми. Не повторюй формальне дослідження продукту й ЦА;
натомість підтверди джерела правди, brand invariants, механіку, заборонені claims, integration boundary
і deliverables. Fast Track не скасовує дизайн-гейти.

Fast Track можна використовувати лише коли всі твердження нижче правдиві:

- є актуальна approved promo page або legal-документ;
- відомі host, destination product і точний CTA route;
- є доступ до Figma/design system/brand assets обох сторін;
- відповідальний за legal підтвердив, що можна рекламувати;
- відомий формат інтеграції та власник header/footer/navigation;
- продуктова механіка може бути пояснена без припущень.

Якщо хоча б один пункт не виконано — повернись у Full Track для відповідної теми.

## 2. Ролі й право апруву

| Роль | Володіє | Не може одноосібно змінити |
|---|---|---|
| Product owner | бізнес-ціль, механіка, CTA, пріоритет контенту | legal claims, бренд-інваріанти |
| Product designer | IA, композиція, responsive, prototype, дизайн-рішення | механіку, approved copy, CTA destination |
| Brand designer / art director | visual language, asset style, mascot rules | продуктову механіку й legal |
| Legal / compliance | дозволені claims, дисклеймери, обов'язковий текст | UX-порядок без узгодження з design |
| Frontend / design engineer | реалізацію, performance, integrations | погоджений дизайн без change request |
| Product analyst | event map, attribution, success metrics | зміст CTA й продуктову механіку |
| QA / release owner | evidence, regression gate, release checklist | бізнес-рішення |

Один учасник може мати кілька ролей, але кожен гейт усе одно має названого owner-а й дату.

## 3. 13 фаз і жорсткі гейти

| Фаза | Головне питання | Обов'язковий вихід | Гейт |
|---|---|---|---|
| **0. Route** | Який продукт, тип лендінгу й маршрут? | Full/Fast Track, owner map | G0 Scope Ready |
| **1. Intake** | Чого насправді хочемо досягти? | Project Brief, open questions | G1 Brief Ready |
| **2. Product Truth** | Що саме можна обіцяти й показувати? | Mechanics Model, Claims Matrix | G2 Truth & Legal Ready |
| **3. Brand Evidence** | Які правила не можна вигадувати? | Product KB snapshot, Brand Bridge | G3 Brand Ready |
| **4. Content Architecture** | Яку історію читає користувач? | Content Map, storyboard, CTA map | G4 Story Ready |
| **5. Visual Directions** | Які три реальні візуальні відповіді можливі? | 3 image-based directions | G5 Direction Selected |
| **6. Key Art / Hero** | Чи працює головна обіцянка й cross-brand fusion? | Hero desktop + mobile treatment | G6 Hero Approved |
| **7. Full Design** | Чи цілісна вся сторінка? | 1440 design + 440/430/375 designs | G7 Design Approved |
| **8. Asset Production** | Чи всі елементи готові до коду? | Asset Register, masters, delivery files | G8 Asset Freeze |
| **9. Implementation** | Чи реалізація вірна дизайну й host-контракту? | local Nuxt build | G9 Feature Complete |
| **10. Analytics & QA** | Чи вимірюємо, чи швидко вантажиться mobile і чи все працює? | event evidence, visual/tech/performance QA | G10 QA Green |
| **11. Release** | Чи можна показувати публічно? | release approval, live URL | G11 Released |
| **12. Learn** | Що зробить наступний лендінг швидшим? | retrospective, KB updates | G12 Learning Captured |

Послідовність фіксована: фазу можна позначити `N/A` із owner/rationale, але не переставити. Fast Track
скорочує питання й дослідження всередині фаз; він не дозволяє перейти G1 → G5, обійшовши Product
Truth, legal placement і Brand Evidence.

## 4. Definition of Ready для кожного переходу

Гейт зелений лише коли:

1. артефакт існує за посиланням;
2. owner залишив явне `APPROVED`, дату й версію;
3. відкриті питання не впливають на наступну фазу;
4. change request після гейта має owner-а, impact і рішення щодо повторного апруву;
5. AI і виконавці читають актуальну версію, а не пам'ять із чату.

`Мені загалом подобається` — це feedback, але не approval. Approval має назвати scope: наприклад,
`APPROVED: hero composition v3 for desktop; mobile crop pending`.

## 5. Правило вартості змін

| Коли зміна з'явилась | Нормальна дія |
|---|---|
| До G2 | уточнити brief без штрафу |
| G3–G5 | оновити Brand Bridge / storyboard і переоцінити напрям |
| G6–G7 | внести дизайн-ітерацію; код ще не починати |
| G8–G9 | оформити change request, оновити asset list і повторити affected QA |
| Після G10 | release owner вирішує: block, hotfix або наступна версія |

Не маскуй зміну механіки під «невелику правку тексту»: вона повертає проєкт у Product Truth.

## 6. Щоденний ритм

- На старті: назвати поточну фазу, гейт і один очікуваний артефакт.
- Під час роботи: вести Decision Log і список blockers; не змішувати exploration, approval і build.
- На review: показувати результат у реальному viewport, а не окремий красивий asset.
- Після review: перетворити feedback на атомарні change requests із точним scope.
- Наприкінці: оновити PROJECT-STATE, посилання на артефакти й наступну дію.

## 7. Вихідний пакет

Для embedded landing мінімум:

1. editable Figma mobile 375, 430, 440;
2. editable Figma content-only desktop 1440 і host context;
3. окремі WebP delivery assets з alpha для standalone cutouts; background assets як окремі tasks;
4. Nuxt/Vue source лише погодженого integration boundary;
5. static HTML+allow-listed assets;
6. `content/copy.json`, `content/actions.json`, analytics map і integration notes;
7. visual, technical та performance QA;
8. live URL після release approval.

## 8. Наступні документи

- [QUESTIONNAIRE.md](QUESTIONNAIRE.md) — як правильно опитувати.
- [../PLAYCITY-COPYWRITING-RULES.md](../PLAYCITY-COPYWRITING-RULES.md) — legal/copy layer.
- [../brand-archive/README.md](../brand-archive/README.md) — design system та asset evidence.
- [DESIGN-PROCESS.md](DESIGN-PROCESS.md) — як отримати стильний, а не generic дизайн.
- [ASSET-PIPELINE.md](ASSET-PIPELINE.md) — як генерувати й готувати графіку.
- [TECHNICAL-STANDARD.md](TECHNICAL-STANDARD.md) — спільний стек і viewport-и.
- [PERFORMANCE-OPTIMIZATION.md](PERFORMANCE-OPTIMIZATION.md) — mobile-first budgets, formats, motion
  choice, optimization і static delivery.
- [ANALYTICS.md](ANALYTICS.md) — вимірювання cross-brand воронки.
- [QA-RELEASE.md](QA-RELEASE.md) — дизайн QA, технічний QA й реліз.
- [SKILLS.md](SKILLS.md) — скіли, послідовність і роль людини.
- [../AGENT-BOOTSTRAP.md](../AGENT-BOOTSTRAP.md) — обов'язкове встановлення в Codex/Claude Code.
