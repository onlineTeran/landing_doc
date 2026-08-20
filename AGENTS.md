# Інструкція для AI-агента: корпоративний промо-лендінг

Цей файл є обов'язковим entry point для Codex та інших агентів, що читають `AGENTS.md`.
Для будь-якої SlotCity/CATBET задачі з артом, UI, компонентом або візуальним аудитом спочатку
використай project-local skill `brand-design-base` і `framework/SURFACE-ROUTER.md`. Повний landing
переходить у процес нижче; isolated art не успадковує release gates і не дає права на implementation.

Для будь-якої задачі зі створення або зміни промо-лендінгу:

> Якщо задача змінює **сам framework repository**, а не конкретний лендінг, project kit і landing
> gates не потрібні; використовуй файли з root. У landing repository методологія зазвичай лежить у
> `methodology/`.

1. Прочитай `docs/promo-landing/PROJECT-STATE.md`. Якщо project kit відсутній — зупинись і
   запропонуй запустити `./methodology/scripts/bootstrap-project.sh . <product> <agent>`.
2. Використай project-local skills `promo-landing-framework` і `brand-design-base`; для gambling copy також
   `playcity-copy-review` перед G2 і перед релізом.
3. Назви у першому робочому повідомленні поточну фазу, гейт, потрібний артефакт і блокери.
4. Працюй лише над поточною фазою. Не починай наступну, доки попередній гейт не має `APPROVED`,
   owner, дати й посилання/шляху на артефакт.
5. Не затверджуй за людину Product, Legal, Brand, Design, QA або Release. Слово користувача
   «approved/погоджено» зафіксуй дослівно зі scope, owner, датою та версією.
6. Після кожної суттєвої відповіді онови `PROJECT-STATE.md`, відповідний артефакт і next action.
7. Не покладайся на пам'ять чату. Джерело правди — versioned files проєкту.

## Незмінний порядок

`Route → Intake → Product Truth → Brand Evidence → Content → Directions → Hero → Full Design →
Assets → Implementation → QA → Release → Learn`.

- Не проєктуй без G3.
- Не генеруй production assets і не пиши production code без G7.
- Не починай implementation без G8.
- Після G9 дозволено лише явно погоджений push/MR/manual deploy у **Stage**, потрібний для G10 QA;
  це не є Production approval.
- Не merge/promote/deploy у **Production** без G10 та окремого явного release approval для exact
  commit/build і target.
- Зміна механіки, claims, CTA route, integration boundary або approved design відкриває affected gate.

## Обов'язкові результати

Повний контракт виконання, 7 робочих пакетів і команди перевірки:
`methodology/EXECUTION-PROTOCOL.md` у landing repo або `EXECUTION-PROTOCOL.md` у framework repo.
Технічні версії завжди бери з `package.json` конкретного лендінгу, не з пам'яті чи прикладів.
