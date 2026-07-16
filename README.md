# Методологія розробки промо-лендінгів

**Версія:** 1.0.0 · **Стек:** Nuxt 3 · Vue 3 · TypeScript · SSG · GSAP/Lenis · CSS design tokens

Брендонезалежна, багаторазова методологія створення сучасних інтерактивних промо-лендінгів
Awwwards-рівня, які інтегруються у продукт (full-page embed або iframe). Дистильована з реальних
проєктів: увесь шлях від ідеї та storytelling до motion, адаптиву, performance, QA, інтеграції та деплою.

> Кожне нетривіальне твердження позначене міткою: **Спостережено** (бачили в реальній роботі/коді) ·
> **Виведено** (логічний висновок) · **Рекомендовано** (пропозиція на майбутнє, ще не відпрацьована).
>
> **Чесне застереження:** референс-проєкт інтегрувався як **full-page embed** (хедер/футер продукту, без
> iframe). Для iframe тепер є **офіційний контракт продукту** ([IFRAME-BRIDGE-INTEGRATION.md](IFRAME-BRIDGE-INTEGRATION.md)) —
> сам контракт авторитетний, але його застосування в реальному лендінгу ще не відпрацьоване, тож
> адаптаційні поради позначені `Рекомендовано`/`Виведено`, а не `Спостережено`.

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
| [ICON-GENERATION-METHODOLOGY.md](ICON-GENERATION-METHODOLOGY.md) | Генерація AI-іконок: style lock, reference icon, optical sizes, true alpha, safe area, export matrix, QA — доповнює §9 головного документа |
| [IFRAME-BRIDGE-INTEGRATION.md](IFRAME-BRIDGE-INTEGRATION.md) | **Офіційний контракт продукту** для iframe-інтеграції (IframeBridge: loaded/height/event_action/token) + адаптація до Nuxt 3 і наслідки для motion; готове ядро — [`assets/iframe-bridge.js`](assets/iframe-bridge.js), дослівний оригінал фронтів — [`assets/IFRAME-BRIDGE-README.md`](assets/IFRAME-BRIDGE-README.md), офіційна таблиця `event_action`-id — [`assets/EVENT-ACTIONS.md`](assets/EVENT-ACTIONS.md) |
| [CONTENT-CONFIG.md](CONTENT-CONFIG.md) | Контент-система: `content/copy.json` (блок → текст → {ua, ru}) для копірайтера + `content/actions.json` (кнопки: переклади + GA-мітка + лінк/event_action), `useCopy()`, hydration-правило післягідраційної локалі |
| [CTA-AND-LINKS.md](CTA-AND-LINKS.md) | Кнопки й лінки через конфіг: `config/actions.ts` (усі URL/`event_action`-id в одному файлі), `useCtaAction()` + єдиний `<CtaButton>`, який сам обирає канал (`<a>` / `target="_top"` / `event_action`) |
| [GA-ANALYTICS-SPEC.md](GA-ANALYTICS-SPEC.md) | GA4-специфікація подій для продуктових аналітиків: словник подій із власниками, спільні параметри, канали за режимом вбудовування, `useAnalytics()`-адаптер, хендоф-чекліст |
| [DECISION-LOG-TEMPLATE.md](DECISION-LOG-TEMPLATE.md) | Шаблон журналу рішень |
| [RETROSPECTIVE-TEMPLATE.md](RETROSPECTIVE-TEMPLATE.md) | Шаблон ретроспективи після лендінгу |
| [EVOLVING-THE-METHODOLOGY.md](EVOLVING-THE-METHODOLOGY.md) | Як розвивати цю методологію під час наступних лендінгів (PR-процес, версіонування, submodule) |
| [CHANGELOG.md](CHANGELOG.md) | Історія змін методології |

## Як підключити до нового лендінгу

Рекомендований спосіб — **git submodule**, запінений на тег версії: лендінг залежить від конкретної,
відтворюваної версії методології, а доопрацювання повертаються назад одним push-ем (див. нижче).

```bash
# 1. У корені репозиторію нового лендінгу:
git submodule add https://github.com/onlineTeran/landing_doc.git methodology

# 2. Запінити на потрібну версію (список: git -C methodology tag -l):
git -C methodology checkout v1.1.0
git add .gitmodules methodology
git commit -m "chore: pin methodology v1.1.0"

# 3. Дати AI-агенту стартовий бриф:
#    відкрий methodology/LANDING-PROMPT-TEMPLATE.md, заповни змінні, встав агенту.
#    Далі — фазами за methodology/LANDING-WORKFLOW.md + methodology/PHASE-PROMPTS.md.
```

Клонування лендінгу з уже підключеною методологією:

```bash
git clone --recurse-submodules <url-лендінгу>
# або в уже склонованому: git submodule update --init
```

Оновити методологію в лендінгу до нової версії (свідомо, коли готовий):

```bash
git -C methodology fetch --tags
git -C methodology checkout v1.2.0
git commit -am "chore: bump methodology to v1.2.0"
```

Альтернатива без submodule — разова копія в `docs/methodology/` лендінгу (`npx degit onlineTeran/landing_doc docs/methodology`);
тоді покращення повертаєш вручну через PR.

## Як доопрацьовувати методологію прямо з лендінгу

Submodule — це повноцінний git-репозиторій усередині лендінгу, тому правки робляться **на місці** й
push-аться прямо сюди, у GitHub:

```bash
# всередині лендінгу, під час роботи помітив, що методологію треба уточнити:
cd methodology
git switch main && git pull                  # стати на актуальний main
# ... редагуєш потрібний .md ...
git commit -am "docs: <що уточнено і чому>"
git push origin main                          # ← методологія оновлена на GitHub
cd ..
git add methodology && git commit -m "chore: bump methodology"   # запінити новий коміт у лендінгу
```

Повний процес (мітки Спостережено/Виведено/Рекомендовано, версіонування, чеклист якості PR,
цикл «лендінг → ретроспектива → оновлення методології») — в [`EVOLVING-THE-METHODOLOGY.md`](EVOLVING-THE-METHODOLOGY.md).

## Як читати

GitHub рендерить `.md` нативно — просто відкривай файли або переходь за посиланнями в таблиці вище.
Окремий веб-сайт не потрібен; усе живе в цих файлах.

## Версіонування

Semver-подібно (див. [`EVOLVING-THE-METHODOLOGY.md`](EVOLVING-THE-METHODOLOGY.md)):
**MAJOR** — несумісна зміна процесу/структури · **MINOR** — новий розділ/патерн (напр. «iframe
відпрацьовано на реальному лендінгу») · **PATCH** — уточнення й правки. Кожна суттєва зміна → запис у
[CHANGELOG.md](CHANGELOG.md) і тег версії.
