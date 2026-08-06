# Performance & Delivery: mobile-first бюджет лендінгу

Performance — окремий гейт, а не фінальне «стиснути картинки». Рішення про формат hero, кількість
асетів, шрифти, motion і integration mode приймаються ще в брифі, тому що саме вони визначають вагу,
LCP, CPU/GPU cost і поведінку всередині host-продукту.

## 1. Mobile-first як порядок роботи

Непорушна послідовність для дизайну, CSS і QA:

1. **375 px** — базова композиція, P0-контент, typography scale і touch targets.
2. **430 px** — основний широкий mobile, перевірка balance і media scale.
3. **440 px** — контрактний артефакт і край mobile range.
4. Поточний top-10 із `DEVICE-TEST-MATRIX.md`, 320 smoke і landscape.
5. **1440 px** content-only desktop.
6. Host context із реальним header/footer/navigation.

Desktop не є джерелом, яке потім «стискають». Він розширює вже валідну mobile-ієрархію.

## 2. Performance budget фіксується у G1

Запиши у Technical Brief:

| Бюджет | Базова ціль |
|---|---:|
| LCP p75 mobile | ≤ 2.5 s |
| INP p75 mobile | ≤ 200 ms |
| CLS | ≤ 0.1 |
| Initial route JS | ≤ 180 KB gzip |
| Critical CSS | ≤ 35 KB gzip |
| Hero poster | ≤ 300 KB mobile / ≤ 500 KB desktop |
| Один прозорий icon/cutout | бажано ≤ 150 KB у delivery size |
| Усі fonts першого екрану | бажано ≤ 120 KB |
| Hero motion | project-specific; окреме byte/CPU обґрунтування |

Якщо visual direction не вкладається — потрібен waiver з owner-ом, причиною й мобільним виміром.

## 3. Production assets

- Lossless PNG/PSD/Figma export зберігається як **master**, не як production delivery за замовчуванням.
- Усі raster delivery-файли — **WebP**; для фото/background можна додати AVIF, але WebP лишається
  сумісним fallback.
- Standalone icon, mascot, CatBox, podium, glow-object або composited character за замовчуванням має
  **справжній alpha channel**.
- Зображення з фоном — окрема asset task: визначити slot, ratio, responsive crop, safe zone, mobile
  variant і спосіб seam/edge blend. Не «запікати фон» випадково в icon generation.
- Не постачати source, raw generations, contact sheets і старі версії у production bundle.
- `srcset`/`sizes` використовуються, коли rendered width materially відрізняється між mobile/desktop.
- Кожне media має width/height або `aspect-ratio`; лише LCP media eager/high priority, решта lazy.

## 4. Motion decision: CSS → video → frame sequence

Порядок означає не «CSS завжди перемагає», а порядок перевірки найдешевшого достатнього рішення.

| Варіант | Обирай, коли | Рахуй | Обов'язковий fallback |
|---|---|---|---|
| CSS transform/opacity | float, pulse, glow, hover, просте переміщення/масштаб | CSS bytes, compositor cost, кількість infinite layers | static final state + reduced motion |
| Video (MP4/WebM) | складна character/lighting/fur анімація, яку CSS не відтворить | poster + mobile/desktop video bytes, decode cost, autoplay policy | poster; Save-Data/RM не завантажують video |
| Frame sequence | потрібна точна alpha/scroll/frame control і video не підходить | **сума всіх frames**, requests/package overhead, memory after decode, FPS | first/final frame; reduced sequence |

Для кожного animated slot у брифі заповни:

```text
Purpose → CSS candidate bytes/limits → Video bytes/limits → Sequence bytes/limits
→ mobile CPU/memory risk → recommendation → poster/static state → reduced-motion behavior
```

Не рекомендуй frame sequence, поки не порахована стиснена сума кадрів і decode memory. Не рекомендуй
video, якщо короткий CSS transform дає той самий зміст. Не додавай reveal-on-scroll «для живості».

## 5. Fonts

- Лише сімейства й weights, які реально використовуються.
- Delivery — WOFF2; subset включає фактичні українські/латинські glyphs і валютні символи.
- Display font не дублюється у кількох повних TTF/OTF.
- `font-display: swap`; critical line breaks перевірені до/після font swap.
- Не preload-ити кожен weight: максимум ресурси, які потрібні у першому viewport.

## 6. Runtime і integration mode

### Full-page/component embed

- scoped root/tokens; не постачати host chrome;
- не дублювати host libraries;
- перевірити CSS collision, background seam, sticky offsets і route/analytics adapter.

### Iframe

- статичний child document; bridge лише для height/navigation/analytics/config;
- `postMessage` origin allow-list; no scroll-jacking;
- не покладатися на parent scroll для animation triggers;
- перевірити first height, resize, top navigation, CSP і autoplay permission.

### Standalone

- landing володіє metadata, header/legal boundary, direct navigation і error fallback;
- не тягнути embed bridge, якщо він не потрібен.

## 7. Static delivery contract

Типовий фінальний пакет:

```text
delivery/
  index.html
  _nuxt/                 # лише generated JS/CSS, якщо він потрібен
  assets/
    images/              # лише allow-listed WebP/SVG
    fonts/               # subset WOFF2
    video/               # лише approved sources/posters
  content/
    copy.json
    actions.json
  asset-manifest.json
  build-report.json
```

Nuxt/Vue є build authoring stack; production результат для SSG має відкриватися як статичний HTML +
assets без application server. Якщо інтерактивність реалізується чистим HTML/CSS, не постачай зайвий
runtime. Build script має allow-list delivery files і падати на missing/oversized critical asset.

## 8. Optimization pass

1. Зібрати production output.
2. Порахувати **весь delivery bundle**, перший route, fonts, media й video окремо.
3. Видалити raw/unused/duplicate assets із output, не лише з imports.
4. Перевірити alpha, dimensions, lazy/eager, preload і cache-friendly filenames.
5. Перевірити 375/430/440 на slow mobile profile, Save-Data і reduced motion.
6. Заміряти LCP/CLS/INP у production mode.
7. Зафіксувати budget table `target / actual / pass / waiver` у `build-report.json` або QA report.

## 9. G10 Performance Green

- [ ] Mobile 375 є baseline; desktop не приховав mobile regression.
- [ ] Raster delivery — WebP; alpha потрібних cutouts перевірено на checkerboard і реальному фоні.
- [ ] Background assets мають окремий approved crop/safe-zone contract.
- [ ] Motion choice має byte/CPU recommendation; Save-Data/RM fallback працює.
- [ ] Немає unused source/raw assets у delivery bundle.
- [ ] Fonts subsetted WOFF2 і використовуються лише потрібні weights.
- [ ] Static output відкривається напряму; CTA, legal, content і analytics не залежать від dev server.
- [ ] Actual metrics і bundle sizes записані; waiver-и погоджені.
