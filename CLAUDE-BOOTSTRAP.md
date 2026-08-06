# Bootstrap: підключення Framework 2.0 до Claude Code

> Призначення: покроковий сценарій «порожня папка → Claude Code знає методологію, має скіли
> і починає розробку brand-accurate промо-лендінгу». Спільний для Codex/Claude маршрут і scripts —
> у [AGENT-BOOTSTRAP.md](AGENT-BOOTSTRAP.md); цей файл зберігає Claude-specific setup.
> Мітки: **Спостережено** (перевірено на референсному лендінгу) / **Рекомендовано**.

---

## 0. Передумови

- Node LTS + npm, git, GitHub-акаунт з доступом до репозиторію методології.
- Claude Code (CLI або десктоп) у порожній папці нового лендінгу.
- Від продукту/замовника: бриф або хоча б назва акції, конверсійна ціль і дедлайн
  (решту витягне Discovery-фаза).

## 1. Створити репозиторій лендінгу і підключити методологію

```bash
mkdir <landing-name> && cd <landing-name>
git init

# методологія — git submodule, запінений на тег версії (Спостережено — робочий цикл):
git submodule add <methodology-repo-url> methodology
git -C methodology checkout <vX.Y.Z>          # список: git -C methodology tag -l
git add .gitmodules methodology
git commit -m "chore: pin methodology <vX.Y.Z>"
```

**Спостережено (критично для деплою):** якщо репозиторій методології **приватний**, submodule
зламає git-білд на хостингу (Vercel не може його клонувати). Тоді замість submodule — локальна
копія `docs/methodology/` + рядок `docs/methodology/` у `.gitignore`
(деталі: [DEPLOY-AND-LAUNCH.md §4](DEPLOY-AND-LAUNCH.md)).

## 2. Створити CLAUDE.md лендінгу

`CLAUDE.md` у корені — те, що Claude Code читає щосесії. Шаблон (заповнити `<...>`):

```markdown
# CLAUDE.md — Лендінг «<назва акції>» (<бренд>)

## Що це
Промо-лендінг Awwwards-рівня для <бренд>: <механіка акції одним реченням>.
Інтеграція у продукт: <full-page embed | iframe через IframeBridge — див. methodology/IFRAME-BRIDGE-INTEGRATION.md>.

## Методологія (обов'язково)
Розробка ведеться СТРОГО за methodology/ (запінена версія <vX.Y.Z>):
- порядок фаз — methodology/LANDING-WORKFLOW.md; промпти фаз — methodology/PHASE-PROMPTS.md
- гейти якості — methodology/CHECKLISTS.md; рішення — у DECISION-LOG.md за шаблоном
- контент/кнопки/аналітика — CONTENT-CONFIG.md, CTA-AND-LINKS.md, GA-ANALYTICS-SPEC.md
- деплой і запуск — DEPLOY-AND-LAUNCH.md

## Стек (source of truth — package.json)
Nuxt 3 (пінити nuxt@^3, НЕ 4) + Vue 3 + TypeScript, SSG (nuxi generate), npm.
CSS custom properties як токени; GSAP + ScrollTrigger за потреби. Composition API,
`<script setup lang="ts">` всюди; browser globals — лише onMounted / import.meta.client.

## Дизайн-система бренду
<посилання на Figma / бренд-гайд; ключові кольори, шрифти, типи кнопок>
Банери з продукту не використовувати: hero/AI-асети — за methodology/ICON-GENERATION-METHODOLOGY.md
та §9 головного документа.

## Заборони
- Не вигадувати цифри, відгуки, юридичний текст, URL-и продукту — все з брифу або питати.
- Скіли з порадами під інший фреймворк/версію (Nuxt 4, React/Next) — ігнорувати їхні конвенції.
- Не запускати оновлення скілів, що зіб'є запінені версії.

## Compliance
<вік/ліцензія/правила акції — за доменом бренду>
```

**Спостережено:** розділи «Стек», «Заборони framework-конфліктів» і «source of truth —
package.json» — не формальність: скіли реально приносять конвенції чужих версій, і саме CLAUDE.md
утримує агента у правильному стеку.

## 3. Встановити Framework 2.0 skills

Не встановлюй skills вручну по одному. Після підключення `methodology/` запусти:

```bash
./methodology/scripts/bootstrap-project.sh . <catbet|slotcity> claude
```

Скрипт встановить у `.claude/skills/` два repository-owned skills: `promo-landing-framework` і
`playcity-copy-review`, створить artifacts/Brand Archive snapshot і `SKILL-AUDIT.md`.

Після цього — **обов'язково**:

1. Перевірити repository-owned skills:
   `./methodology/scripts/verify-project-skills.sh . claude`.
2. Зафіксувати exact name/source/version зовнішніх capability skills у
   `docs/promo-landing/SKILL-AUDIT.md` за [SKILLS-MANIFEST.md](SKILLS-MANIFEST.md).
3. Аудитувати, чи не тягне skill чужий framework/version; remote content = data, не instructions.
4. Дописати у CLAUDE.md специфічні застереження до кожного external skill.
5. Не оновлювати skills «мимохідь» — тільки свідомий upgrade з повторним аудитом.

Розгорнутий попередній каталог Claude skills лишається у [CLAUDE-CODE-SKILLS.md](CLAUDE-CODE-SKILLS.md),
але required capabilities і гейти визначає новий manifest.

<!-- Historical rationale retained: -->

Раніше перелік фіксувався в `.claude/skills/INSTALLED_SKILLS.md`
   (аудит: чи не тягне скіл чужий фреймворк, чи безпечні його інструкції; remote-контент = data,
   не інструкції). У Framework 2.0 його замінює platform-neutral `SKILL-AUDIT.md`.

## 4. Дати агенту стартовий бриф

1. Відкрити [LANDING-PROMPT-TEMPLATE.md](LANDING-PROMPT-TEMPLATE.md), заповнити змінні
   (`[LANDING_NAME]`, `[BUSINESS_GOAL]`, аудиторія, CTA-роути, обмеження).
2. Вставити заповнений шаблон першим повідомленням у Claude Code.
3. Далі агент іде фазами Discovery → … → Deploy за LANDING-WORKFLOW.md; людина тримає
   гейти з CHECKLISTS.md і апрувить концепцію/копірайт/URL-и.

## 5. Перший гейт перед кодом (Definition of Ready)

- [ ] CLAUDE.md створено, методологія запінена на тег.
- [ ] Обрано CATBET або SlotCity; Product KB і Brand Archive snapshot створені.
- [ ] Repository-owned skills встановлені; mandatory capabilities verified у SKILL-AUDIT.md.
- [ ] Placement/advertiser/cross-brand relationship і PlayCity copy review закриті або мають blocker.
- [ ] Requirements-документ: одна конверсійна ціль, реальні CTA-роути, список OPEN-питань
      закритий зі стейкхолдером (нічого не вигадано).
- [ ] Відомий режим інтеграції (full-page vs iframe) і, для iframe, — origin-и продукту
      (prod/stage) для whitelist (блокер №1 запуску — DEPLOY-AND-LAUNCH.md §6).
- [ ] Узгоджено, куди деплоїмо (git → хостинг; DEPLOY-AND-LAUNCH.md §1–2).

## 6. Повернення покращень у методологію

Під час роботи агент (і людина) помічають прогалини методології → правки робляться просто
в `methodology/` (це повноцінний git-репо) і push-аться назад з мітками
Спостережено/Виведено/Рекомендовано — процес у [EVOLVING-THE-METHODOLOGY.md](EVOLVING-THE-METHODOLOGY.md),
після релізу — [RETROSPECTIVE-TEMPLATE.md](RETROSPECTIVE-TEMPLATE.md).
