# Методологія генерації AI-іконок

Практична методологія створення консистентних production-ready наборів іконок для вебсайтів, мобільних застосунків, промолендингів і продуктових інтерфейсів.

> Дистильовано з практичного досвіду генерації іконок у ChatGPT; підходи застосовні до будь-якого AI image-генератора. Доповнює розділ 9 («Робота з AI-generated асетами») головного документа методології.

> Методологія не залежить від конкретного бренду, тематики, персонажа, палітри чи художнього стилю. Вона розділяє чотири процеси: **генерацію**, **постобробку**, **експорт** та **інтеграцію**.

---

## 1. Retrospective практичного досвіду

### Семантика важливіша за красивий предмет

- **Спостережено:** предмет, який виглядав якісно сам по собі, не підходив до конкретного кроку: символ поповнення був використаний для верифікації, а символ очікування — для щоденної дії.
- **Виведено:** генератор легко оптимізує «красивість», але не перевіряє продуктову семантику так строго, як дизайнер.
- **Рекомендовано:** перед генерацією фіксувати формулу: **дія → значення → найочевидніший силует**. Наприклад, «підтвердити особу → верифікація → профіль або документ із check», а не фінансовий предмет.

### «У тому самому стилі» недостатньо

- **Спостережено:** повторні генерації дрейфували від об’ємного стилізованого 3D до плаского або надто реалістичного рендера.
- **Спостережено:** окремі іконки ставали одноманітними через повторення однакових матеріалів, кольорових пропорцій і композиції.
- **Виведено:** слово «стиль» не фіксує камеру, світло, матеріал, visual weight, safe area та detail density.
- **Рекомендовано:** використовувати **style lock** із 10–15 незмінних параметрів і передавати затверджену reference icon у кожний наступний запит.

### Інваріанти та змінні

- **Спостережено:** під час виправлення форми модель одночасно змінювала палітру, перспективу, матеріал або реалістичність.
- **Виведено:** correction prompt без інваріантів сприймається як повний редизайн.
- **Рекомендовано:** формулювати: «Змінити лише X. Зберегти без змін A, B, C». Одна ітерація — одна основна зміна.

### Напрямок і анатомічна форма

- **Спостережено:** відбиток був орієнтований не в той бік і мав неправильну форму.
- **Спостережено:** формулювання «котячий слід» не гарантувало правильну кількість пальців і пропорцію центральної подушечки.
- **Виведено:** генератор підмінює точну форму статистично типовим символом.
- **Рекомендовано:** додавати shape reference та геометричний опис: кількість елементів, пропорції, відсутність кігтів, кут повороту і напрямок у координатах canvas.

### Ролі референсів

- **Спостережено:** референс матеріалу іноді помилково визначав і форму нового об’єкта.
- **Виведено:** без пояснення ролі модель копіює референс цілісно.
- **Рекомендовано:** маркувати кожне зображення як material, shape, lighting, composition reference або edit target. Явно забороняти переносити нерелевантні властивості.

### Контрольована різноманітність

- **Спостережено:** після серії генерацій набір ставав надто одноманітним.
- **Виведено:** консистентність без variation plan перетворюється на монотонність.
- **Рекомендовано:** фіксувати camera, light, visual weight і materials system, але дозволяти варіативність у 2–3 осях: dominant color, secondary material, silhouette або локальний акцент.

### Прозорість як окремий етап

- **Спостережено:** візуально «прозорий» preview не завжди мав справжній alpha channel.
- **Спостережено:** chroma-key removal змінював близькі до key кольори; агресивний despill приглушував фіолетові елементи.
- **Спостережено:** слабкі напівпрозорі залишки фону збільшували автоматичний bounding box.
- **Виведено:** красивий preview не доводить технічну готовність.
- **Рекомендовано:** перевіряти alpha програмно, на checkerboard і різних фонах; crop рахувати за порогом видимості, а не за будь-яким alpha > 0.

### Chroma key

- **Спостережено:** magenta був зручний для бірюзових і помаранчевих предметів, але конфліктував із фіолетовими деталями.
- **Виведено:** один key color не підходить всьому набору.
- **Рекомендовано:** вибирати key, відсутній у subject; для конфліктних елементів змінювати key або використовувати native transparency. Despill застосовувати після color QA.

### Crop, safe area і dimensions

- **Спостережено:** початкові файли мали надлишкові прозорі області.
- **Спостережено:** content було зменшено до 400 px, але після padding повний файл став 408 px.
- **Спостережено:** великий foreground-об’єкт був обрізаний у source, тому на ширшому viewport з’являлися штучні краї.
- **Виведено:** content bounds, visible bounds і file dimensions — різні поняття.
- **Рекомендовано:** знайти visible alpha bounds, визначити padding, відняти його від export dimensions і лише тоді масштабувати. Важливий об’єкт повинен повністю існувати в master.

### Large preview не є QA

- **Спостережено:** детальні 3D-об’єкти виглядали добре у master view, але тонкі частини й texture втрачалися після downscale.
- **Виведено:** генератор оптимізує preview, а не цільові 16–48 px.
- **Рекомендовано:** перевіряти master і target-size grid одночасно. Для 16–24 px створювати optical-size variant.

### Формулювання, що працювали найкраще

- **Спостережено:** структуровані блоки Subject, Style, Composition, Materials, Lighting, Constraints, Avoid давали стабільніший результат.
- **Спостережено:** «Create ONLY the requested object» зменшувало зайві деталі.
- **Спостережено:** «fully visible», «generous padding», «no text», «no watermark», «no background objects» підвищували production-readiness.
- **Рекомендовано:** у кожному промпті мати позитивну ціль, інваріанти, production constraints і короткий avoid-list.

---

## 2. Universal icon workflow

### 1. Формування задачі

Для кожної іконки визначити:

1. Semantic meaning.
2. Дію або стан.
3. Контекст: toolbar, navigation, card, onboarding, promo, hero, animation.
4. Target rendered size.
5. Фон і theme.
6. Platforms та density.
7. States.
8. Animation requirements.
9. File-size budget.
10. Format і fallback.

Погано: «Зроби красиву 3D-іконку безпеки».

Краще: «Промо-іконка підтвердження профілю, rendered size 64 px, dark card, medium optical size, об’ємний документ із check, без грошей і замків, WebP alpha @2x».

### 2. Вибір типу іконки

| Тип | Основна задача | Деталізація |
|---|---|---|
| UI | Швидко розпізнати дію | Мінімальна |
| Навігаційна | Позначити розділ | Низька |
| Функціональна | Пояснити операцію | Низька–середня |
| Промо | Привернути увагу | Середня–висока |
| 3D | Передати матеріал і цінність | Середня–висока |
| Предметна | Показати конкретний предмет | Середня |
| Категорія | Розрізнити групи | Низька–середня |
| Нагорода | Показати цінність або рідкість | Середня–висока |
| Статус | Миттєво передати стан | Мінімальна |
| Декоративна | Створити атмосферу | Залежить від масштабу |
| Hero object | Бути частиною композиції | Висока |
| Анімована | Зберігати форму в русі | Контрольована |

Одна деталізація не підходить усім типам: texture, доречна для hero у 256 px, стає шумом у status icon 20 px.

### 3–6. Style, reference і перевірка

1. Побудувати style lock.
2. Створити одну reference icon.
3. Перевірити master, target sizes, dark/light backgrounds, alpha, silhouette і safe area.
4. Створити pilot із трьох різних форм: круглої, високої та широкої.

### 7–13. Набір, експорт і QA

1. Генерувати семантично різні іконки окремими запитами.
2. Збирати contact sheet.
3. Вирівнювати apparent size, camera, light, color і detail density.
4. Готувати true alpha.
5. Створювати optical sizes.
6. Експортувати потрібні density, state, theme та format variants.
7. Тестувати у реальному UI.

---

## 3. Правила для типів іконок

### UI, навігаційні та функціональні

- Перевага SVG.
- Простий silhouette й узгоджена stroke width.
- Без texture та складного glow.
- QA від 16 px.
- State color бажано задавати CSS, якщо geometry не змінюється.

### Промо, категорії та нагороди

- Можливий raster/3D.
- Meaning має читатися без підпису.
- Унікальний silhouette важливіший за декоративну різницю.
- Detail level залежить від rendered size.

### 3D і предметні

- Фіксована camera, perspective і light direction.
- Material має залишатися видимим після downscale.
- Thin details повинні мати достатню pixel thickness.
- Для 16–24 px потрібна спрощена версія.

### Статуси

- Не покладатися лише на color.
- Використовувати shape: check, lock, alert, progress.
- Glow і shadow мінімальні.

### Decorative та hero

- Дозволена складна texture, reflections і translucent layers.
- Canvas може бути не квадратним.
- Safe area враховує composition crop і motion path.
- Hero object не замінює UI icon.

### Animated

- Рухомі частини експортувати шарами.
- Залишати rotation і motion padding.
- Pivot point фіксувати в manifest.
- Не запікати загальну траєкторію в subject.

---

## 4. Universal icon style guide

| Параметр | Що зафіксувати | Формулювання промпту | Перевірка |
|---|---|---|---|
| Геометрія | circle, square, capsule, organic | rounded compact base | Overlay silhouettes |
| Пропорції | width/height, dominant mass | ratio approximately 4:3 | Bounding-box ratio |
| Perspective | orthographic або 3/4 | mild three-quarter perspective | Осі та top-face |
| Camera | azimuth, elevation, focal feel | camera 20° above, 30° right | Side/top visibility |
| Thickness | мінімум для деталей | no feature thinner than 4% | Downscale grid |
| Radii | sharp або soft | consistent large corner radii | Contact sheet |
| Detail | secondary/tertiary count | max three secondary accents | Detail density |
| Materials | 1–3 матеріали | matte polymer plus satin metal | Highlight behavior |
| Lighting | key, fill, rim | soft key upper-left | Highlight map |
| Shadow | type, opacity, radius | contained soft floating shadow | Alpha preview |
| Contrast | local/global | strong silhouette contrast | Grayscale |
| Palette | ролі та пропорції | 70% neutral, 20% primary, 10% accent | Histogram |
| Gradients | direction/intensity | subtle material gradient | Banding |
| Glow | color/radius/opacity | contained 8% cyan glow | Multiple backgrounds |
| Reflections | count/sharpness | one broad soft reflection | Set comparison |
| Transparency | opaque/translucent areas | true alpha outside | Alpha channel |
| Texture | scale/roughness | macro texture, no micro-noise | Target size |
| Visual weight | apparent mass | same weight as reference | Grid |
| Safe area | occupancy/padding | object occupies 76% | Bounds |
| Position | optical center/baseline | optically centered | Grid |

### Style lock example

~~~text
Perspective: mild 3/4, camera 25° above and 20° right.
Shape language: rounded, compact, no sharp protrusions.
Materials: matte polymer body, one satin-metal accent.
Lighting: soft key upper-left, weak cool rim right.
Shadow: small floating shadow, fully inside canvas.
Palette roles: neutral 65%, primary 25%, accent 10%.
Detail: medium; maximum three secondary features.
Visual weight: object occupies 76% ± 3% of canvas.
Safe area: minimum 9%; 14% where glow exists.
Background: true transparent alpha.
~~~

---

## 5. Reference icon

Reference icon повинна мати зрозумілу семантику, основний матеріал, типовий акцент, середню складність і неекстремальні пропорції.

Вона фіксує:

1. Style і shape language.
2. Perspective та camera.
3. Materials і roughness.
4. Lighting і shadow.
5. Contrast.
6. Detail density.
7. Visual weight.
8. Canvas occupancy.
9. Safe margins.
10. Alpha behavior.
11. Palette roles.

У наступних запитах писати:

~~~text
Reference image role: immutable style reference.
Preserve exactly: camera, perspective, shape language, materials,
lighting direction, shadow softness, detail density, visual weight,
safe-area ratio and palette roles.
Change only: the semantic object.
~~~

---

## 6. Система розмірів

### Терміни

- **Logical size:** розмір у design system, наприклад 24 logical px.
- **CSS px:** layout unit браузера, не обов’язково physical pixel.
- **Rendered size:** фактичний розмір у UI.
- **Canvas size:** повні dimensions файла з transparent fields.
- **Source/master:** високоякісний робочий оригінал.
- **Export size:** dimensions конкретного delivery файла.
- **Physical pixels:** пікселі дисплея.
- **DPR:** physical pixels на один logical/CSS px.

### Таблиця x1/x2/x3

| Logical size | @1x | @2x | @3x |
|---:|---:|---:|---:|
| 16 px | 16×16 | 32×32 | 48×48 |
| 20 px | 20×20 | 40×40 | 60×60 |
| 24 px | 24×24 | 48×48 | 72×72 |
| 32 px | 32×32 | 64×64 | 96×96 |
| 40 px | 40×40 | 80×80 | 120×120 |
| 48 px | 48×48 | 96×96 | 144×144 |
| 64 px | 64×64 | 128×128 | 192×192 |
| 80 px | 80×80 | 160×160 | 240×240 |
| 96 px | 96×96 | 192×192 | 288×288 |
| 128 px | 128×128 | 256×256 | 384×384 |
| 256 px | 256×256 | 512×512 | 768×768 |

Для 32×24 logical px exports: 32×24, 64×48, 96×72.

### Retina та DPR

- @2x достатньо для більшості desktop Retina.
- @3x потрібен для iPhone 3x, деяких Android і тонких raster details.
- @1x корисний для low-density, legacy або точного network budget.
- Для web часто достатньо @1x + @2x; @3x додають за аналітикою.
- 72×72 file може відображатися як 24×24 CSS px при DPR 3.
- Upscale 24×24 до 72×72 не відновлює деталі.

---

## 7. Master source

- Для raster/3D master рекомендовано не менше 1024×1024.
- 1024×1024 зручно для квадратних promo icons і downscale до 256 px.
- Більший canvas потрібен для hero, glow, animation layers і wide objects.
- Не генерувати фінальну 24×24 UI raster icon: бракує geometry та antialiasing.
- Downscale робити якісним фільтром із target-size QA.
- Sharpening застосовувати лише після comparison.
- Якщо meaning губиться, спрощувати design: прибирати texture, збільшувати thickness, контраст і gaps.

Master не є delivery asset.

---

## 8. Optical sizes

### Small: 16–24 px

- Мінімум деталей.
- Товстіші елементи.
- Вищий contrast.
- Простий silhouette.
- Без microtexture.
- Мінімум transparency.
- Малий або відсутній glow.
- Більший visual weight.

### Medium: 32–64 px

- Середня деталізація.
- Матеріали через великі highlights.
- Обмежені secondary details.
- Контрольована shadow.
- Виразна форма.

### Large: 80 px+

- Повна деталізація.
- Складні materials і reflections.
- Texture і decorative accents.
- Soft transparent layers.
- Складніше lighting.

Просте зменшення Large до 20 px часто дає шум, закриті gaps, зниклі thin parts і пляму замість glow. Small — окрема адаптація.

---

## 9. Transparency

Production transparent icon має:

- true alpha channel;
- alpha 0 поза subject;
- partial alpha на antialiased edges;
- no white, black або colored matte;
- no checkerboard;
- no rectangular shadow;
- no clipped glow/shadow;
- no fake background gradient.

### Відмінності

- True alpha — transparency у каналі alpha.
- Білий або чорний фон — opaque RGB.
- Checkerboard — намальований background.
- Background removal — процес, що потребує edge QA.
- Translucent object — матеріал із partial alpha.
- Translucent shadow — colored pixels із partial alpha.
- Additive glow — напівпрозорий світлий шар, залежний від фону.

### Типові дефекти

- White halo від white matte.
- Black halo від black matte або premultiplication.
- Colored halo від chroma spill.
- Dirty edges від threshold або compression.
- Clipped glow/shadow від малого canvas.
- Втрачена alpha через неправильний encoder mode.
- Premultiplied-alpha artifacts через неправильний RGB країв.

### Надійний процес

1. Native transparent PNG, якщо можливо.
2. Інакше key color, відсутній у subject.
3. Рівномірний key без gradient, floor, shadow та reflection.
4. Soft-matte removal.
5. Обережний despill.
6. Color QA для відтінків, близьких до key.
7. White, black, gray, product і saturated backgrounds.
8. Alpha histogram та transparent corners.
9. Лише потім crop, resize і compression.

---

## 10. Safe area та crop

Орієнтовні, не жорсткі правила:

- Main object: 70–82% canvas.
- Static padding: 7–10%.
- Glow/shadow: 10–16%.
- Rotation: padding за rotated bounding box.
- Motion: max displacement + effect radius.

**Actual bounds** охоплюють alpha > 0. **Visible bounds** використовують практичний threshold, наприклад 24–32/255. **Visual bounds** — perceived object mass.

Crop за actual bounds може зберегти невидимий residue. Практичніше: visible bounds + intentional padding. Важливі частини, glow і shadow не торкаються canvas.

---

## 11. Optical centering

Математичний center не дорівнює perceptual center.

- Асиметричну масу компенсують у протилежний бік.
- Нахилений предмет центрують за mass, не extremities.
- Shadow і glow мають меншу вагу, ніж opaque body.
- Perspective protrusion змінює balance.
- Group центрують як composition із dominant object.

QA проводити в grid однакових комірок без підписів.

---

## 12. Dark і light theme

### Одна universal icon

Для стабільного edge contrast на обох темах.

### Окремі variants

Для glass, чорних деталей, white highlights, glow, складних shadows і baked lighting.

### Dynamic CSS

Для SVG, masks, opacity, simple shadow і monochrome color. Не використовувати CSS filters як повну заміну art-directed 3D variant.

Перевіряти на white, black, neutral gray, product background, colored card і gradient. Окремо: shadow, dark details, white edges, glow, glass, metal і reflections.

---

## 13. Формати

### SVG

Для простих vector UI, monochrome, scalable controls і CSS color. Ризики: складні paths, embedded raster, inconsistent strokes.

### PNG

Для lossless raster, 3D, складної alpha і master. Ризик: вага.

### WebP

Для web raster із alpha. Ризик: aggressive lossy compression забруднює edges. Fallback: PNG.

### AVIF

Для складних illustrations і високої compression. Ризики: encode/decode cost, banding, alpha-edge artifacts. Fallback: WebP/PNG через picture.

---

## 14. Naming convention

~~~text
icon-[semantic-name]-[state]-[theme]-[optical-size]@[density]-v[version].[format]
~~~

Приклади:

~~~text
icon-reward-default-dark-small@2x-v1.webp
icon-verification-completed-light-medium@3x-v2.png
icon-category-games-selected-universal-small@1x-v1.svg
~~~

Параметри: semantic name, state, theme, optical size, density, version, format.

---

## 15. Стани

Default, hover, active, selected, disabled, locked, completed, error, premium, highlighted.

Окремі assets потрібні, коли змінюються geometry, material, baked light, 3D content, badge або texture. CSS підходить для opacity, SVG fill/stroke, simple shadow, scale/translate і monochrome color.

Disabled не втрачає meaning; error не залежить лише від red.

---

## 16. Workflow для набору

1. Semantic inventory.
2. Priority і target sizes.
3. Reference icon.
4. Style lock.
5. Pilot із трьох shapes.
6. Group review.
7. Виправлення system rules.
8. Batch по 3–5 icons.
9. Contact sheet.
10. Downscale review.
11. Dark/light review.
12. Alpha review.
13. Export і integration QA.

Не генерувати 20 іконок одразу: style error масштабуватиметься на весь набір.

---

## 17. Master prompt template

~~~text
Use case: icon generation
Asset type: [ICON_TYPE]

Primary request:
Create [ICON_NAME], communicating [SEMANTIC_MEANING].

Style:
[STYLE]
Shape language: [SHAPE_LANGUAGE]
Materials: [MATERIALS]
Color palette and color roles: [COLOR_PALETTE]

Geometry and camera:
Perspective: [PERSPECTIVE]
Camera angle: [CAMERA_ANGLE]
Detail level: [DETAIL_LEVEL]

Lighting:
[LIGHTING]
Shadow: [SHADOW]
Glow: [GLOW]

Production target:
Target rendered size: [TARGET_SIZE]
Optical size: [OPTICAL_SIZE]
Theme: [THEME]
Background/output: [BACKGROUND]
Safe area: [SAFE_AREA]

Reference:
[REFERENCE_IMAGE]
Reference role: [style / material / shape / lighting / composition].

Requirements:
- true transparent background with a real alpha channel;
- centered and optically balanced composition;
- clean readable silhouette at the target size;
- consistent perspective and lighting;
- production-ready isolated asset;
- enough empty margin around the complete object;
- no cropped elements;
- no clipped glow or shadow;
- no text;
- no watermark;
- no border or frame;
- no background objects;
- no checkerboard or fake transparency.
~~~

Якщо інструмент не підтримує native alpha, замінити transparent output на рівномірний chroma background і виконати removal окремим контрольованим етапом.

---

## 18. Reference-based prompt

~~~text
Create the next icon in the same approved set.

Reference image role: immutable reference icon.

Preserve exactly:
- shape language;
- perspective and camera;
- material system;
- lighting direction and softness;
- shadow type;
- palette roles;
- detail density;
- visual weight;
- object-to-canvas ratio;
- safe area;
- optical centering logic;
- alpha and edge treatment.

New semantic object:
[ICON_NAME] — [SEMANTIC_MEANING].

Change only the semantic object.
Do not redesign the style, change the camera, alter materials,
increase decorative detail, change safe margins or add background objects.

Output:
isolated production-ready asset, true alpha, no text, no watermark,
no crop and no clipped effects.
~~~

---

## 19. Correction prompt

~~~text
Edit the supplied icon.

Change only:
- [SPECIFIC_CHANGE_1]
- [SPECIFIC_CHANGE_2]

Possible changes:
increase feature thickness; remove micro-details; increase safe margins;
clean alpha artifacts; strengthen silhouette; align perspective;
reduce glow; change one material; create a 24 px optical-size variant;
adapt edge contrast for dark theme.

Preserve without any change:
semantic object, overall silhouette unless explicitly listed, camera,
perspective, proportions, palette roles, lighting direction, material system,
visual weight, approved detail level, canvas ratio and all other elements.

Do not add new objects, text, border, frame, background or watermark.
Return an isolated production-ready asset with true alpha.
~~~

---

## 20. QA checklist

### Visual QA

- [ ] Semantic meaning правильне.
- [ ] Silhouette читається без підпису.
- [ ] Style відповідає reference.
- [ ] Perspective і camera однакові.
- [ ] Lighting і shadow однакові.
- [ ] Detail density однакова.
- [ ] Visual weight однаковий.
- [ ] Icon оптично відцентрована.
- [ ] Немає зайвих деталей, тексту чи background objects.

### Small-size QA

Перевірити у 16, 20, 24, 32, 48 і 64 px:

- [ ] Critical details не зникають.
- [ ] Shapes не зливаються.
- [ ] Shadow не стає брудною плямою.
- [ ] Glow не руйнує silhouette.
- [ ] Semantic meaning зберігається.
- [ ] Thin parts мають достатню pixel thickness.

### Alpha QA

- [ ] Background має alpha 0.
- [ ] Corners прозорі.
- [ ] Немає white halo.
- [ ] Немає black halo.
- [ ] Немає chroma spill.
- [ ] Partial-alpha edges мають коректний RGB.
- [ ] Shadow має коректну transparency.
- [ ] Glow не clipped.
- [ ] Немає rectangular residue.
- [ ] WebP/AVIF зберегли alpha.

### Theme QA

- [ ] White background.
- [ ] Black background.
- [ ] Neutral gray.
- [ ] Product background.
- [ ] Colored card.
- [ ] Gradient background.

### Export QA

- [ ] Правильні dimensions.
- [ ] Найбільша сторона враховує padding.
- [ ] Правильні @1x/@2x/@3x.
- [ ] Правильний aspect ratio.
- [ ] Naming відповідає convention.
- [ ] Metadata видалені.
- [ ] Format і fallback правильні.
- [ ] File size у budget.
- [ ] Asset протестовано в реальному UI.

---

## 21. Export matrix

| Платформа | Рекомендований export | Примітки |
|---|---|---|
| Web desktop | SVG або WebP @1x/@2x | srcset, fixed CSS size |
| Web mobile | SVG або WebP @2x, іноді @3x | DPR і network budget |
| Retina desktop | @2x | Зазвичай достатньо |
| iOS | Vector/PDF або PNG/WebP @2x/@3x | Asset Catalog |
| Android | VectorDrawable або density buckets | Не плутати з web DPR |
| Promo landing | WebP/AVIF + fallback | Lazy load, крім critical hero |
| Large hero | Responsive WebP/AVIF | Окремий mobile source/crop |
| Animated icon | SVG/Lottie/video або raster layers | Motion bounds і pivot |

### iOS

- @1x: 1 physical pixel на point, переважно legacy.
- @2x: 2× dimensions.
- @3x: 3× dimensions.
- 24 pt → 48 px @2x та 72 px @3x.

### Android

| Bucket | Scale від mdpi | 24 dp asset |
|---|---:|---:|
| mdpi | 1.0× | 24×24 |
| hdpi | 1.5× | 36×36 |
| xhdpi | 2.0× | 48×48 |
| xxhdpi | 3.0× | 72×72 |
| xxxhdpi | 4.0× | 96×96 |

dp — logical unit Android. Density buckets не треба механічно називати web @1x/@2x/@3x: Android resource selection і web srcset мають різні механізми, а hdpi та xxxhdpi не вкладаються у три web density.

### Рекомендована практична матриця

| Use case | Logical size | Delivery candidates |
|---|---:|---|
| Compact web UI | 16–24 CSS px | SVG; raster @1x/@2x |
| Standard web control | 24–32 CSS px | SVG; raster @2x |
| Mobile functional | 24–48 pt/dp | iOS @2x/@3x; Android buckets |
| Card/category icon | 48–96 px | WebP @1x/@2x |
| Promo icon | 80–256 px | WebP/AVIF responsive |
| Hero object | 256 px+ | Multiple width sources |
| Animated layer | За композицією | Lossless master + optimized delivery |

---

## 22. Frontend integration

### img і srcset

~~~html
<img
  src="/icons/icon-reward-medium@1x.webp"
  srcset="
    /icons/icon-reward-medium@1x.webp 1x,
    /icons/icon-reward-medium@2x.webp 2x,
    /icons/icon-reward-medium@3x.webp 3x"
  width="48"
  height="48"
  alt=""
  decoding="async"
/>
~~~

width та height задають logical dimensions і запобігають layout shift. Decorative icon має порожній alt. Semantic icon отримує meaningful alt або accessible label на control.

### picture, sizes і fallback

~~~html
<picture>
  <source
    type="image/avif"
    srcset="/icons/reward-48.avif 48w, /icons/reward-96.avif 96w"
    sizes="48px"
  />
  <source
    type="image/webp"
    srcset="/icons/reward-48.webp 48w, /icons/reward-96.webp 96w"
    sizes="48px"
  />
  <img
    src="/icons/reward-96.png"
    width="48"
    height="48"
    alt=""
  />
</picture>
~~~

### Dark/light source switching

~~~html
<picture>
  <source
    media="(prefers-color-scheme: dark)"
    srcset="/icons/reward-dark@2x.webp"
  />
  <img
    src="/icons/reward-light@2x.webp"
    width="48"
    height="48"
    alt=""
  />
</picture>
~~~

### Інтеграційні правила

- Задавати fixed logical width/height.
- Використовувати object-fit: contain для різних aspect ratios.
- loading="lazy" для offscreen non-critical assets.
- Critical icon або hero можна preload, але не весь набір.
- 72×72 file може рендеритися як 24×24 CSS px при DPR 3.
- Не відображати raster більше за його density target.
- Не використовувати background-image для semantic content.
- Для animated layers задавати transform-origin або pivot у manifest.

---

## 23. Оптимізація

1. Зберегти lossless master.
2. Видалити зайві metadata.
3. Перевірити alpha до compression.
4. Зробити точний downscale.
5. Провести lossless optimization.
6. Створити WebP/AVIF delivery.
7. Візуально порівняти з master на target backgrounds.
8. Перевірити file size.
9. Застосувати sharpening лише якщо downscale справді м’який.
10. Перевірити у браузері на реальному DPR.

Не рекомендується агресивне compression, яке створює ringing, banding або брудні краї навколо transparent object.

### Crop algorithm для raster alpha

1. Відкрити RGBA master.
2. Створити binary visibility mask із threshold, наприклад alpha ≥ 24–32.
3. Знайти bbox цієї mask.
4. Crop original RGBA за bbox.
5. Додати intentional padding.
6. Розрахувати content limit як final size minus 2 × padding.
7. Downscale content.
8. Перевірити final dimensions.

Threshold підбирають візуально: він не повинен відрізати реальний soft glow.

---

## 24. Definition of Done

### Одна іконка

- [ ] Semantic meaning затверджене.
- [ ] Icon відповідає style guide.
- [ ] Працює у target rendered size.
- [ ] Має потрібний optical variant.
- [ ] Alpha технічно коректна.
- [ ] Safe area та optical center перевірені.
- [ ] Theme backgrounds пройдені.
- [ ] Density exports створені.
- [ ] Naming і dimensions правильні.
- [ ] File size оптимізований.
- [ ] Icon протестована у реальному UI.

### Повний набір

- [ ] Усі semantic meanings покриті.
- [ ] Reference icon і style lock задокументовані.
- [ ] Contact sheet не показує style drift.
- [ ] Visual weight, camera, light і detail density узгоджені.
- [ ] Optical sizes узгоджені.
- [ ] Alpha QA пройдено для всіх assets.
- [ ] Dark/light strategy послідовна.
- [ ] Export matrix повна без зайвих файлів.
- [ ] Naming та manifest передані команді.
- [ ] Реальні компоненти протестовані.
- [ ] Source masters збережені.

Великий красивий preview не є Definition of Done.

---

## 25. Операційний checklist

1. Semantic inventory.
2. Target sizes та platforms.
3. Icon classification.
4. Style lock.
5. Reference icon.
6. Three-shape pilot.
7. Group review.
8. Controlled batch generation.
9. Alpha cleanup.
10. Visible-bounds crop + intentional padding.
11. Optical-size adaptation.
12. Density export.
13. Theme/background QA.
14. Compression QA.
15. Real UI test.
16. Manifest, naming та source archive.

---

## Підсумковий retrospective

Найбільші втрати часу виникали не через якість генерації, а через нечітко зафіксовані інваріанти: semantic meaning, точна форма, camera, material, safe area, target size і transparency pipeline. Найкращі результати давали промпти, де reference images мали явні ролі, а зміни були локальними.

Головний універсальний висновок: **спочатку треба затвердити систему, потім одну reference icon, потім три різні тестові форми, і лише після цього масштабувати генерацію на весь набір**.

Production pipeline не завершується генерацією. Після неї обов’язкові alpha cleanup, crop, optical-size adaptation, density export, compression comparison і тестування у реальному UI.

---

## Self-review документа

- [x] Методологія не прив’язана до конкретного бренду, тематики, палітри чи персонажа.
- [x] Source size, logical size, canvas size, rendered size та export size розділені.
- [x] Є точна таблиця @1x/@2x/@3x.
- [x] Описано iOS scale та Android density buckets.
- [x] True alpha відрізнено від background removal і fake transparency.
- [x] Safe area, visible bounds і animation padding враховані.
- [x] Small, Medium і Large optical sizes описані окремо.
- [x] QA включає real UI, multiple backgrounds і target sizes.
- [x] Генерація, обробка, експорт та інтеграція чітко розділені.
