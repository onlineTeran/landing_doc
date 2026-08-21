# Surface Router

Framework починається не з «який лендінг робимо», а з визначення поверхні. Один запит має одну
primary surface; додаткові surface оформлюються окремими deliverables, бо мають різні гейти й QA.

| Track | Коли обирати | Мінімальний вихід | Процес |
|---|---|---|---|
| `LANDING` | промо-, campaign-, acquisition- або embedded landing | повний project kit, дизайн, код, QA, release | `framework/README.md` |
| `ART` | hero, banner, card background, 3D icon, illustration, decorative background | Art Brief, concept, master/delivery, Art QA | `ART-DESIGN-PROCESS.md` |
| `PRODUCT_UI` | екран, flow, віджет, Smartico surface, стан застосунку | UX Brief, state model, responsive design, prototype, handoff | product-specific extension; не використовувати landing layout як UI spec |
| `COMPONENT` | новий компонент, variant, token або design-system gap | component contract, variants/states, accessibility, migration | Brand Design Base + upstream design-system review |
| `AUDIT` | аналіз існуючого дизайну/реалізації без створення нового | evidence report, severity, remediation | read-only до окремого change approval |

## Route decision

1. Назви продукт: `slotcity`, `catbet` або explicit cross-brand.
2. Назви surface і точний slot: де результат живе та в якому контексті його побачать.
3. Визнач, чи змінюються product truth, legal claim, CTA route або integration boundary.
4. Обери primary track. Не запускай landing gates для isolated art, але не використовуй art approval
   як дозвіл на landing implementation.
5. Завантаж `brand-archive/<PRODUCT>/INDEX.md` і всі required sources з обраного track.
6. Якщо evidence неповне, поверни `DESIGN_SYSTEM_GAP` із відсутнім owner/source; не компенсуй
   прогалину generic casino style.

Для нового ізольованого дизайн-репозиторію виконайте
`./methodology/scripts/bootstrap-design-task.sh . <slotcity|catbet> <codex|claude>`; for a landing use
the landing bootstrap from `AGENT-BOOTSTRAP.md`.

## Cross-track dependencies

- `LANDING` викликає `ART`, коли approved full design потребує нових production assets.
- `PRODUCT_UI` викликає `COMPONENT`, якщо потрібної поведінки немає у canonical library.
- `ART` не визначає mechanic, copy, legal або CTA route; ці дані мають прийти як locked inputs.
- Будь-який track може завершитися `AUDIT`, але audit не є human approval.

## Stop conditions

- Невідомий продукт або surface.
- Немає точного output slot/aspect ratio/viewport.
- Немає canonical brand evidence для identity-critical рішення.
- Запит вимагає змінити маскота, логотип або locked component без modification-rights matrix.
- Gambling claim/legal copy не має статусу й джерела.
