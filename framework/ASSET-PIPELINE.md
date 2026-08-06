# Asset Pipeline: від референсу до delivery-файлу

Асети виробляються після G7 Design Approved. До цього дозволені лише concept mocks. Мета — не просто
отримати красиву картинку, а створити керований набір елементів, які можна анімувати, адаптувати,
стиснути й інтегрувати без видимих прямокутних країв.

Перед production використовуйте selected [Brand Archive](../brand-archive/README.md). Campaign Asset
Register є snapshot конкретних slots; він не замінює canonical design-system/rights archive.

## 1. Asset Register до генерації

Кожен asset отримує ID й запис у [ASSET-REGISTER.md](../templates/ASSET-REGISTER.md):

- section і slot;
- intended rendered size на 1440/440/430/375;
- semantic role;
- source references з ролями;
- immutable invariants;
- editable variables;
- camera/angle/lighting/material;
- background/alpha requirement;
- якщо background baked — окремий background task ID, ratio, crop map і mobile variant;
- master і delivery format;
- crop-safe area;
- animation/layer requirements;
- maximum delivery weight;
- approval status.

Не генеруйте «набір іконок» одним запитом без окремих IDs і semantic roles.

## 2. Reference hierarchy

У prompt не змішуйте всі зображення як рівнозначні. Призначте:

1. **Identity reference** — хто/що це; форма й canonical details.
2. **Style reference** — material, fur, render language.
3. **Composition reference** — поза, camera, relationship.
4. **Environment reference** — background/material/lighting.
5. **Negative reference** — що саме не повторювати.

При конфлікті identity reference завжди перемагає style/composition.

## 3. Prompt contract

Хороший generation prompt містить:

1. `Deliverable:` що саме генерується й де використовується.
2. `Canvas:` ratio, resolution, transparent/chroma background.
3. `Identity lock:` immutable features.
4. `Composition:` position, camera, gesture, safe zone.
5. `Material/style:` фактура, шерсть, бетон, світло, palette.
6. `Brand bridge:` які елементи від host, які від destination.
7. `Negative constraints:` заборонені деформації й style drift.
8. `Integration constraints:` no text, no border, edge blend, separated layers.

Після кожної успішної генерації зберігайте **точний prompt**, модель/режим, references і correction
history. «Зроби як минулого разу» не є відтворюваною інструкцією.

## 4. Style lock для сімейства

Перед масовою генерацією затвердіть одну reference icon у реальному slot size. Зафіксуйте:

- camera elevation і rotation;
- light direction, hardness, rim light;
- material і довжину/щільність хутра;
- saturation/contrast;
- silhouette density;
- base/shadow policy;
- safe area;
- optical weight.

Інші іконки успадковують style lock. Якщо одна іконка легша за сусідні, не розтягуйте її CSS-ом без
думки: перегенеруйте dominant object або змініть композицію.

## 5. Transparent background

`Фон здається чорним` не означає, що є alpha. Перевірка обов'язкова:

- alpha channel існує;
- мінімальне alpha = 0, максимальне = 255;
- немає темного/кольорового matte по краю;
- перевірка на checkerboard, білому, чорному й реальному тлі секції;
- bounding box обрізаний, але safe shadow не втрачена;
- немає видимого прямокутника на сторінці.

Якщо генератор не дає true alpha, використовуйте контрольований chroma key, потім видалення фону,
деcontamination edge pixels і ручний QA волосся/хутра.

Standalone illustration за замовчуванням transparent. Виняток `із фоном` не позначається одним
прапорцем: це окрема задача з composition ownership, ratio, responsive crop, safe zone, seam/edge
blend і delivery budget. Так background не «прилипає» до reusable icon-а випадково.

## 6. Реалістичні матеріали

Для бетону описуйте не лише `concrete`, а:

- matte, gray, porous, aggregate, chips, dust;
- scale of cracks і edge wear;
- roughness, без plastic/gloss reflections;
- source-specific geometry;
- glow лише всередині окремих cracks, а не neon outline по всьому об'єкту.

Для CATBET fur визначайте довжину, напрямок, щільність і base color. «Furry» без цих параметрів дає
різні матеріали в одному ряду.

## 7. Hero/video production

Для анімованого hero готуйте:

- clean plate/background;
- host character layer;
- destination mascot layer;
- bridge props (yarn, box, concrete, paws);
- optional foreground particles;
- poster;
- animation brief із дозволеним рухом;
- desktop і mobile framing map.

Текст і CTA лишаються HTML, якщо немає окремого approved рішення. Центральна композиція має виживати
на 375 без зміни identity. Якщо відео не можна crop-ити, компонент використовує source aspect ratio й
edge blend, а не `cover`.

## 8. Формати

Формат визначає Asset Register, не особиста звичка:

| Тип | Master | Delivery |
|---|---|---|
| Photo/background | lossless/high-quality source | WebP + optional AVIF і responsive sizes |
| Transparent character/icon | PNG/PSD layered source | transparent WebP |
| Fine fur/hair alpha | high-res PNG/PSD | transparent WebP після edge QA |
| Video hero | high-quality master | MP4 H.264 + optional WebM, poster |
| Vector logo/UI icon | canonical SVG | SVG, лише якщо дозволено brand source |

Не конвертуйте canonical logo або supplied UI icon у AI-generated версію.

PNG/PSD лишаються master-ами. Production raster delivery — WebP. Якщо конкретний host технічно не
підтримує alpha WebP, exception фіксується в Technical Brief із доказом; він не змінює master policy.
Правила ваги, responsive delivery і motion media — у
[PERFORMANCE-OPTIMIZATION.md](PERFORMANCE-OPTIMIZATION.md).

## 9. Naming і папки

```text
assets/
  source/            # untouched canonical files and masters
  generated/         # raw generations, never referenced by production
  approved/          # approved masters
  delivery/
    desktop/
    mobile/
    shared/
  prompts/
  contact-sheets/
```

Назва: `{section}-{role}-{variant}-{version}.{ext}`, наприклад
`quick-start-hero-beton-man-cat-v03.png`.

## 10. QA одного asset

- Identity відповідає canonical source.
- Invariants збережені; forbidden list не порушено.
- Семантика читається без підпису.
- Material збігається із style lock.
- Optical weight збалансована з сусідами.
- Alpha/crop/safe shadow чисті.
- Реальний rendered size не перетворює деталі на шум.
- 1440/440/430/375 не обрізають важливе.
- Файл у межах бюджету.
- Prompt і source refs записані.
- Asset має `APPROVED` і owner-а.

## 11. QA сімейства

Створіть contact sheet у двох режимах:

1. усі assets однакового canvas size — для style consistency;
2. усі assets у реальному rendered size — для optical weight.

Перевіряйте сімейство на реальному background сторінки. Великий isolated preview не є proof.

## 12. Asset Freeze

G8 зелений, коли:

- кожен production slot має approved asset ID;
- немає raw generation у коді;
- master/delivery зв'язок записаний;
- formats і weights підтверджені;
- mobile variants готові або явно не потрібні;
- аніматор/розробник має шари й framing map;
- усі assets інтегровані в статичний design mock без видимих стиків.

Глибокі правила іконок див. у [ICON-GENERATION-METHODOLOGY.md](../ICON-GENERATION-METHODOLOGY.md).
