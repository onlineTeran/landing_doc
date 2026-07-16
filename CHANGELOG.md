# Changelog

Формат натхнено [Keep a Changelog](https://keepachangelog.com/); версіонування — semver-подібне
(див. [`EVOLVING-THE-METHODOLOGY.md`](EVOLVING-THE-METHODOLOGY.md)).

## [1.1.0] — 2026-07-16

### Added
- **`ICON-GENERATION-METHODOLOGY.md`** — методологія генерації AI-іконок (style lock, reference icon,
  optical sizes, true alpha, safe area, export matrix, повний QA). Дистильована з практичного досвіду
  генерації в ChatGPT; мітки гармонізовано під конвенцію пакета (Спостережено/Виведено/Рекомендовано).
  Крос-реф додано в §9 головного документа та в README.
- README: розділ **«Як підключити до нового лендінгу»** (submodule, запінений на тег; клонування з
  `--recurse-submodules`; оновлення версії; degit-альтернатива) і розділ **«Як доопрацьовувати
  методологію прямо з лендінгу»**.
- `EVOLVING-THE-METHODOLOGY.md` §5.1 — повний **submodule-flow доопрацювання з лендінгу**: швидкий
  режим (push у main) і безпечний (гілка + PR), правила проти detached HEAD і незакріплених комітів.

## [1.0.0] — 2026-07-16

### Added
- Перша версія методології (9 документів + README + процес еволюції): 18-розділовий головний документ,
  покроковий workflow, per-phase prompts, master-prompt зі змінними, чеклісти, шаблони decision-log і
  ретроспективи, starter-архітектура, аналіз Claude Code скілів/агентів/інструментів.
- Дистильовано з реального промо-лендінгу (Nuxt 3 SSG / Vue 3 / TS). Ключові патерни, винесені як
  правила: measured-band мобільний motion; same-period + phase-spread циклічні рухи (доведено симуляцією);
  font-subset аудит (index.html 54KB→14.6KB gzip); defer heavy video (IO-gated, `preload=none`, Save-Data);
  LCP = preloaded poster; пауза offscreen ambient-анімацій; CDN-хостинг асетів для inline-деплою;
  verify-by-simulation + adversarial «verify-before-fix».
- Українська локалізація як єдине джерело; код/токени/технічні терміни лишаються англійськими.

### Notes / відомі обмеження
- Референс-проєкт інтегрувався як **full-page embed** (хедер/футер продукту, без iframe). Тому весь
  **iframe**-матеріал позначено `Рекомендовано`/`Виведено`, ще не `Спостережено`. Перше відпрацювання
  iframe на реальному лендінгу → підвищення до `Спостережено` і версія MINOR.
- Ще не відпрацьовано на практиці: реальний iframe/parent-контракт, шар аналітики (event taxonomy),
  локальний медіа-тулчейн (транскод/subset на диску), content-config шар.
