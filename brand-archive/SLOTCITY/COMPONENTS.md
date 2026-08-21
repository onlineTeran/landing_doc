# Контракти компонентів SlotCity

**Design System version:** `0.9`

## Правила вибору

Повторно використовуйте погоджений live-компонент до генерації або відтворення. Визначайте його за source library і
component/set key, not name alone. If this snapshot conflicts with the current live component, the live
component wins and the mismatch must be reported.

## Основні сімейства

| Family | Contract | Default / observed landing use | Critical restriction |
|---|---|---|---|
| Button | State 5 × Color 9; nested sizes L/M/S/micro and Round | one Primary per block; S/M dominate promos | loading is 60×60 loader recipe, not icon-only; <44px requires rationale |
| Badge | Size 3 × Background 3 × Color 8; four booleans | Micro + Solid + text only | Orange/Red landing meaning undefined |
| Button_fresh | Color 10 × State 4; nested size | Black/Default/micro favorite control | heart glyph must not remain on non-favorite actions |
| Timer | Color 4 × Background 3 | Green → Orange → Red → Gray state progression | thresholds are undefined; color is state, not decoration |
| Alert | Color 5 × Background Yes/No; two Button slots | status: Green/Red/Orange; info: Blue/Gray | promo disclaimer stays Gray; action uses Button contract |
| Link | Color/State/Bold/Size/Line, 96 variants | Yellow + Bold; inline Small/Line, title Large/no line | use link behavior, not visual similarity |
| Tabs | count/color/orientation/radius | 4/Gray/Horizontal/32 filter set | group switch; not interchangeable with independent chips |
| Input | State + three booleans, 7 variants | live-component inspection required | no detailed landing behavior proven here |
| Gradient | 15 variants | BlueVioletGreen or RedViolet observed | choose by approved art direction, not default |
| 3D Icon | guide declares 172 variants; decoded attached-library copies expose 198 unique labels | Gift Red, Trophy observed | verify current upstream set before automation |

Supporting families documented in the source: `Text + Description`, `_BaseCard_text`,
`TablePlaceholder + HeaderPlaceholder`, `Tooltip`.

## Семантика кнопок

- `Primary`: first action in the block—play, sign in, confirm, continue.
- `Secondary`: monetary/user-value action—deposit, register, verify, activate bonus, collect reward.
- `Transparent`: tertiary/navigation/legal/help/see all.
- `Gray`: neutral service or second-priority action.
- `White`: saturated art/background where normal fill loses contrast.
- `Accent`, `Info`, `Alert`: do not choose on promo landings without explicit approved use.

Стандартні розміри: L `205×56`, M `162×44`, S `123×32`, micro `96×24` із Round=False. Round=True
normal for text CTA capsules, chips and icon controls. On mobile a primary CTA may fill a narrow card;
on desktop it remains content-driven rather than stretching edge-to-edge.

## Реєстр promo-віджетів

| Widget | Evidence-backed behavior |
|---|---|
| Banner | campaign banner inside the promotion page |
| Text | up to ten list items, text/slogan and optional Alert |
| Button | standalone CTA; M, Round=False, Primary, text only by default |
| Video | title, description, video and button; all except video can toggle |
| Games | tournament games; 1–6 align left and container hugs content |
| Accordion | conditions/filter content |
| Other promo | card scroller near the bottom with links to promotions |
| Card | “how it works” family supporting 1–5 cards |
| Slots card | desktop/mobile, image/link/bonus/description toggles; max 10 games observed |
| Bonus card | single and multi-card, standard and combined-bonus arrangements |
| Table | promotion data for slots, bets and deposits; optional Alert |
| Image | auto or 100% width, token radius, left/center/right, optional caption; max 800 desktop/500 mobile observed |

Текстові колонки таблиці ділять ширину до 150 px, після чого стають фіксованими й прокручуються горизонтально. Комірки допускають до
three visible lines; source documentation states max 100 characters per cell and 30 per column name.

## Поверхні продуктових інтеграцій

Архів містить повторно використовувані responsive-приклади для `SmarticoBlock` (`Desktop/Tablet` і `Mobile`;
variants `Default`, `Love Season`, `HB`, `NY`), `SmarticoCards` (Yellow/Blue/Violet/Green; S/XS),
`VipBlock` (L/S), `APPBlock` and welcome-bonus/popup families. These are component evidence, not an API
state model. Visual work must pair them with [SMARTICO-INTEGRATION.md](../../SMARTICO-INTEGRATION.md)
or the current product contract for authorization, loading, empty, partial, error and success behavior.
Ніколи не виводьте стан місії чи право на винагороду з декоративного варіанта.

## Прогалини компонентів

Figma неодноразово посилається на зовнішні Markdown-специфікації, як-от `BUTTON-SPEC.md`, `BADGE-SPEC.md` і
`COMPONENTS-INDEX.md` at a local designer path. Those files were not part of the supplied archive.
Тому точні property keys і upstream ownership слід повторно перевірити в актуальній Figma до написання коду
or automated component manipulation.

Кількість 3D Icon сама є доказом version drift: авторська документація вказує 172, тоді як усі
decoded attached-library copies contain 1,348 symbol records and 198 unique variant labels. Do not treat
the extra labels as current publishable variants until the canonical component set is inspected.
