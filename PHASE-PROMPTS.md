# Фазові промпти — готові до вставки брифи для high-end промо-лендінга

> Призначення: один самодостатній copy-paste промпт на кожну фазу для побудови промо-лендінга рівня
> Awwwards, придатного до вбудовування (Nuxt 3 / Vue 3 / TS, SSG). Кожен промпт самодостатній — передай
> його агенту (чи колезі) окремо, і він несе власну ціль, вхідні дані, deliverables, обмеження та
> критерії завершення.

## Як користуватися цим файлом

- Виконуй фази по порядку. Назви фаз збігаються зі спільним словником, який використовується в усьому
  пакеті методології (див. cross-references внизу): **Discovery (дослідження) → Нормалізація вимог →
  Концепція → Розкадровка (storyboard) → Технічний план → Дизайн-основи → Скафолдинг проєкту →
  Реалізація Hero → Реалізація секцій → Motion → Адаптив → Оптимізація асетів → Iframe/embed-інтеграція →
  Аналітика → QA → Деплой → Post-launch review (ретроспектива).**
- Список задач, який тобі дали ("discovery, concept, architecture, project setup, design system, hero,
  sections, animation, responsive, performance, iframe, QA, final audit"), мапиться на ці назви фаз —
  мапінг зазначено в заголовку кожної секції.
- Кожен промпт повторює невеликий блок **Standing constraints**, щоб він працював поза контекстом.
  Обрізай продубльовані обмеження, якщо запускаєш кілька промптів поспіль.
- Мітки claim-ів, що використовуються всюди: **Спостережено** (побачено в reference-білді), **Виведено**
  (логічний висновок), **Рекомендовано** (на перспективу). Не подавай Рекомендовано/Виведено як
  Спостережено.

### Standing constraints (істинні для кожної фази — вбудовуй їх inline при вставці одного промпта)

```
- Stack — Nuxt 3 (v3.x) + Vue 3 + TypeScript, <script setup lang="ts"> усюди. НЕ Nuxt 4:
  ігноруй будь-які поради про app/ srcDir, аліаси ~/@ → app/ чи Nuxt-4-only API.
- Rendering target: SSG (nuxi generate) — статичний єдиний роут, якщо серверна логіка справді не потрібна.
- Стилі: власноруч написаний CSS з CSS custom properties як design tokens. Без Tailwind / UI-kit.
- Brand-neutral: використовуй placeholder-и (--color-accent, "the product", "the hero subject", "Section A").
  Ніколи не хардкодь реальну назву бренду, назву кампанії, маскота, копірайт чи hex-значення у спільні артефакти.
- prefers-reduced-motion: reduce — це first-class режим: без scrub/parallax/pinning/autoplay-відео,
  контент доступний одразу, статичний poster для hero.
- Performance budget (цілі — перевіряй, не припускай): LCP ≤ 2.5s, INP ≤ 200ms, CLS ≤ 0.1 (p75);
  initial route JS ≤ ~180KB gzip; hero LCP — це POSTER-ЗОБРАЖЕННЯ, не відео.
- Придатний до вбудовування: сторінка постачається всередині host-продукту. Обери full-page embed vs
  iframe embed рано (див. фазу Iframe/embed). Скоупни весь CSS під єдиним root-класом; не чіпай host globals.
- Перевіряй доказами: розміри production-білда, вимірювання в браузері та математична симуляція — не на око
  й не за припущенням.
```

---

## 1. Discovery (дослідження)
_Аліас у списку задач: "discovery". Фаза: Discovery (дослідження)._

```
ЦІЛЬ
Встанови продуктову правду для промо-лендінга до будь-якого дизайну чи коду. Створи єдиний
source-of-truth бриф, з якого читає кожна наступна фаза.

ВХІДНІ ДАНІ, ЯКІ Я НАДАМ
- Реальну механіку кампанії (чим насправді є оферта/подія), аудиторію та ОДНУ конверсійну
  ціль. Будь-які legal/compliance-обмеження (age gating, текст ліцензії, посилання на повні правила).
- Host-продукт, у який це вбудовується: його домен, оформлення header/footer і dark/light chrome.
- Реальні призначення CTA (route URL) — або примітку, що вони ще TBD.

DELIVERABLES
1. PRODUCT.md, що містить: value proposition в одне речення; єдину основну конверсійну дію;
   персону(и) аудиторії; точну механіку простою мовою; інвентар копірайту (заголовки, лейбли секцій,
   лейбли CTA) з РЕАЛЬНИМ копірайтом, якщо надано, інакше чітко позначені TODO-placeholder-и; будь-які
   compliance/legal-блоки та посилання, яких вони потребують.
2. Список відкритих blocker-ів (кожен з owner-ом) — особливо: точні CTA URL, висоти header/footer
   host-а + кольори тла, дозволені origin-и асетів (CSP).
3. Явний список "do not invent": цифри, testimonials, метрики чи твердження, які мають надходити від
   бізнесу й ніколи не мають бути сфабриковані.

ОБМЕЖЕННЯ
- НЕ копіюй жодного конкретного competitor/Awwwards-сайту. Фіксуй правду, ще не дизайн.
- НЕ фабрикуй статистику, testimonials чи цифри оферти. Позначай невідоме як blocker-и.
- Лише одна конверсійна ціль. Якщо стейкхолдери назвуть кілька, примусово визнач основну, а решту знизь.

КРИТЕРІЇ ЗАВЕРШЕННЯ
- PRODUCT.md існує, і читач без жодного попереднього контексту зміг би описати оферту й один CTA.
- Кожна цифра/твердження або має джерело, або позначена TODO. Жодних вигаданих фактів.
- Список blocker-ів називає CTA URL і специфіку header/footer host-а як явні невідомі, якщо їх ще не
  надано.
```

---

## 2. Нормалізація вимог
_Фаза: Нормалізація вимог. (Окремого аліаса у списку задач немає — роби це одразу після Discovery.)_

```
ЦІЛЬ
Перетвори сирий бриф на однозначні, тестовані вимоги, щоб наступні фази не переглядали scope наново.
Ця фаза існує тому, що виправлення в reference-білді групувалися навколо двох осей: SCOPE зміни
(один блок vs усюди) та MOBILE-специфічна поведінка. Винеси обидві наперед.

ВХІДНІ ДАНІ
- PRODUCT.md з Discovery. Список відкритих blocker-ів.

DELIVERABLES
1. Таблиця вимог: кожен рядок = можливість сторінки з (a) desktop-поведінкою, (b) явною mobile-
   поведінкою (mobile — це ОКРЕМА art direction, ніколи не "scaled desktop"), (c) reduced-motion-поведінкою,
   (d) acceptance-перевіркою.
2. Decision log, засіяний виборами, які було дорого змінювати пізно в reference-білді:
   режим вбудовування (full-page vs iframe), тип hero LCP-асета (poster-зображення), motion-модель для
   будь-якої "signature" інтерактивної секції (і чи має вона бути swappable), та content-source-модель
   (inline vs config-шар).
3. Standing working agreement: цикл "design → agree → build"; спершу перевіряй на localhost; НЕ
   деплой до явного апруву. Вважай локальну перевірку + апрув на деплой жорстким гейтом.

ОБМЕЖЕННЯ
- Кожна вимога має бути індивідуально тестованою (фаза QA її перевірятиме).
- Для будь-якої visual/behavior-вимоги вкажи ТОЧНИЙ елемент(и), до якого вона застосовується — уникай
  "all titles", коли маєш на увазі один блок (реальний урок over-reach з reference-білда).

КРИТЕРІЇ ЗАВЕРШЕННЯ
- Жодна вимога не є неоднозначною щодо scope чи mobile-трактування.
- Режим вбудовування, тип hero LCP, signature-motion-модель і content-source-модель кожна мають
  зафіксоване рішення (або owner + deadline).
- Гейт "don't deploy until approved" записаний.
```

---

## 3. Концепція
_Аліас у списку задач: "concept". Фази: Концепція (+ Розкадровка (storyboard), далі)._

```
ЦІЛЬ
Створи ОДНУ сильну art direction — єдину центральну візуальну метафору, один контрольований естетичний
ризик — не три несміливі опції й не формульний layout "centered hero + gradient + три однакові картки +
glassmorphism".

ВХІДНІ ДАНІ
- PRODUCT.md, таблиця вимог, chrome host-продукту (щоб краї можна було color-match-нути).

DELIVERABLES
1. Спершу 2–3 direction-кандидати (логіка layout, type pairing, palette intent, interaction vocabulary,
   та названі анти-патерни, яких уникати), ПОТІМ рекомендація, що згортається до однієї direction.
2. Обрана direction як one-page концепція: центральна метафора, емоційна ціль, один
   свідомий ризик та interaction vocabulary (як motion має ВІДЧУВАТИСЯ, ще не як він закодований).
3. Palette + type INTENT, виражені як ролі токенів (`--color-bg`, `--color-surface`, `--color-accent`,
   `--color-accent-2`, `--font-display`, `--font-ui`) — ролі й відношення, не фінальні hex-значення.
4. Явний anti-slop список: кліше, від яких цей дизайн відмовляється.

ОБМЕЖЕННЯ
- Brand-neutral у цьому документі: описуй accent як `--color-accent`, не hex; описуй hero-
  subject узагальнено. Реальні значення приходять у Дизайн-основах.
- Краї сторінки (top/bottom) мають вміти color-match-нутися до dark/light chrome host-а для
  безшовного шва — заклади це в palette intent.
- Mobile — це власна art direction; накидай її як окрему концепцію, не reflow.

КРИТЕРІЇ ЗАВЕРШЕННЯ
- Обрано й обґрунтовано рівно одну direction проти кандидатів.
- Одна центральна метафора й один названий естетичний ризик записані.
- Palette/type виражені як РОЛІ токенів; жоден формульний hero/card layout не виживає.
```

---

## 4. Розкадровка (storyboard)
_Фаза: Розкадровка (storyboard). (Виконується разом із Концепцією.)_

```
ЦІЛЬ
Впорядкуй сторінку в секції з визначеними ролями та розкадруй motion beats — щоб реалізація
знала, що має робити кожна секція й де signature-моменти.

ВХІДНІ ДАНІ
- Обрана концепція. Інвентар копірайту PRODUCT.md.

DELIVERABLES
1. Порядок секцій із використанням role vocabulary (обери підмножину, що пасує — це decision
   system, а не фіксований шаблон):
   Hero → Value/Explanation → Mechanics/Benefits → Visual storytelling → Proof/Trust → FAQ/Legal →
   Final CTA.
2. Для кожної секції: її роль, копірайт, який вона несе (з PRODUCT.md), її задуманий motion beat та її
   reduced-motion fallback.
3. Позначена "signature"-секція (той один важкий, запам'ятовуваний інтерактивний момент) з приміткою, що
   її motion-модель має бути вирішена рано й лишатися swappable (пізній запит "rebuild this section's
   interaction" був дорогим у reference-білді).
4. Приблизний список асетів на кожну секцію (hero poster + video, декоративні stills, іконки).

ОБМЕЖЕННЯ
- Кожна секція володіє ОДНІЄЮ задачею. Не склеюй два конверсійні запити в одну секцію.
- Кожен motion beat потребує reduced-motion-еквіваленту, зазначеного зараз, не пізніше.

КРИТЕРІЇ ЗАВЕРШЕННЯ
- Кожна секція має роль, копірайт, motion beat та reduced-motion fallback.
- Signature-секцію ідентифіковано й позначено swappable.
- Список асетів достатньо повний, щоб брифувати фази генерації/оптимізації.
```

---

## 5. Технічний план
_Аліас у списку задач: "architecture". Фаза: Технічний план._

```
ЦІЛЬ
Визнач технічну форму до скафолдингу: рендеринг, структуру, motion-бібліотеки, стратегію асетів,
контракт вбудовування та content-source-модель.

ВХІДНІ ДАНІ
- Концепція + storyboard. Таблиця вимог + decision log. Host CSP / дозволені origin-и асетів, якщо відомі.

DELIVERABLES
1. Рішення про рендеринг (за замовчуванням: SSG через nuxi generate для єдиного статичного роуту) з обґрунтуванням.
2. План директорій. Reference-білд постачав пласку структуру, яка спрацювала: тонкий app.vue shell
   (root-клас + <main>, що перелічує компоненти секцій — НЕ монолітний), один компонент на секцію, та
   перевикористовувані декоративні primitive-и (SVG з `uid` prop, щоб уникнути колізій id). Для
   ПЕРЕВИКОРИСТОВУВАНОГО starter-а подай цей Рекомендований поділ як decision system:
     components/   generic primitives (buttons, decor, media)
     sections/     one file per page section
     motion/       animation composables + motion tokens
     config/ + content/   data-driven copy/assets (the content-source layer)
     composables/  useMotionPrefs, magnetic hover, iframe bridge (if iframe)
     plugins/      gsap.client, smooth-scroll.client, idle-sections.client
     assets/css/   tokens.css + base.css
     public/img, public/video   local assets (mirrored to CDN at deploy)
   Зауваж Спостережену слабкість, якої уникати: контент, захардкоджений усередині кожного компонента, робить
   swap-и теми/копірайту дорогими; надавай перевагу content config-шару. Одна секція, що переростає ~600
   рядків — це сигнал її розділити.
3. Рішення про motion stack: GSAP + ScrollTrigger (client-only plugin), smooth-scroll-бібліотека, керована від
   gsap.ticker (пропускається під reduced-motion), плюс власноруч написаний requestAnimationFrame лише для
   bespoke-сцени, та CSS @keyframes для ambient-декору. Tree-shake GSAP лише до того, що використовується.
4. Стратегія асетів: AI-generated чи надані stills як WebP з responsive srcset/sizes; прозорий
   PNG/WebP для floating-декору; poster-frame на кожне відео; асети розміщені на CDN і референсяться за URL.
5. Рішення про контракт вбудовування (full-page embed vs iframe) — перенеси правило вибору з
   фази Iframe/embed і зафіксуй, який режим постачається.
6. Шкала z-index layering (напр. fixed background decor `--z-decor` негативний; per-section decor 0;
   content `--z-content` 1+; grain/overlay вище), щоб запобігти stacking-багам.

ОБМЕЖЕННЯ
- Nuxt 3, не 4. Browser globals лише в onMounted / client plugins / import.meta.client.
- Тримай initial JS budget в полі зору (≤ ~180KB gzip) — жодних важких бібліотек "just in case".

КРИТЕРІЇ ЗАВЕРШЕННЯ
- Рендеринг, directory-модель, motion stack, стратегію асетів, режим вбудовування, content-source-модель та
  z-index-шкалу кожне вирішено й записано.
- План називає, де живуть питання reduced-motion, cleanup та CSP/asset-origin.
```

---

## 6. Дизайн-основи
_Аліас у списку задач: "design system". Фаза: Дизайн-основи._

```
ЦІЛЬ
Заповни token-шар реальною design-системою, щоб кожен компонент стилізувався через var(--x), а майбутній
restyle був token-редагуванням, а не переписуванням компонента.

ВХІДНІ ДАНІ
- Palette/type intent обраної концепції. Будь-який brand style guide, що надає бізнес (тримається ПОЗА
  shared/neutral-артефактами — реальні значення живуть лише у проєкті, не в цьому methodology-документі).

DELIVERABLES
1. tokens.css, заповнений категоріями:
   - color: --color-bg, --color-surface, --color-accent (+ hover/active), --color-accent-2, alert.
   - typography: --font-display, --font-ui, fluid size-шкала через clamp(), weights.
   - spacing-шкала (--space-*), --radius-pill + висоти кнопок (напр. 56/44/32/24px), section padding.
   - motion: --t-micro, --t-ui тривалості; --ease-enter easing.
   - layering: z-index-шкала (--z-decor, --z-content, ...).
   - layout: ширина --container.
   Рекомендовані додатки для перевикористання: shadow, blur, opacity, breakpoints, інтенсивності декоративних ефектів.
2. base.css primitive-и, побудовані з токенів: pill-кнопки (усі розміри/типи), heading-шкала, reveal-
   утиліта, reduced-motion overrides, ambient @keyframes.
3. Коротка token map (таблиця), що документує роль кожного токена, щоб restyle знав, що змінювати.

ОБМЕЖЕННЯ
- У спільному methodology-пакеті виражай токени як РОЛІ з placeholder-значеннями — ніколи не витікай
  реальний brand hex чи назву. У реальному репозиторії проєкту реальні значення — ок.
- Кнопки слідують типам/розмірам кнопок design-системи; pill radius — це токен, а не magic number.
- Дисципліна layering обов'язкова: контент завжди над декором; документуй шкалу.

КРИТЕРІЇ ЗАВЕРШЕННЯ
- Жоден компонент не потребує сирого hex чи px font-size; усе читається з токена.
- Кнопки, заголовки та reveal/reduced-motion primitive-и рендеряться лише з base.css.
- Swap --color-accent помітно рестайлить усю сторінку без редагувань компонентів (smoke test).
```

---

## 7. Скафолдинг проєкту
_Аліас у списку задач: "project setup". Фаза: Скафолдинг проєкту._

```
ЦІЛЬ
Підніми запускний Nuxt 3 скелет, що відповідає технічному плану, з token/base CSS-шаром і
client-only motion-плагінами, підключеними, але порожніми від реального контенту.

ВХІДНІ ДАНІ
- Технічний план (directory-модель, motion stack, rendering target).

DELIVERABLES
1. Nuxt 3 проєкт, запінений до nuxt@^3 (НЕ 4), TypeScript, npm, закомічений lockfile, Node 24.
2. nuxt.config.ts, налаштований для SSG, з:
   - @nuxt/fonts (self-hosted at build), що декларує display + UI faces.
   - app.head scaffolding для meta + preload LCP-poster-а (заповнюється у фазі Hero).
   - experimental.payloadExtraction: false для dataless статичного роуту (прибирає зайвий _payload.json
     preload/request).
3. assets/css/tokens.css (порожні ролі токенів як :root custom properties) + assets/css/base.css (reset,
   button/heading primitive-и, reveal-утиліта, gated за класом html.js, reduced-motion-блок,
   ambient @keyframes placeholder-и).
4. plugins: gsap.client.ts (реєстрація ScrollTrigger на клієнті; refresh після завантаження шрифтів),
   smooth-scroll.client.ts (пропускається під reduced-motion), idle-sections.client.ts (єдиний
   IntersectionObserver, що ставить offscreen ambient-анімації на паузу через toggle класу).
5. composables/useMotionPrefs.ts (реактивний prefers-reduced-motion helper).
6. Тонкий app.vue: root wrapper-клас (напр. `.promo-landing`) + <main>, що перелічуватиме компоненти
   секцій. Inline head-скрипт, що додає `html.js`, щоб no-JS показував увесь контент.

ОБМЕЖЕННЯ
- Жодного глобального CSS reset, що міг би конфліктувати з host-продуктом; скоупни все під root-класом.
- Browser globals лише всередині onMounted / client plugins / import.meta.client.
- Реєструй GSAP-плагіни лише на клієнті; загортай використання в gsap.context і revert на unmount.

КРИТЕРІЇ ЗАВЕРШЕННЯ
- `npm run dev` рендерить порожній shell без console-помилок і без hydration mismatch.
- `nuxi generate` продукує статичний білд.
- Reduced-motion-шлях уже short-circuit-ить smooth-scroll-плагін.
- html.js gating перевірено: з вимкненим JS семантичний контент присутній і видимий.
```

---

## 8. Реалізація Hero
_Аліас у списку задач: "hero". Фаза: Реалізація Hero._

```
ЦІЛЬ
Побудуй hero так, щоб його LCP був швидким, preloaded POSTER-ЗОБРАЖЕННЯМ (ніколи відео), з відео, що
програється поверх нього й ніколи не стає LCP.

ВХІДНІ ДАНІ
- Hero-копірайт + лейбл/URL CTA (з PRODUCT.md). Hero poster (responsive) + опційне looping-відео з
  asset pipeline. Design tokens.

DELIVERABLES
1. Компонент hero-секції з: poster як responsive <img> (srcset/sizes), preloaded через
   app.head з imagesrcset/imagesizes + fetchpriority="high", eager, явними width/height (або
   aspect-ratio) для контролю CLS.
2. Looping-відео, покладене ПОВЕРХ poster-а з preload="none", muted/inline/loop, playsinline для
   iOS, і play, керований ЛИШЕ IntersectionObserver (жодного .play() на mount). Додай Save-Data gate, щоб
   data-saver-користувачі завантажували нуль байтів відео. Під reduced-motion: без відео, лише статичний poster.
3. Основний CTA як реальне посилання на route URL (rel="noopener noreferrer", якщо external), стилізований з
   button-токенів.
4. НЕ став також <video poster=...>, якщо ти вже постачаєш poster <img> — це двічі фетчить
   poster. Лише одне джерело poster-а.

ОБМЕЖЕННЯ
- LCP-елемент має бути poster-зображенням, перевірено — не текстом, не відео.
- Правила iOS autoplay: muted + playsinline, інакше не заавтоплеїться.
- Явні розміри на кожному media-елементі.

КРИТЕРІЇ ЗАВЕРШЕННЯ
- У production-білді LCP — це preloaded poster з fetchpriority high (перевірено в
  браузері, не припущено).
- Network показує, що відео завантажується лише коли hero у в'юпорті, і НЕ завантажується взагалі під Save-Data чи
  reduced-motion.
- Жодного layout shift від hero (внесок у CLS ≈ 0); жодного дубльованого фетчу poster-а.
```

---

## 9. Реалізація секцій
_Аліас у списку задач: "sections". Фаза: Реалізація секцій._

```
ЦІЛЬ
Побудуй кожну не-hero-секцію як ізольований компонент, що володіє своїм контентом і своїм animation lifecycle,
слідуючи ролям storyboard.

ВХІДНІ ДАНІ
- Storyboard (ролі секцій + копірайт + motion beats). Design tokens. Декоративні primitive-и.

DELIVERABLES
1. Один компонент на кожну storyboard-секцію (Value/Explanation, Mechanics/Benefits, Visual storytelling,
   Proof/Trust, FAQ/Legal, Final CTA — залежно від того, що обрав storyboard).
2. Перевикористовувані декоративні primitive-и (напр. inline-SVG decor-компонент з `uid` prop, щоб повторювані
   інстанси не колізували на SVG id; fixed-position ambient background primitive).
3. Кожну секцію підключено в <main> app.vue. Контент витягується з content-config-шару, якщо
   технічний план обрав його (Рекомендовано) — інакше тримається в компоненті, але структурований як data-
   масиви для легкого вилучення пізніше.
4. Усі CTA вказують на РЕАЛЬНІ роути — жодних placeholder "#"-посилань.
5. Legal/compliance-блоки відрендерені там, де потрібно (age gating, посилання на правила) з PRODUCT.md.

ОБМЕЖЕННЯ
- Жодної animation-логіки в шаблонах — composable/компонент володіє lifecycle і cleanup кожної секції.
- Якщо будь-яка окрема секція переростає ~600 рядків, розділи її (Спостережений smell).
- Контент завжди рендериться над декором (z-index-шкала); семантичний текст не ховається pre-JS.

КРИТЕРІЇ ЗАВЕРШЕННЯ
- Кожна storyboard-секція рендериться з реальним копірайтом і реальними CTA URL.
- Декоративні primitive-и перевикористовуються без колізій id.
- Жодних console-помилок; жодного hydration mismatch; контент видимий з вимкненим JS.
```

---

## 10. Motion
_Аліас у списку задач: "animation". Фаза: Motion._

```
ЦІЛЬ
Додай motion-шар — scroll reveals, ambient-декор і будь-яку signature bespoke-сцену — зі строгим
cleanup, reduced-motion parity та доказовою non-collision для looping movers.

ВХІДНІ ДАНІ
- Побудовані секції. Storyboard motion beats. Тривалості/easings design-токенів. useMotionPrefs.

DELIVERABLES
1. Scroll reveals через GSAP + ScrollTrigger, загорнуті в gsap.context(scope); cleanup через ctx.revert()
   + ScrollTrigger.kill() в onUnmounted. Reveals анімують opacity/transform ЛИШЕ. Reveal-hidden CSS
   gated за html.js, щоб no-JS показував усе.
2. gsap.matchMedia('(prefers-reduced-motion: no-preference)') gates усю scroll-анімацію; reduced-
   гілка встановлює фінальні стани миттєво (autoAlpha:1, y:0) і перераховує на resize (hoist reduced-
   flag; повторний запуск на ResizeObserver — статичний reduced layout, що ніколи не перераховувався на resize,
   був реальним багом).
3. Ambient CSS @keyframes (drift/spin/float) — compositor-only й СТАВЛЯТЬСЯ НА ПАУЗУ, коли їхня секція
   offscreen, через спільний idle-sections IntersectionObserver, що перемикає animation-play-state: paused.
   Жодної нескінченної offscreen ambient-анімації.
4. Якщо є bespoke requestAnimationFrame-сцена (напр. orbiting movers): transform-only на кадр
   (translate3d + scale + rotate), will-change:transform ЛИШЕ на movers, ResizeObserver для повторного вимірювання,
   cursor-parallax gated до (hover:hover) і (pointer:fine). Пауза offscreen З time-continuity
   (акумулюй paused time, щоб motion відновлювався безшовно, а не стрибком). Reduced-motion → статична
   layout-функція, без rAF.
5. Для looping movers: дай КОЖНОМУ mover-у однаковий кутовий період і рівномірно розподілені фази
   (constant spacing, ніколи не lapping); варіюй radius на mover для глибини; розміщуй entry/exit-точки
   off-screen, щоб шов loop-а був невидимим. Доведи collision-free МАТЕМАТИЧНОЮ СИМУЛЯЦІЄЮ, перш ніж довіряти оку.

ОБМЕЖЕННЯ
- Ніколи не створюй tween щокадру scroll-а. У ScrollTrigger onUpdate роби tween лише на state FLIP,
  не на кожен update (реальний per-frame-tween баг).
- Уникай per-frame-алокацій і read/write reflow thrash усередині rAF; захищай per-frame-роботу.
- Анімуються лише transform/opacity; жодної анімації layout-властивостей.

КРИТЕРІЇ ЗАВЕРШЕННЯ
- Усі GSAP/ScrollTrigger/observers прибираються на unmount (жодних дубльованих timelines після навігації).
- Reduced-motion показує повну, статичну, resize-коректну сторінку з нульовим scrub/parallax/autoplay.
- Ambient-анімації поставлені на паузу, поки їхня секція offscreen (перевірено).
- Будь-який інваріант looping-mover (no collision, clearance, seamless loop) доведений симуляцією, а
  bespoke-сцена відновлюється без видимого стрибка після offscreen.
```

---

## 11. Адаптив
_Аліас у списку задач: "responsive". Фаза: Адаптив._

```
ЦІЛЬ
Достав mobile як ВЛАСНУ art direction (не scaled desktop), з fluid sizing, без горизонтального
overflow, і motion-геометрією, що поважає реальний виміряний простір на коротких viewport-ах.

ВХІДНІ ДАНІ
- Побудовані + анімовані секції. Mobile art direction з Концепції/Storyboard.

DELIVERABLES
1. Fluid sizing через clamp(min, vw, max); перевірено на 320/360/375/390/768/1024/1440 + landscape.
2. svh/dvh-одиниці з fallback-ами; safe-area insets; coarse-pointer handling; без горизонтального overflow.
3. Окремі mobile-layout-и/art там, де storyboard цього вимагав — не просто менший desktop.
4. MEASURED-BAND mobile-motion для всього, що затиснуте між двома краями: коли верхній текстовий блок є
   content-driven (приблизно фіксована висота), а нижній visual трекає низ секції, НЕ прив'язуй
   motion до часток viewport height (cy = ch*k) — це заштовхує анімаційну дугу в текст на
   коротких екранах і лишає замало clearance знизу. Натомість ВИМІРЯЙ реальний проміжок між
   низом текстового блоку й верхом art-а в рантаймі (запуск measure() на mount + ResizeObserver) і
   прив'яжи motion band до цього виміряного проміжку.

ОБМЕЖЕННЯ
- Mobile — це окрема art direction (явне правило), ніколи не scale-down.
- iOS autoplay + safe-area + 100dvh fallback-и всі оброблені.
- Reduced-motion-поведінка має триматися на кожному breakpoint і перераховуватися на resize.

КРИТЕРІЇ ЗАВЕРШЕННЯ
- scrollWidth - clientWidth === 0 на кожній тестованій ширині (виміряно, не на око).
- На найкоротшому тестованому viewport анімовані елементи тримають clearance і від текстового блоку вгорі, і
  від art-а внизу — motion band виведений з виміряного проміжку, не з частки viewport.
- Layout тримається в landscape і з coarse pointer; safe-area поважається.
```

---

## 12. Оптимізація асетів
_Аліас у списку задач: "performance". Фаза: Оптимізація асетів._

```
ЦІЛЬ
Влучи в performance budget з перевіреними виграшами. Найбільшим важелем у reference-білді був FONT
SUBSETTING; інші — відкладання важкого відео, тримання LCP як poster-а та контроль CLS.

ВХІДНІ ДАНІ
- Повна побудована сторінка. app.head config. @nuxt/fonts config. Точний набір гліфів, що реально рендеряться.

DELIVERABLES
1. FONT SUBSET AUDIT (роби це першим — найбільший виграш). CJK-capable display-шрифт може постачати ~120
   unicode-range слайсів, здебільшого невикористаних, УСІ inlined як @font-face у HTML — масивно
   роздуваючи index.html (reference: 54KB → 14.6KB gzip після фіксу). Subset-ни server-side через опцію
   `glyphs`/`text=` font-модуля до ТОЧНИХ використаних гліфів. Надай ПОВНИЙ алфавіт, що реально
   рендериться, щоб жоден гліф не впав у fallback. Потім ВИМІРЯЙ побудований HTML: перевір, що кількість @font-face
   і кількість distinct woff2 схлопнулися (reference: 138→19 @font-face, 122→3 woff2). Проаудитуй, які слайси
   реально inline/download-яться — виміряй побудований файл, не припускай.
2. DEFER HEAVY VIDEO: будь-яке below-the-fold-відео має мати preload="none", play, керований виключно
   IntersectionObserver (без eager .play() на mount), і Save-Data gate. Нуль байтів відео для bounce-ів
   і data-saver-користувачів.
3. LCP = POSTER: підтверди, що hero LCP — це preloaded poster <img> з fetchpriority high, і що жоден
   зайвий <video poster=...> не фетчить його двічі.
4. font-display: swap + metric-matched fallback (size-adjust / ascent-override) для near-zero
   font-swap CLS (font-модуль може інжектнути їх).
5. experimental.payloadExtraction: false на dataless статичному роуті.
6. Явні width/height або aspect-ratio на КОЖНОМУ media-елементі.
7. Tree-shake motion-бібліотеку лише до того, що використовується (напр. GSAP core + ScrollTrigger). Підтверди, що
   основний JS-chunk лишається в межах budget (reference: ~116KB gzip загалом < 180KB target; CSS ~5KB gzip).

ОБМЕЖЕННЯ
- Вимірюй на реальному production-білді (nuxi generate), ніколи не dev-mode-розміри.
- Знай ліміти свого середовища: якщо ffmpeg/cwebp/avifenc/pyftsubset відсутні локально, ти НЕ МОЖЕШ
  транскодити відео чи re-compress/subset-ити медіа на диску — font subset має йти через build-time
  опцію модуля (яка викликає provider-а), а video/image-транскод, можливо, доведеться зробити upstream/CDN-
  кроком. Вкажи, які оптимізації твоє середовище реально може виконати.

КРИТЕРІЇ ЗАВЕРШЕННЯ
- Кількість @font-face і кількість distinct woff2 у побудованому index.html мінімізовані й підтверджені вимірюванням.
- Network-trace показує, що важке відео завантажується лише in-view, і ніколи під Save-Data/reduced-motion.
- LCP — це poster-зображення з fetchpriority high (перевірено).
- Загальний initial JS ≤ ~180KB gzip; media-елементи всі мають явні розміри; CLS ≤ 0.1.
```

---

## 13. Iframe/embed-інтеграція
_Аліас у списку задач: "iframe". Фаза: Iframe/embed-інтеграція._

```
ЦІЛЬ
Інтегруй лендінг у host-продукт. Існують ДВА режими — обери за правилом вибору, потім
реалізуй обраний. (Примітка чесності: reference-білд використовував FULL-PAGE EMBED і НЕ вправлявся в
iframe-інтеграції, тож уся iframe-специфіка нижче — Рекомендовано/Виведено, не Спостережено.)

ЯКЩО режим = IFRAME: існує ОФІЦІЙНИЙ контракт продукту — методологія/IFRAME-BRIDGE-INTEGRATION.md
(ядро assets/iframe-bridge.js копіюється без змін; IframeBridge.init(); loaded/height автоматично;
event_action для дій у продукті; token через onParentMessage; auth/locale/theme з config; БЕЗ
100vh/svh-розмірів; motion без scrub/pin — лише IO-reveal + time-based). Він авторитетний і має
пріоритет над узагальненими порадами нижче.

ВХІДНІ ДАНІ
- Рішення про режим вбудовування з технічного плану. Висоти header/footer host-а + кольори chrome.
  Host CSP / дозволені origin-и асетів. Реальні CTA route URL; для iframe — перелік event_action-id
  від контент-менеджерів.

ПРАВИЛО ВИБОРУ (обери одне)
- FULL-PAGE EMBED (Спостережено в reference-білді): продукт постачає header + footer; лендінг
  заповнює все між ними; БЕЗ iframe. Обирай, коли ти контролюєш host-шаблон і хочеш безшовний
  шов і спільні fonts/CSP. Простіше; без cross-origin messaging.
- IFRAME EMBED (Рекомендовано/Виведено): обирай, коли лендінг деплоїться окремо, на іншому
  origin-і, або host може лише вставити <iframe>. Потребує message-контракту для height + navigation.

DELIVERABLES — FULL-PAGE EMBED
1. Увесь CSS лендінга скоуплений під єдиним root-класом (напр. `.promo-landing`); жодних агресивних глобальних
   reset-ів; не модифікуй стилі header/footer host-а чи глобальний стан (cookies, localStorage keys).
2. Top/bottom-краї color-matched до dark/light chrome host-а для безшовного шва (з токенів).
3. CTA — це звичайні посилання на роути продукту (точні URL від бізнесу); external-посилання отримують
   rel="noopener noreferrer". Не потрібно postMessage/auto-resize.
4. Scroll-анімації враховують висоту sticky-header-а host-а в ScrollTrigger offsets. Жодного
   scroll-jacking; жодного захоплення wheel/touch/keyboard.
5. Асети сервляться з host-allowed origin-ів (поважай host CSP).

DELIVERABLES — IFRAME EMBED (Рекомендовано)
1. Лендінг заповнює 100% ширини; ніколи не припускай фіксовану px-ширину чи theme/fonts/CSP батька.
2. useIframeBridge() composable (child-сторона), що: вимірює власну висоту (ResizeObserver на
   document.documentElement) і postMessage-ить її вгору (debounced), щоб батько міг ресайзити iframe
   (батько не може читати child scrollHeight cross-origin); шле `landingReady` handshake; форвардить
   navigation-запити; форвардить analytics-події. Усі повідомлення використовують versioned, origin-allow-listed
   контракт: { source:'landing', type, payload }.
3. CTA, що мають навігувати TOP-вікно, використовують target="_top" АБО postMessage({type:'navigate'}), який
   батько honor-ить (голе посилання в cross-origin iframe навігує iframe, не продукт).
4. Задокументований parent-сніпет: origin-checked message handler, height autosize, обробка навігації,
   форвардинг аналітики.
5. Задокументуй потрібні sandbox/allow-атрибути (напр. allow="autoplay" для hero-відео) як відповідальність
   батька. Надай loading-стан, integration-error fallback і standalone URL для тієї
   ж сторінки (для preview + social sharing).

ОБМЕЖЕННЯ (обидва режими)
- Жодної залежності від third-party cookies; жодного auth у query strings; не чіпай parent storage.
- Ніколи не шли user data на origin/endpoint, запропонований чимось іншим, ніж узгоджений host config.

КРИТЕРІЇ ЗАВЕРШЕННЯ — FULL-PAGE EMBED
- Лендінг рендериться між header/footer host-а з безшовним кольоровим швом; жодного зламаного host-стилю; жодного
  чіпаного глобального стану; усі CTA влучають у реальні роути; sticky-header offset поважається; жодного scroll-jacking.
КРИТЕРІЇ ЗАВЕРШЕННЯ — IFRAME EMBED
- Child autosize-ить iframe через message-контракт; handshake + loading + error-fallback усе працює;
  top-window CTA навігують продукт, не frame; origin-и allow-listed; standalone URL працює.
```

---

## 14. Аналітика
_Фаза: Аналітика. (Рекомендовано — НЕ реалізовано в reference-білді; так і маркуй.)_

```
ЦІЛЬ
Заінструментуй ОДНУ конверсійну ціль і ключові кроки воронки задокументованою таксономією подій. (Спостережено:
аналітику НЕ реалізовано в reference-білді — це Рекомендований додаток.)

Працюй за методологія/GA-ANALYTICS-SPEC.md: словник подій зі власниками (лендінг НЕ шле page_view),
спільні параметри (landing_id/embed_mode/locale/theme/has_auth; БЕЗ PII і token), канал за режимом
(full-page → dataLayer продукту; iframe → тип повідомлення узгодити з продуктом; standalone → окремо),
useAnalytics()-адаптер (один track() → один канал). CTA-події: cta_id == analyticsId з config/actions.ts
(методологія/CTA-AND-LINKS.md). Deliverable фази — заповнена специфікація для продуктових аналітиків.

ВХІДНІ ДАНІ
- Єдина конверсійна ціль PRODUCT.md + CTA (config/actions.ts з analyticsId на кожній дії). Режим
  вбудовування (події можуть потребувати форвардингу до батька в iframe-режимі).

DELIVERABLES
1. Таблиця таксономії подій: назва події, тригер, властивості, і який крок воронки вона позначає
   (view hero → engage section → CTA click → conversion).
2. Тонкий, privacy-respecting analytics-wrapper, завантажений ПІСЛЯ interactive / on visibility (ніколи не
   render-blocking analytics-bundle). Жодного PII у payload-ах подій чи URL.
3. У iframe-режимі: маршрутизуй події через analytics-forwarding-канал iframe bridge, origin-checked.
4. Consent gate, якщо host його вимагає (за замовчуванням — найбільш privacy-preserving опція).

ОБМЕЖЕННЯ
- Аналітика не має регресувати JS budget чи LCP; завантажуй лениво.
- Жодних персональних/чутливих даних у query strings чи параметрах подій.

КРИТЕРІЇ ЗАВЕРШЕННЯ
- Кожен крок воронки від hero-view до conversion фаєрить задокументовану подію з правильними властивостями.
- Analytics-bundle не блокує render і не штовхає initial JS за budget.
- Жоден PII не покидає сторінку; consent (якщо потрібен) поважається.
```

---

## 15. QA
_Аліас у списку задач: "QA". Фаза: QA._

```
ЦІЛЬ
Верифікуй сторінку проти вимог ДОКАЗАМИ — розміри production-білда, вимірювання в браузері, математична
симуляція та adversarial review — не на око.

ВХІДНІ ДАНІ
- Production-білд (nuxi generate). Таблиця вимог. Усі критерії завершення з попередніх фаз.

DELIVERABLES
1. Звіт про production-білд: загальний JS gzip, CSS gzip, index.html gzip, кількість @font-face, кількість distinct
   woff2 — усе виміряно з побудованого output (ніколи не dev mode).
2. Прохід browser-measurement (headless/in-app browser): нуль console-помилок; network-trace (що
   реально завантажується й коли — підтверди відкладене відео); обчислений LCP-елемент; responsive resize-
   перевірки; DOM-assertions (scrollWidth - clientWidth === 0 на кожній тестованій ширині).
3. Докази MATH-SIMULATION для будь-якого animation-інваріанта, який не можна спостерегти live (collision-free
   looping, clearance від text/art, seamless loop) — бо smooth-scroll-бібліотеки можуть блокувати програмний
   scroll, а IntersectionObserver може не фаєрити на CSS-transform-зсувах, тож below-the-fold motion
   верифікується вимірюванням + симуляцією, не скролінгом.
4. Прохід ADVERSARIAL review: кожен запропонований фікс незалежно перевіряється на коректність, framework-
   валідність (Nuxt 3, не 4), design-safety та net-win ПЕРШ ніж прийняти його. Записуй відхилені findings
   (micro-opt, що не є design-safe, має бути відхилений — вимірюй ризик фіксу, не лише
   finding).
5. Reduced-motion-аудит: повна статична сторінка, без scrub/parallax/autoplay, статичний poster, коректно на resize.
6. Accessibility/embedding-перевірки: focus order, landmarks, keyboard, visible focus, contrast, alt text,
   200% zoom — усе працює разом із header/footer host-а.

ОБМЕЖЕННЯ
- Довіряй лише реальним production-числам і реальним вимірюванням.
- Не "фіксь" finding, який verifier визнає не design-safe чи не net win.

КРИТЕРІЇ ЗАВЕРШЕННЯ
- Звіт про білд зафіксовано; розміри в межах budget; font-кількості мінімізовані.
- Нуль console-помилок; відкладене відео підтверджено network-trace; без горизонтального overflow на будь-якій ширині.
- Кожен неспостережуваний animation-інваріант має пройдену симуляцію.
- Reduced-motion і a11y-перевірки проходять з присутнім host chrome.
- Кожен рядок таблиці вимог має пройдену acceptance-перевірку або залоговану, owned виняток.
```

---

## 16. Деплой
_Фаза: Деплой. (Гейт: лише після явного апруву.)_

```
ЦІЛЬ
Достав статичний білд на хостинг з усіма бінарними асетами на CDN, валідований реальним білдом і live
URL-перевіркою.

ВХІДНІ ДАНІ
- Апрувнутий QA. CDN URL для кожного зображення/відео. Вимоги deploy target-а.

DELIVERABLES
1. Build/transform-крок, що свопить кожен локальний /img і /video шлях на його CDN URL — special-casing
   компонентів, що БУДУЮТЬ шляхи динамічно (prefix + name-патерни, ${var}-шаблони), у явні URL-
   поля, щоб жодного не пропустити.
2. Pre-deploy валідація: запиши трансформовані файли у temp-dir з node_modules symlink, запусти
   nuxi generate, і ПЕРЕВІР 0 залишкових локальних asset-шляхів і очікувану кількість @font-face.
3. Сам деплой (source → host будує; асети референсяться з CDN). Якщо deploy-tool не може постачати
   великі бінарники inline, це очікувано — асети живуть на CDN і референсяться за URL. Делегуй
   емісію великого payload-а субагенту для context hygiene, якщо потрібно.
4. Live post-deploy-перевірка: завантаж production URL і перевір маркери — title, CTA text, наявні CDN asset-
   рефи, без error-сторінки, без console-помилок.

ОБМЕЖЕННЯ
- НЕ деплой, доки користувач явно не апрувнув (standing gate з Нормалізації вимог).
- Стеж за відомими gotcha-ми: опусти явний team id, якщо deploy API 403-ить на ньому; використовуй NUXT_IGNORE_LOCK=1,
  якщо dev-server lock блокує generate; base64-inlining бінарників через tool call непрактичний — використовуй
  CDN.

КРИТЕРІЇ ЗАВЕРШЕННЯ
- Pre-deploy валідація перевіряє 0 локальних asset-шляхів і очікувану кількість @font-face.
- Live URL завантажується з коректним title/CTA text, CDN-hosted асетами, без error-сторінки, без console-помилок.
- Деплой стався лише після явного апруву.
```

---

## 17. Post-launch review (ретроспектива)
_Аліас у списку задач: "final audit". Фаза: Post-launch review (ретроспектива)._

```
ЦІЛЬ
Підтверди, що запущена сторінка відповідає Definition of Done, зафіксуй уроки й запиши follow-up-и.

ВХІДНІ ДАНІ
- Live production URL. Таблиця вимог + усі критерії завершення фаз.

DELIVERABLES
1. Definition-of-Done-чекліст, прогнаний проти LIVE-білда:
   - Без console-помилок на production-білді.
   - LCP — це preloaded poster-зображення з fetchpriority; JS у межах budget.
   - index.html худий (fonts subset); CLS контрольований (розміри медіа + metric-matched font fallback).
   - Reduced-motion повністю пошанований (без scrub/parallax/autoplay; статичний poster); коректно на resize.
   - Без горизонтального overflow на будь-якій тестованій ширині; mobile має власну art direction.
   - Ambient-анімації паузяться offscreen; bespoke-сцени відновлюються безшовно.
   - Усі CTA вказують на реальні роути (без placeholder-ів); embedding-шов чистий; асети на CDN.
   - Деплой валідований реальним білдом + live URL-перевіркою.
2. Ретроспектива: що мало бути вирішено раніше (режим вбудовування, signature-motion-модель,
   content-config-шар, mobile motion-anchoring-модель), та generalizable-уроки rework-логу
   (змінюй scope точно; вимірюй ризик фіксів; верифікуй інваріанти математикою; не анімуй кожен кадр).
3. Пріоритезований follow-up-список (напр. додати content-config/i18n-шар; додати Lighthouse/field-CWV runner
   in-loop; додати аналітику, якщо відкладено; локальний media-toolchain для on-disk транскоду/subset-у).

ОБМЕЖЕННЯ
- Аудитуй LIVE-білд, не локальний.
- Тримай ретроспективу brand-neutral і generalizable, якщо вона живить спільну методологію.

КРИТЕРІЇ ЗАВЕРШЕННЯ
- Кожен пункт Definition-of-Done проходить на live URL, або має залоговану, owned виняток.
- Ретроспектива називає можливості раніших рішень, а follow-up backlog пріоритезований.
```

---

## Перехресні посилання

- **WORKFLOW** doc: використовує ці самі назви фаз як оркестраційний backbone; цей файл — готовий до
  вставки промпт на кожну фазу.
- **ARCHITECTURE / project-structure** doc: розгортає directory-модель, на яку посилаються фази 5 і 7.
- **DESIGN-SYSTEM / tokens** doc: розгортає категорії токенів, на які посилаються фази 6 і 12.
- **MOTION** doc: розгортає патерни GSAP/rAF/ambient, на які посилаються фази 10–11.
- **PERFORMANCE** doc: розгортає font-subset-аудит, video deferral та правила LCP-poster у фазі 12.
- **EMBEDDING / iframe** doc: розгортає контракт full-page-vs-iframe у фазі 13.
- **QA / Definition-of-Done** doc: розгортає evidence-based верифікацію у фазах 15 і 17.

Усі назви фаз і токенів тут збігаються зі спільною термінологією, тож документи узгоджені між собою.
