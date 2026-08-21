# Контракт компонентів CATBET

**Design System version:** `0.9` · **Status:** `PARTIAL / INVENTORY PENDING`

Це контракт рішень для вибору, адаптації та реалізації компонентів CATBET. Точні
component names, variants and properties remain pending until the current design-system file is
supplied.

## 1. Пріоритет джерел компонентів

1. Current CATBET Figma component instance and its main component.
2. Current CATBET production behavior.
3. Approved campaign-local component with owner and scope.
4. New component approved at G7/G8.

Не перемальовуйте компонент зі скриншота й не підставляйте компонент SlotCity. Фіксуйте точні
`file_key`, `node_id`, component property values and source version in the Design Spec.

## 2. Очікувані сімейства

| Family | Known evidence | 0.9 rule |
|---|---|---|
| Navigation and header | production CATBET | inventory/states pending; preserve production behavior |
| Primary/secondary CTA | current product required | same-brand source required before G3 |
| Offer/reward card | campaign/product evidence | amount, condition and random/guaranteed state must map to Product Truth |
| CatBox selector/card | open/closed box assets | package tier and deposit sequence are separate properties |
| Mission/promo tile | current promos and mission art | current mechanic, dates and reward identity required |
| Badge/tag/chip | production/Figma pending | never use as an unverified guarantee |
| Tabs/carousel/accordion | production behavior pending | keyboard, touch, focus and reduced-motion states required |
| Form/control | Smartico or product boundary | contract owner and validation/error states required |
| Legal/footer block | Legal/product owned | immutable content IDs, link target and minimum presentation |

## 3. Обов'язкова матриця станів

Для кожного інтерактивного сімейства фіксуйте: `default`, `hover`, `focus-visible`, `pressed`, `disabled`,
`loading`, `success`, `error`, empty/unavailable state, keyboard behavior and mobile behavior. If a
state is owned by Smartico or another embedded product, document the boundary instead of simulating it.

## 4. Власник CTA

- CATBET-native landing: current CATBET CTA component and route contract are required.
- Cross-brand landing: the host normally owns shape, typography and interaction states; CATBET owns
  destination offer language and visual anchors.
- CTA copy, analytics event, authentication behavior, deep link and fallback URL are independent
  fields. A visual button alone is not a complete component specification.

## 5. Smartico та продуктова інтеграція

Для кожного віджета Smartico, місії, турніру, реєстрації або персоналізованого блока фіксуйте реальну
SDK/API/component version from the implementation repository, init/auth lifecycle, eligibility,
loading/empty/error states, consent, analytics, fallback and owner. Brand documentation cannot invent
product behavior. Integration gaps block G4/G8 according to their impact.

## 6. Приймання компонента

Компонент готовий до реалізації лише тоді, коли design source, content source, responsive geometry,
all relevant states, accessibility behavior, integration boundary and QA acceptance criteria are
linked. Otherwise return `COMPONENT_GAP: <family>/<state>` with owner and next action.
