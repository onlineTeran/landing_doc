# Execution Protocol: 7 пакетів від ідеї до корпоративного Git

Це короткий операційний контракт поверх 13 фаз у [framework/README.md](framework/README.md). Він
визначає, що агент робить, що створює і коли зобов'язаний зупинитися.

## Цикл кожного кроку

1. **Read:** прочитати `PROJECT-STATE.md` і лише джерела поточної фази.
2. **Declare:** назвати фазу, очікуваний результат, блокери та питання (до 10 за раунд).
3. **Produce:** створити/оновити versioned артефакт, не лише відповідь у чаті.
4. **Verify:** запустити перевірки, додати evidence і self-review; агент не дає business approval.
5. **Review:** запросити точний human approval із назвою артефакту/version/scope.
6. **Record:** записати approval, owner, дату, blockers і next action у `PROJECT-STATE.md`.

Якщо approval відсутній — агент завершує поточний крок статусом `BLOCKED`, пояснює один потрібний
крок від людини й не створює результати наступної фази.

## 7 робочих пакетів

| Пакет | Фази / гейти | Обов'язкові versioned outputs | Stop condition |
|---|---|---|---|
| 1. Опитувальник | 0–1 / G0–G1 | `PROJECT-BRIEF.md`, owner map, open questions | невідомі ціль, CTA, product, host або deliverables |
| 2. Проєктування | 2, 4–7 / G2, G4–G7 | Claims Matrix, Storyboard, 3 directions, hero, Figma 375/430/440/1440/context | немає product/legal/brand truth або design approval |
| 3. Референси й маскоти | 3, 8 / G3, G8 | `REFERENCE-AND-MASCOT-BASE.md`, Brand Bridge, Asset Register | немає rights, canonical identity або crop/style lock |
| 4. Стек та функціонал | 0, 9 / G0, G9 | `FUNCTIONAL-SPEC.md`, integration contracts, local build | версії стеку чи API/Smartico contract не підтверджені |
| 5. Product Knowledge | 2–3, 12 / G2–G3, G12 | Product KB snapshot, source register, decisions, retrospective updates | твердження без source/owner/freshness |
| 6. Git delivery | 9–11 / G9–G11 | `GIT-DELIVERY.md`, `RELEASE-TASK.md`, reviewed commit, Stage/Prod evidence | Stage QA не green або немає exact release approval |
| 7. QA handoff | 10 / G10 | `QA-TASK.md`, test data, matrix, expected results, evidence links | немає testable acceptance criteria |

Порядок гейтів залишається 0→12. Таблиця групує роботу за зрозумілими напрямами, але не дозволяє
виконати, наприклад, пакет 6 перед approved design та asset freeze.

## Команди контролю

У репозиторії лендінгу, де методологія підключена як `methodology/`:

```bash
./methodology/scripts/validate-project-state.sh .
./methodology/scripts/verify-project-skills.sh . codex
node ./methodology/scripts/validate-landings-config.mjs .
```

Валідатор перевіряє послідовність гейтів, обов'язкові поля approval і наявність артефактів для
досягнутих контрольних точок. Він не замінює review змісту.

## Git і release boundary

- Агент може створювати локальні файли, branch, commits і PR description лише в межах дозволу
  користувача та корпоративних правил.
- Stage push/MR/manual deploy — окремі зовнішні дії після G9; потрібен явний Stage approval, щоб
  отримати evidence для G10.
- Production merge/promotion/deploy — окремий дозвіл лише після G10 для exact commit/build і target.
- Release approval повинен містити commit SHA/tag, environment/target, approver і timestamp.
- Після deploy потрібні terminal status, public smoke test і запис live evidence у Project State.
- Для `cb/ai_landings` обов'язковий [CORPORATE-GIT-RUNBOOK.md](CORPORATE-GIT-RUNBOOK.md):
  `stage` і `prod` є окремими environment branches, deployment jobs manual, а Stage QA передує
  Production release. Legacy Vercel flow не застосовується без окремого рішення.
