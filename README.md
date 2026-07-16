# Методологія розробки промо-лендінгів

**Версія:** 1.0.0 · **Стек:** Nuxt 3 · Vue 3 · TypeScript · SSG · GSAP/Lenis · CSS design tokens

Брендонезалежна, багаторазова методологія створення сучасних інтерактивних промо-лендінгів
Awwwards-рівня, які інтегруються у продукт (full-page embed або iframe). Дистильована з реальних
проєктів: увесь шлях від ідеї та storytelling до motion, адаптиву, performance, QA, інтеграції та деплою.

> Кожне нетривіальне твердження позначене міткою: **Спостережено** (бачили в реальній роботі/коді) ·
> **Виведено** (логічний висновок) · **Рекомендовано** (пропозиція на майбутнє, ще не відпрацьована).
>
> **Чесне застереження:** референс-проєкт інтегрувався як **full-page embed** (хедер/футер продукту, без
> iframe). Тому весь **iframe**-матеріал позначено `Рекомендовано`/`Виведено`, а не `Спостережено`.

---

## Швидкий старт (новий лендінг)

1. Відкрий [`LANDING-PROMPT-TEMPLATE.md`](LANDING-PROMPT-TEMPLATE.md), заповни змінні (`[LANDING_NAME]`,
   `[BUSINESS_GOAL]`, …) і віддай агенту як стартовий бриф.
2. Іди фазами за [`LANDING-WORKFLOW.md`](LANDING-WORKFLOW.md); на кожну фазу бери готовий prompt із
   [`PHASE-PROMPTS.md`](PHASE-PROMPTS.md).
3. Звіряйся з [`CHECKLISTS.md`](CHECKLISTS.md) на кожному гейті.
4. Фіксуй рішення в [`DECISION-LOG-TEMPLATE.md`](DECISION-LOG-TEMPLATE.md).
5. Після релізу заповни [`RETROSPECTIVE-TEMPLATE.md`](RETROSPECTIVE-TEMPLATE.md) — і поверни покращення
   в цю методологію (див. [`EVOLVING-THE-METHODOLOGY.md`](EVOLVING-THE-METHODOLOGY.md)).

## Документи

| Файл | Про що |
|---|---|
| [LANDING-DEVELOPMENT-METHODOLOGY.md](LANDING-DEVELOPMENT-METHODOLOGY.md) | Головний документ — 18 розділів: принципи, discovery, концепція, IA, візуал, архітектура, design tokens, motion, AI-асети, адаптив, iframe, performance, доступність, SEO, аналітика, QA, Definition of Done, ретроспектива |
| [LANDING-WORKFLOW.md](LANDING-WORKFLOW.md) | Покроковий runbook від ідеї до production: input / дії / скіли / артефакти / критерії готовності / типові помилки |
| [PHASE-PROMPTS.md](PHASE-PROMPTS.md) | Самодостатні prompt-и на кожну фазу з критеріями завершення |
| [CLAUDE-CODE-SKILLS.md](CLAUDE-CODE-SKILLS.md) | Аналіз скілів/агентів/інструментів + мінімальний і розширений стеки |
| [LANDING-PROMPT-TEMPLATE.md](LANDING-PROMPT-TEMPLATE.md) | Master-prompt зі змінними для старту нового лендінгу |
| [CHECKLISTS.md](CHECKLISTS.md) | Компактні чеклісти (старт / код / hero / секція / адаптив / motion / асети / iframe / деплой) |
| [STARTER-ARCHITECTURE.md](STARTER-ARCHITECTURE.md) | Що виносити в reusable starter, чого НЕ абстрагувати, API компонентів, ризики над-абстракції |
| [DECISION-LOG-TEMPLATE.md](DECISION-LOG-TEMPLATE.md) | Шаблон журналу рішень |
| [RETROSPECTIVE-TEMPLATE.md](RETROSPECTIVE-TEMPLATE.md) | Шаблон ретроспективи після лендінгу |
| [EVOLVING-THE-METHODOLOGY.md](EVOLVING-THE-METHODOLOGY.md) | Як розвивати цю методологію під час наступних лендінгів (PR-процес, версіонування, submodule) |
| [CHANGELOG.md](CHANGELOG.md) | Історія змін методології |

## Як читати

GitHub рендерить `.md` нативно — просто відкривай файли або переходь за посиланнями в таблиці вище.
Окремий веб-сайт не потрібен; усе живе в цих файлах.

## Версіонування

Semver-подібно (див. [`EVOLVING-THE-METHODOLOGY.md`](EVOLVING-THE-METHODOLOGY.md)):
**MAJOR** — несумісна зміна процесу/структури · **MINOR** — новий розділ/патерн (напр. «iframe
відпрацьовано на реальному лендінгу») · **PATCH** — уточнення й правки. Кожна суттєва зміна → запис у
[CHANGELOG.md](CHANGELOG.md) і тег версії.
