# Артнапрям SlotCity

**Design System version:** `0.9`

## Маршрутизація сімейств

| Requested asset | Use | Do not substitute |
|---|---|---|
| UI/navigation/control icon | canonical vector UI component | expressive 3D icon |
| Expressive reward/benefit/status object | 3D icon family | hero scene or cinematic banner |
| Hero/promo/card illustration | landing art family | complete UI, baked copy or decorative-only background |
| Glow/gradient/particles/pattern | decorative background effects | narrative object or character |
| Mascot/character identity | approved character passport | inference from historic art |

## Сімейство 3D-іконок

### Базова формула

Компактний округлий об’єкт із відчутним об’ємом, фронтальним або м’яким 3/4 ракурсом і неглибокою перспективою. Використовуйте глянцеві
colored plastic/metal and limited translucent glass, violet–magenta–cyan light, bright rim light and soft
glow. One dominant object or a tight group remains readable at 72–132 px; it is not a miniature scene.

| Role | Context | Target | Objects | Fill |
|---|---|---:|---:|---:|
| `landing/3d-icon/standard` | card, step, reward, benefit | 72–132 px | 1–3 | 60–80% |
| `landing/3d-icon/compact` | status, support, app block | 28–84 px | 1 | component preferred |
| `landing/3d-icon/hero-accent` | hero support | 160–360 px | 1–3 | role-dependent |
| `campaign/3d-icon/seasonal` | one isolated campaign set | slot-defined | 1–3 | consistent set |

Обов’язково: читабельний силует на 72 px; округла геометрія; видима товщина; максимум 2–3 узгоджені матеріали;
cold neon base plus one story accent; colored rim, local white highlights, soft glow; no crop; one camera
direction per set.

Заборонено: матова глина, природні/фотореалістичні текстури, пласка векторна форма, глибока ізометрія, понад три
equal objects, complex environment/character, pastel/earth palette, long black shadow, full chrome,
micro-details or text. Seasonal toy-like rendering is a separate campaign substyle and cannot mix with
the neon family.

## Сімейства зображень для лендінгів

Виберіть одне сімейство з доказів:

- `cinematic-character`: coherent characters in an environment; realistic/stylized rendering must not
  mix inside one body/material system.
- `glossy-3d-object`: one dominant reward/campaign object or 2–3 linked objects.
- `world-building`: environmental campaign scene with controlled focal point and depth.
- `transparent-cutout`: isolated decorative subject for editable composition.

Історичні стилі не змішуються автоматично.

### Матриця ролей

| Role | Graphic zone | Content safe zone | Main subjects | Crop/depth |
|---|---:|---:|---:|---|
| Hero side layout | 55–70% | opposite 30–40% | 1–2 | 3 planes; environment 15–25%, never face/hands/prize |
| Hero central art | central 45–60% | external band | 1–2 | subject height 55–85% |
| Promo banner | 40–65% | 30–45% | 1 or 2–3 linked | secondary environment up to 25% |
| Horizontal card | 45–60% | 40–55% | 1 object/fragment | shallow/medium; defining feature intact |
| Vertical card | 55–75% | top/bottom 25–35% | 1 or compact pair | portrait recomposition |
| Square card | central 60–75% | top/bottom 20–30% | 1 group | survives centered 10–15% crop |
| Section background | outer 20–35% | central/content side 40–60% | no critical object | shallow, crop-tolerant |

Якщо desktop ширший за 2:1, потрібна окрема mobile-композиція, якщо немає погодженої центральної safe
core is explicitly documented. Do not blindly crop. On mobile, reserve a 20–30% top/bottom content band
and keep the subject in the central 60–85% when using hero art.

## Декоративні фонові ефекти

Базова формула: темна основа + одна пов’язана glow-група + за потреби одна вторинна текстура. Вибирайте не більше
one of particles, noise or pattern; transition shadow may coexist because it is structural.

| Effect | Contract |
|---|---|
| Atmospheric abstraction | cyan/ice-blue/lilac; component opacity 20–50%; contour blur 5–30, glow 50–100, atmosphere 200–300 px |
| Campaign Sticky Gradient | 550×550 zone; 2–3 fields; blur 200–250 px; opacity 20–70%; one campaign color family |
| Structured light | paired lines/sparse dots; line opacity 30–60%; blur 8–30 plus 50–100 px glow |
| Transition gradient/shadow | linear fade about 700–1200×140–160 near graphic/content boundary |

Використовуйте 2–3 споріднені відтінки, одну домінантну й одну допоміжну зону. Зони copy лишайте темнішими й стабільними. Mesh-like
gradients are only a hypothesis implemented through 2–4 overlapping fields, not a canonical mesh system.
UI background blur належить до системи компонентів і не входить до scope декоративних ефектів.
