# CTA та лінки: конфіг-шар і обробка кнопок

> Призначення: єдина система керування всіма кнопками й посиланнями лендінгу — усі дії живуть в одному
> конфіг-файлі (зміна лінка = правка одного рядка, не компонента), а один компонент кнопки сам обирає
> канал виконання: звичайний `<a>`, продуктовий роут чи `event_action` через `IframeBridge`
> (див. [`IFRAME-BRIDGE-INTEGRATION.md`](IFRAME-BRIDGE-INTEGRATION.md)).

Мітки: **Спостережено** / **Виведено** / **Рекомендовано** (див. `README.md`).

---

## 1. Чому це потрібно (уроки референс-білду)

- **Спостережено:** URL-и CTA були захардкоджені в компонентах секцій. Кожна зміна лінка чи тексту
  кнопки (а таких запитів було кілька за сесію: перейменування, заміна href, додавання іконок) — це
  правка `.vue`-файлу, ребілд і повторна перевірка компонента, який функціонально не змінився.
- **Спостережено:** плейсхолдерні URL (`https://example.com/`) дожили до пізніх фаз, бо жили розсипано
  по компонентах — їх не було видно списком.
- **Спостережено (v1.2.0):** з офіційним контрактом продукту з'явився другий канал дій — `event_action`
  через `IframeBridge.sendMessage()`. Тепер «куди веде кнопка» залежить від режиму інтеграції, і рішення
  не можна зашивати в розмітку.
- **Виведено:** дії лендінгу — це дані, а не розмітка. Їм місце в конфігу.

---

## 2. Модель: усі дії — в `config/actions.ts`

**Рекомендовано.** Один типізований файл описує кожну інтерактивну дію лендінгу. Компоненти посилаються
на дію за `id` і не знають, як вона виконується.

```ts
// types/actions.ts
export type LandingAction =
  | { kind: 'external'; href: string }                    // зовнішній сайт: <a target="_blank">
  | { kind: 'product'; href: string }                     // роут продукту: <a> (full-page) / target="_top"
  | { kind: 'event_action'; actionId: string; fallbackHref?: string } // дія в продукті через IframeBridge
  | { kind: 'anchor'; target: string }                    // скрол до секції лендінгу (#faq)

export interface CtaConfig {
  action: LandingAction
  analyticsId: string        // обов'язково: id для GA-події cta_click (див. GA-ANALYTICS-SPEC.md)
  label?: string             // текст кнопки теж можна тримати тут, якщо він варіюється між кампаніями
}
```

```ts
// config/actions.ts — ЄДИНЕ місце, де живуть усі лінки/дії лендінгу
export const ACTIONS = {
  hero_primary:    { action: { kind: 'event_action', actionId: 'event_action/registration', fallbackHref: 'https://product.example/signup' }, analyticsId: 'hero_primary' },
  map_open:        { action: { kind: 'event_action', actionId: 'event_action/bonus_map' },   analyticsId: 'map_open' },
  promo_all:       { action: { kind: 'product',      href: '/promo' },                       analyticsId: 'promo_all' },
  rules_pdf:       { action: { kind: 'external',     href: 'https://product.example/docs/rules.pdf' }, analyticsId: 'rules_pdf' },
  support:         { action: { kind: 'external',     href: 'https://product.example/support' },        analyticsId: 'support' },
  faq_jump:        { action: { kind: 'anchor',       target: '#faq' },                       analyticsId: 'faq_jump' },
} satisfies Record<string, CtaConfig>

export type ActionId = keyof typeof ACTIONS
```

**Правила конфігу:**

1. Жодного URL/`actionId` поза цим файлом — grep на `https?://` у `components/` має давати нуль збігів
   (крім конфігу й асетів). Це робить плейсхолдери видимими списком і закриває **Спостережено**-проблему.
2. `analyticsId` обов'язковий для кожної дії — кнопка без аналітики не існує.
3. Для `event_action` завжди фіксуй `fallbackHref`, якщо дія має сенс і поза iframe (standalone-прев'ю,
  full-page embed) — перелік `actionId` бери у контент-менеджерів (Discovery-пункт, див. контракт).
4. Зміна кампанії/ребрендинг лінків = git-diff одного файлу — легко рев'ювити й синхронізувати з командою.

---

## 3. Виконавець: `useCtaAction()` — Рекомендовано

Один composable вирішує, ЯК виконати дію, залежно від середовища (є `IframeBridge` чи ні):

```ts
// composables/useCtaAction.ts
export function useCtaAction() {
  function resolve(cfg: CtaConfig) {
    const a = cfg.action
    const inIframe = import.meta.client && !!window.IframeBridge && window.self !== window.top

    switch (a.kind) {
      case 'external':
        return { tag: 'a', href: a.href, target: '_blank', rel: 'noopener noreferrer' }
      case 'product':
        // в iframe звичайний <a> навігує сам iframe, а не продукт → _top; у full-page — простий лінк
        return { tag: 'a', href: a.href, target: inIframe ? '_top' : undefined }
      case 'event_action':
        if (inIframe) return { tag: 'button', onClick: () => window.IframeBridge!.sendMessage('event_action', a.actionId) }
        return a.fallbackHref
          ? { tag: 'a', href: a.fallbackHref }
          : { tag: 'button', disabled: true } // дія недоступна поза продуктом — чесно показати
      case 'anchor':
        return { tag: 'a', href: a.target }
    }
  }
  return { resolve }
}
```

**Виведено (з контракту):** `event_action` існує лише всередині iframe із живим ядром; `sendMessage`
поза iframe тихо ігнорується — тому для standalone потрібен `fallbackHref` або чесний disabled-стан,
інакше кнопка «мовчки не працює».

---

## 4. Компонент: один `<CtaButton>` — Рекомендовано

Усі кнопки лендінгу — один компонент. Він рендерить `<a>` чи `<button>` з резолвера, вішає GA-подію
і стани; секційні компоненти передають лише `action-id` та варіант стилю:

```vue
<script setup lang="ts">
import { ACTIONS, type ActionId } from '~/config/actions'

const props = defineProps<{ actionId: ActionId; variant?: 'primary' | 'gray' | 'ghost'; size?: 'lg' | 'md' | 'sm' }>()
const { resolve } = useCtaAction()
const { track } = useAnalytics() // див. GA-ANALYTICS-SPEC.md

const cfg = ACTIONS[props.actionId]
const r = resolve(cfg)

function onClick(e: MouseEvent) {
  track('cta_click', { cta_id: cfg.analyticsId, action_kind: cfg.action.kind })
  if ('onClick' in r && r.onClick) { e.preventDefault(); r.onClick() }
}
</script>

<template>
  <component
    :is="r.tag"
    class="btn"
    :class="[`btn--${variant ?? 'primary'}`, `btn--${size ?? 'lg'}`]"
    :href="'href' in r ? r.href : undefined"
    :target="'target' in r ? r.target : undefined"
    :rel="'rel' in r ? r.rel : undefined"
    :disabled="'disabled' in r ? r.disabled : undefined"
    @click="onClick"
  >
    <slot>{{ cfg.label }}</slot>
  </component>
</template>
```

Використання в секції — жодних URL:

```vue
<CtaButton action-id="hero_primary" variant="primary" size="lg">Головна дія</CtaButton>
<CtaButton action-id="promo_all" variant="gray">Всі акції</CtaButton>
```

**Правила кнопок (з дизайн-дисципліни референс-білду — Спостережено):**

- Текст кнопки — один рядок на desktop (без переносів); іконки — інлайн-SVG поруч із текстом
  (базовий `.btn` — `inline-flex` + `gap`).
- Стани: hover лише під `(hover:hover) and (pointer:fine)`; `:active` — фізичний відгук
  (`translateY(1px)`); disabled — знижена opacity + `cursor: default`, без втрати змісту.
- Контраст тексту до фону кнопки — WCAG AA мінімум; touch-target ≥ 44px.
- Зовнішні лінки — завжди `rel="noopener noreferrer"`.

---

## 5. Зв'язок з рештою методології

- Перелік `actionId` + реальні URL — це тепер пункт **Discovery** (замість «точні URL» — «точні URL
  **та** event_action-id від контент-менеджерів»). Див. `LANDING-WORKFLOW.md` фаза 1 і контракт.
- `analyticsId` кожної дії — вхідні дані для [`GA-ANALYTICS-SPEC.md`](GA-ANALYTICS-SPEC.md): таблиця
  CTA в конфігу = таблиця `cta_id` для аналітиків, вони збігаються за побудовою.
- `config/actions.ts` — частина content-config шару зі `STARTER-ARCHITECTURE.md`; це перший конкретний
  його модуль. Копі кнопок (`label`) можна тримати там само, якщо вони змінюються між кампаніями.

## 6. Чекліст

- [ ] Усі кнопки — через `<CtaButton action-id="…">`; grep `https?://` по `components/` — 0 збігів.
- [ ] Кожна дія в `config/actions.ts` має `analyticsId`; список збігається зі специфікацією для аналітиків.
- [ ] `event_action`-дії мають `fallbackHref` або усвідомлений disabled поза iframe.
- [ ] `product`-лінки в iframe отримують `target="_top"` (перевірити в реальному embed).
- [ ] Жодних плейсхолдерів на момент фази QA — конфіг рев'юнеться списком.
