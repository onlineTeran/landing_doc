# Словник анімацій лендінгу: патерни, власники властивостей, режими

> Призначення: каталог перевірених motion-патернів промо-лендінгу — що це, чим реалізується,
> хто «володіє» якою CSS-властивістю, як поводиться в embedded/reduced-motion. Доповнює §motion
> головного документа. Мітки: **Спостережено** / **Виведено** / **Рекомендовано**.

---

## -1. Вибір формату до анімації

Перевіряй рішення у такій послідовності: **CSS → video → frame sequence**.

1. CSS transform/opacity — для простого float, pulse, glow, hover, scale/translate/rotate.
2. Video — для складної character/fur/lighting анімації, яку CSS не відтворить без компромісу.
3. Frame sequence — лише коли потрібні alpha, точний frame control або scroll-sync і після розрахунку
   стисненої сумарної ваги, requests та decode memory.

Для кожного варіанта в questionnaire записуються actual/estimated bytes, mobile CPU/memory, poster,
Save-Data і reduced-motion behavior. Рекомендація обирає найменшу delivery cost, яка зберігає задум,
а не найефектнішу технологію. Повний контракт — у
[framework/PERFORMANCE-OPTIMIZATION.md](framework/PERFORMANCE-OPTIMIZATION.md).

## 0. Головне правило: один власник на властивість на елемент

**Спостережено (реальний інцидент):** три механіки на одній картинці — CSS-левітація
(`animation` на `img`), entrance-анімація GSAP (`y` на контейнері) і fade-in lazy-завантаження —
можуть знищити одна одну:

- shorthand `animation:` у будь-якому правилі **повністю перекриває** власну анімацію елемента
  (левітація зникла, бо fade-in фолбек оголосив `animation: lazy-reveal` на всіх lazy-img);
- `animation: none` у стані «завершено» вимикає власні анімації **назавжди**;
- два GSAP-твіни на одну властивість (`y` entrance + `y` паралакс) смикаються.

**Правило:** перед додаванням механіки виріши, який елемент і яка властивість — її; за потреби
додай окрему обгортку. Робочий шаблон шарів (Спостережено):

```
.container        ← entrance (GSAP: opacity/y/scale, once)
  .parallax-wrap  ← паралакс (GSAP scrub: y)
    img           ← левітація (CSS animation: transform) + fade-in (opacity+transition, БЕЗ animation)
```

## 1. Каталог патернів

| Патерн | Реалізація | Власник властивості | Embedded (iframe) | Reduced-motion |
|---|---|---|---|---|
| **Левітація** (float) | CSS `@keyframes` на `transform` (translate+rotate), 7–16s ease-in-out infinite; сусідам — різний `animation-delay`, щоб не синхронились | `img`/декор: `transform` | працює (не залежить від скролу) | заморожується глобальним правилом |
| **Паралакс** (малий) | GSAP `fromTo(y: +Δ → −Δ)` + ScrollTrigger `scrub`, `start: 'top bottom', end: 'bottom top'`; Δ ≈ 25–45px, варіювати за індексом | окрема обгортка: `y` | **пропустити**: вікно iframe не скролиться (скрол у батька — ScrollTrigger не отримує подій) | пропустити |
| **Entrance / reveal** | GSAP `to(opacity/y/scale)` once, ScrollTrigger `toggleActions: 'play none none none'`; в CSS — прихований старт лише під `html.js` + анімаційний фолбек видимості | контейнер: `opacity`, `y`, `scale` | працює через IntersectionObserver-тригери; з ScrollTrigger — ні | все видиме одразу |
| **Fade-in lazy-картинок** | клас `.is-loaded` на подію load (плагін) + `opacity: 0 → 1` з `transition` | `img`: **тільки** `opacity` (жодного `animation:`!) | працює | transition обнулюється → миттєво |
| **Scrub-journey** (прогрес, привʼязаний до скролу) | GSAP timeline + ScrollTrigger `scrub` на sticky-сцені | сцена | **заміна:** time-based fill-твін (`duration` 10–15s), запуск разово через IntersectionObserver | статичний фінальний стан |
| **Marquee** (біжучий рядок) | CSS `@keyframes translateX`, контент ×3 для безшовності | стрічка: `transform` | працює | пауза |
| **Ambient-дрейф засвітів** | CSS `@keyframes` на `transform: translate3d/scale`, 20–30s | глоу: `transform` | працює | заморожується |
| **Повільне обертання** (орбіти, HUD) | CSS `rotate` linear infinite 40–120s | елемент: `transform` | працює | заморожується |
| **Hover/press мікро** | CSS `transition` на `transform`/кольори, `:active { translateY(1px) }` | кнопка | працює | лишити (мікро) |

## 2. Гігієна (все — Спостережено)

- **Тільки композитні властивості**: `transform`, `opacity`. Ніколи width/height/top/left.
- **Offscreen-пауза**: секція далеко поза вʼюпортом отримує клас (`.is-idle` через
  IntersectionObserver) → `animation-play-state: paused !important` на її CSS-анімації —
  нуль composite-роботи offscreen. GSAP/scroll-driven це не зачіпає.
- **Глобальний reduced-motion**: одне правило `animation-duration: 0.01ms; transition-duration:
  0.01ms; animation-iteration-count: 1` + точкові винятки (reveal → одразу видимий стан).
- **Скрол-бібліотека (Lenis) і CSS `scroll-behavior: smooth` несумісні** — браузер анімує кожен
  крок бібліотеки → дрейф. З Lenis — тільки нативний behavior.
- **ScrollTrigger cleanup**: `gsap.context()` зі scoped-селекторами + `ctx.revert()` в
  `onUnmounted` — жодних продубльованих timeline після навігації.
- **Entrance ховає контент лише під `html.js`** і лише `opacity/transform` (не `visibility`) для
  семантичного тексту — скрінрідер бачить контент до анімації; фокусовані CTA — виняток
  (`visibility` + фолбек), щоб невидимий лінк не був таб-стопом.

## 3. Чекліст додавання нової анімації

- [ ] Назвав власника: елемент × властивість; конфліктів з наявними механіками немає
      (перевір `animation:`-shorthand-и і GSAP-твіни на тому ж елементі).
- [ ] Тільки transform/opacity; infinite-анімації ставляться на паузу offscreen.
- [ ] Поведінка визначена для трьох режимів: standalone / embedded / reduced-motion.
- [ ] Скрол-залежне — не в embedded (або замінене time-based варіантом).
- [ ] Cleanup при unmount; після повторної навігації анімація не дублюється.
