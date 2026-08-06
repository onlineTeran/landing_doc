# Skill Orchestration

Якість визначає не кількість скілів, а їхня послідовність і право veto. Не запускайте кілька
art-direction голосів одночасно: це усереднює результат.

## 1. Мінімальний стек

Repository-owned skills встановлюються в кожен project через
[AGENT-BOOTSTRAP.md](../AGENT-BOOTSTRAP.md). Exact external capabilities, required gates і audit format
визначені у [SKILLS-MANIFEST.md](../SKILLS-MANIFEST.md); «приблизно схожий skill десь у системі» не
вважається verified.

| Етап | Capability / skill | Роль | Людський гейт |
|---|---|---|---|
| Route → G4 | `$promo-landing-framework` | тримає порядок, артефакти й blockers | Product/Legal/Design |
| Product Truth / pre-release | `$playcity-copy-review` | PlayCity/legal red-team для copy, CTA, art і mandatory blocks | Legal/compliance |
| Intake | `grilling` — опційно після первинного brief | stress-test припущень, не заміна інтерв'ю | Product owner вирішує |
| Evidence | Browser / source reader | читає live/Figma/docs, фіксує source | Designer підтверджує role |
| Visual directions | Product Design `ideate` | рівно 3 image-based напрями | Art director обирає 1 |
| Asset production | `imagegen` | генерує/редагує bitmap assets | Brand/design asset approval |
| Implementation | Product Design `image-to-code` + Nuxt/Vue engineering | відтворює approved target | Design comparison |
| QA | Product Design `design-qa` + Browser | side-by-side fidelity та runtime evidence | QA/release owner |
| Publish | Sites/Vercel/approved host | зберігає та публікує approved version | Explicit release approval |

Якщо назва інструмента зміниться, зберігайте capability й contract, а не старе ім'я.

## 2. Розширений стек

- **Creative director:** один незалежний редакторський review після трьох напрямів і після full design.
- **Accessibility specialist:** veto на focus, contrast, semantics, touch targets, reduced motion.
- **Performance specialist:** budgets і production measurements.
- **Analytics specialist:** event taxonomy, cross-domain attribution і post-launch funnel.
- **Iframe/integration specialist:** bridge, origin, sizing, navigation, tokens.
- **Security review:** cross-origin messages, external scripts, privacy, PII.
- **Motion specialist:** лише після static design approval; не змінює IA/art direction без change request.

## 3. Правильна послідовність

```text
promo-landing-framework
  → source/evidence capture
  → product/legal truth
  → brand bridge
  → image-based ideation (3)
  → one selected target
  → hero approval
  → full design 1440/440/430/375
  → image generation / asset freeze
  → image-to-code
  → design QA + browser QA
  → release approval
  → publish
```

## 4. Що не делегується AI

- Бізнес-ціль і priority trade-offs.
- Дозвіл рекламувати claim.
- Canonical identity персонажа/логотипа.
- Фінальний вибір art direction.
- Перефразування approved verbatim legal copy.
- Рішення про production publish.

AI може знайти суперечність, запропонувати варіанти й підготувати evidence, але owner ставить approval.

## 5. Контракти скілів

### Questionnaire / grilling

Вхід: неповний brief. Вихід: blockers, contradictions, decisions. Заборонено: нескінченне опитування,
повторення відомих product/GEO/ЦА для Fast Track.

### Ideate

Вхід: sources/screenshots, Product Truth, Brand Bridge, content map. Вихід: рівно 3 візуально відмінні
image-based напрями. Заборонено: prose-only, code, generic reference-free layout.

### ImageGen

Вхід: approved slot dimensions, identity/style/composition references, invariants, negative constraints.
Вихід: asset + exact prompt + source mapping + mode + QA status. Заборонено: invent canonical logo/mascot,
приховувати фон замість true alpha.

### Image-to-code

Вхід: selected full design, viewport targets, asset register, technical standard. Вихід: local working
implementation. Заборонено: redesign сусідніх блоків, placeholder art, зміна approved copy.

### Design QA

Вхід: source target + implementation screenshot того самого viewport/state. Вихід: ranked differences,
fixes, second comparison, final verdict. Заборонено: «looks good» без combined comparison.

### Browser QA

Вхід: local/production URL і test matrix. Вихід: screenshots, DOM/runtime assertions, console/network
evidence. Заборонено: підміняти design QA одним screenshot.

### Publish

Вхід: exact approved version + explicit release approval. Вихід: public URL + terminal deployment status +
live verification. Заборонено: publish посеред локальних правок або owner-only link для зовнішнього показу.

## 6. Context hygiene

AI отримує не весь архів одразу, а пакет поточної фази:

- завжди: PROJECT-STATE і активний brief;
- G1–G2: Mechanics + Claims;
- G3–G7: Product KB, Brand Bridge, screenshots, content map;
- G8: Asset Register і style lock;
- G9: approved design + Technical Standard;
- G10: target captures + QA matrix;
- G11: exact reviewed version + release checklist.

Довгі технічні документи відкриваються лише за потреби. Це зменшує конфлікти й prompt dilution.

## 7. Review discipline

Кожна AI-знахідка — гіпотеза. Перед fix підтвердьте:

1. correctness;
2. відповідність фреймворку/версії;
3. design safety;
4. legal/content safety;
5. net win.

Валідна технічна оптимізація, що псує approved composition, не проходить review.

## 8. Anti-patterns

- Один mega-prompt на discovery, дизайн, assets і code.
- Паралельні art-direction агенти без спільного Brand Bridge.
- Skill-generated framework upgrade без перевірки `package.json`.
- «Зроби гарніше» замість exact surface + source + acceptance criteria.
- Автозастосування всіх review findings.
- Деплой як спосіб показати незавершений localhost.
- Надія, що AI пам'ятає всі минулі рішення без PROJECT-STATE.

Попередній каталог інструментів: [CLAUDE-CODE-SKILLS.md](../CLAUDE-CODE-SKILLS.md).
