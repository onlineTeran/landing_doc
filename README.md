# Promo Landing Framework 2.0

Практична методологія для продуктових дизайнерів, дизайн-інженерів і AI-агентів, які створюють
акційні лендінги для **CATBET** та **SlotCity**: від першого опитування до дизайну, окремих асетів,
Nuxt-реалізації, аналітики, QA, публікації та ретроспективи.

Framework 2.0 зберігає сильну технічну базу попередньої методології, але змінює головний принцип:
**спочатку продуктова й юридична правда, потім бренд і візуальний target, і лише після повного
дизайн-апруву — асети та код**.

## Швидкий старт

1. Запусти [AGENT-BOOTSTRAP.md](AGENT-BOOTSTRAP.md): обери CATBET/SlotCity і Codex/Claude Code,
   встанови project-local skills та створи project kit.
2. Відкрий [framework/README.md](framework/README.md) і обери повний або швидкий маршрут.
3. Проведи інтерв'ю за [framework/QUESTIONNAIRE.md](framework/QUESTIONNAIRE.md). Питання розгалужуються:
   для внутрішнього лендінгу готового продукту не треба повторно досліджувати GEO, продукт і всю ЦА.
4. Завантаж продуктову базу: [products/CATBET.md](products/CATBET.md) або
   [products/SLOTCITY.md](products/SLOTCITY.md).
5. Зафіксуй brand evidence у [Brand Archive](brand-archive/) і проведи copy/legal review за
   [правилами PlayCity](PLAYCITY-COPYWRITING-RULES.md).
6. Веди
   [templates/PROJECT-STATE.md](templates/PROJECT-STATE.md) як єдину дошку гейтів.
7. Проєктуй mobile-first за [framework/DESIGN-PROCESS.md](framework/DESIGN-PROCESS.md): 375 → 430 →
   440 → 1440 → host context; не переходь до коду без editable Figma approval.
8. Підготуй асети за [framework/ASSET-PIPELINE.md](framework/ASSET-PIPELINE.md), реалізуй за
   [framework/TECHNICAL-STANDARD.md](framework/TECHNICAL-STANDARD.md), оптимізуй за
   [framework/PERFORMANCE-OPTIMIZATION.md](framework/PERFORMANCE-OPTIMIZATION.md), перевір і випусти
   за [framework/QA-RELEASE.md](framework/QA-RELEASE.md).

Швидко створити project kit у репозиторії нового лендінгу:

```bash
./methodology/scripts/bootstrap-project.sh . catbet codex
# або
./methodology/scripts/bootstrap-project.sh . slotcity claude
```

## Як підключити до нового лендінгу

Наявний submodule-flow збережено. Методологія має бути запінена на reviewed tag/commit, щоб кожен
лендінг залишався відтворюваним:

```bash
git submodule add https://github.com/onlineTeran/landing_doc.git methodology
git -C methodology checkout <reviewed-tag-or-commit>
git add .gitmodules methodology
git commit -m "chore: pin landing methodology"
```

Клонування проєкту із submodule:

```bash
git clone --recurse-submodules <landing-repository-url>
# для вже склонованого: git submodule update --init
```

Оновлення — окрема зміна з review, а не випадковий pull посеред кампанії:

```bash
git -C methodology fetch --tags
git -C methodology checkout <new-reviewed-tag-or-commit>
git add methodology
git commit -m "chore: bump landing methodology"
```

Для private repo/hosting limitations див. [AGENT-BOOTSTRAP.md](AGENT-BOOTSTRAP.md) і
[DEPLOY-AND-LAUNCH.md](DEPLOY-AND-LAUNCH.md).

## Архітектура бази знань

| Шар | Відповідає на питання | Канонічні файли |
|---|---|---|
| **Процес** | У якому порядку працюємо і де зупиняємося на апрув? | [framework](framework/) |
| **Продукт** | Які бренд-інваріанти, джерела й заборони діють? | [products](products/) |
| **Brand evidence** | Де точні Figma nodes, asset rights, design system і ToV? | [brand-archive](brand-archive/) |
| **Copy & compliance** | Як писати й перевіряти gambling promo copy? | [PLAYCITY-COPYWRITING-RULES.md](PLAYCITY-COPYWRITING-RULES.md) |
| **Шаблони** | Які артефакти має залишити команда? | [templates](templates/) |
| **AI orchestration** | Які скіли й промпти використовувати на кожному етапі? | [AGENT-BOOTSTRAP.md](AGENT-BOOTSTRAP.md), [SKILLS-MANIFEST.md](SKILLS-MANIFEST.md), [skills](skills/) |
| **Досвід** | Які реальні помилки не повторювати? | [case-studies](case-studies/) |
| **Технічна бібліотека** | Як реалізувати motion, iframe, аналітику й деплой? | наявні верхньорівневі технічні документи |

## Непорушні правила

- Один лендінг — одна бізнес-ціль і одна основна конверсійна дія.
- Кожна цифра, механіка та legal-теза має джерело й статус у Claims Matrix.
- Legal/Product Truth → Campaign Argument → Brand ToV: нижчий шар не переписує вищий.
- Якщо співіснують два бренди, створюється Brand Bridge: хто володіє оболонкою, CTA, фоном,
  типографікою, маскотом і графічними ефектами.
- Надані Figma, live-сторінки, approved copy та canonical assets важливіші за AI-смак.
- Ніякого коду до вибору візуального напряму й апруву повного дизайну.
- Mobile 375 — перша й канонічна композиція; 430/440 і desktop розширюють її, а не навпаки.
- Campaign copy і CTA routes завжди редагуються через `content/copy.json` та `content/actions.json`.
- Production raster assets — WebP; standalone illustrations зазвичай transparent, background —
  окрема asset task.
- Motion спочатку перевіряється як CSS, потім video, потім frame sequence з byte/CPU розрахунком.
- AI-асет не приймається у великому preview: його перевіряють у реальному слоті, на 1440/440/430/375,
  з альфою, crop-safe area та потрібною вагою файлу.
- Локальна перевірка завершується до публікації. Деплой — лише після явного release approval.

## Мінімальний комплект артефактів проєкту

- Project Brief і список відкритих питань.
- Product Truth + Claims Matrix + legal freeze.
- Brand Bridge або Brand Sheet.
- Content Map і storyboard.
- Три візуальні напрями; один обраний target.
- Hero approval, desktop 1440, mobile 440, 430 і 375; QA — на актуальному top-10 із
  [DEVICE-TEST-MATRIX.md](DEVICE-TEST-MATRIX.md).
- Asset Register з master/delivery-файлами та prompt log.
- Analytics Plan.
- Design QA, Technical QA і release checklist.
- Static HTML+assets delivery, build-size report і editable Figma link із 375/430/440/1440/context.
- Decision Log та ретроспектива.

## Технічна бібліотека попередньої версії

Framework 2.0 не дублює глибокі технічні інструкції. Використовуй їх за потреби:

- [LANDING-DEVELOPMENT-METHODOLOGY.md](LANDING-DEVELOPMENT-METHODOLOGY.md) — детальна технічна база.
- [LANDING-WORKFLOW.md](LANDING-WORKFLOW.md) і [PHASE-PROMPTS.md](PHASE-PROMPTS.md) — попередній
  17-фазовий runbook і розгорнуті промпти.
- [STARTER-ARCHITECTURE.md](STARTER-ARCHITECTURE.md) — Nuxt/Vue структура.
- [ICON-GENERATION-METHODOLOGY.md](ICON-GENERATION-METHODOLOGY.md) — глибока методологія іконок.
- [ANIMATION-PATTERNS.md](ANIMATION-PATTERNS.md) — motion-патерни.
- [IFRAME-BRIDGE-INTEGRATION.md](IFRAME-BRIDGE-INTEGRATION.md) і
  [SMARTICO-INTEGRATION.md](SMARTICO-INTEGRATION.md) — продуктові інтеграції.
- [CONTENT-CONFIG.md](CONTENT-CONFIG.md), [CTA-AND-LINKS.md](CTA-AND-LINKS.md),
  [GA-ANALYTICS-SPEC.md](GA-ANALYTICS-SPEC.md) — контент, CTA й аналітика.
- [DEVICE-TEST-MATRIX.md](DEVICE-TEST-MATRIX.md), [CHECKLISTS.md](CHECKLISTS.md),
  [DEPLOY-AND-LAUNCH.md](DEPLOY-AND-LAUNCH.md) — QA і запуск.

## Для AI-агента

Використовуй [skills/promo-landing-framework/SKILL.md](skills/promo-landing-framework/SKILL.md) і
[skills/playcity-copy-review/SKILL.md](skills/playcity-copy-review/SKILL.md).
Skill проводить агента через product truth → brand evidence → visual target → approved design → assets →
implementation → QA. Він не дозволяє моделі починати код або домальовувати бренд раніше часу.

## Статус

**Версія:** 2.0.0-draft · **Базовий стек:** Nuxt 3 · Vue 3 · TypeScript · SSG · scoped CSS · optional GSAP.

Framework 2.0 сформовано після ретроспективи реального кросбрендового лендінгу BETON × CATBET.
Опис висновків — у [case-studies/BETON-CATBET.md](case-studies/BETON-CATBET.md).

## Як повертати покращення

Існуючий evolution-flow не змінено: findings із конкретного лендінгу спочатку проходять retrospective,
потім оновлюють цей repository окремим commit/PR із міткою `Спостережено`, `Виведено` або
`Рекомендовано`. Повний процес — [EVOLVING-THE-METHODOLOGY.md](EVOLVING-THE-METHODOLOGY.md), історія
версій — [CHANGELOG.md](CHANGELOG.md).
