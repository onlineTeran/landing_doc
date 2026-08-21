# Процес проєктування арту

Окремий арт проходить компактний керований маршрут. Він може працювати самостійно або як Asset-фаза
погодженого лендінгу. Production-генерація все одно потребує вибраного людиною концепту й точного slot.

## A0 — Маршрутизація

Створи `ART-BRIEF.md`. Зафіксуй продукт, роль арту, місце використання, розміри/пропорції,
desktop/mobile relationship, дедлайн, owner і delivery. Результат: `ROUTED` або перелік блокерів.

## A1 — Фіксація доказів

Завантаж Brand Archive. Кожному референсу признач одну роль: identity, style, composition, material,
camera/light, color, motion або negative evidence. Запиши checksum/node/path і права. Якщо потрібної
ролі чи персонажа немає, поверни `DESIGN_SYSTEM_GAP`.

Attachment, URL, live-page image або generated output можна тимчасово переглядати, але вони не стають
репозиторним референсом автоматично. До copy/download, створення crop/derivative, checksum/manifest entry
або commit у `brand-archive` отримай окремий file-specific storage consent із продуктом, роллю та точним
target path. Дослівно запиши approval у manifest. Відсутність відповіді чи design approval не є згодою.

## A2 — Творчий контракт

Обери одну погоджену style group і зафіксуй:

- кількість і hierarchy об'єктів;
- composition, content safe zone і crop tolerance;
- palette через tokens і контрольовані accents;
- material, camera, light, depth і background;
- незмінні ознаки identity;
- заборонені елементи й negative prompt;
- окрему mobile recomposition, якщо вона потрібна.

Не змішуй історичні style groups без окремого рішення.

## A3 — Набір концептів

Підготуй рівно три змістовно різні концепти на основі джерел, якщо користувач не попросив одну
обмежену реалізацію. Не змінюй product truth та identity; варіюй композицію або treatment. Для кожного
концепту назви докази й ризики.

## A4 — Вибір людиною

Запиши `APPROVED` із owner, датою, concept/version і точним scope. Feedback не є approval.
До вибору не створюй production family.

## A5 — Виробництво master

Спочатку створи один style-lock master. Збережи prompt, model/tool, references, seed/settings, manual edits
і source output. Copy/logo/UI тримай в editable layers, якщо canonical source не вимагає baked content.
Перед генерацією substitute повторно перевір canonical assets/components.

## A6 — Варіанти й delivery

Створюй лише перелічені варіанти. Для desktop ширше 2:1 потрібна окрема mobile composition, якщо brand
contract прямо не дозволяє спільне safe core. Master зберігай окремо від оптимізованих delivery-файлів.

## A7 — Перевірка арту

Заповни `ART-QA.md` у реальному slot size:

1. identity і product correctness;
2. style group, materials, camera/light і palette;
3. hierarchy, safe zone, crops і mobile recomposition;
4. anatomy/geometry/text/logo/watermark defects;
5. alpha, edges, dimensions, profile, format і byte budget;
6. same-family consistency та contrast під зовнішнім контентом;
7. owner approval для точного master і delivery set.

Привабливий preview сам по собі не є доказом якості.

## A8 — Реєстрація й навчання

Запиши погоджений asset в `ASSET-REGISTER.md`: source/master/delivery paths, rights, prompt provenance,
campaigns, QA evidence і last verified. Нові повторно використовувані правила входять у Brand Archive
лише після design-system owner review.
