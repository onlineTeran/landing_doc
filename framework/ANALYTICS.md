# Analytics Framework для промо й cross-brand traffic bridge

Аналітика починається з бізнес-цілі в G1, але імплементується після стабілізації IA. Головна помилка —
міряти багато scroll events і не мати зв'язку між CTA на host і реєстрацією/депозитом на destination.

## 1. Measurement model

```text
eligible traffic
  → landing view
  → offer/mechanics understood
  → CTA click
  → destination arrival
  → registration
  → first qualifying action / deposit
```

Лендінг напряму володіє першими 3–4 кроками. Destination product володіє результатом. Attribution
contract потрібен до launch, інакше красивий CTR не доводить бізнес-ефект.

## 2. Success metrics

| Рівень | Метрика | Примітка |
|---|---|---|
| Primary | CTA click-through rate | clicks / eligible landing views |
| Primary | destination registration rate | registrations / unique outbound visitors |
| Business | first qualifying action / deposit rate | продуктова метрика, якщо дозволено |
| Diagnostic | hero-to-intro continuation | чи не відштовхує hero |
| Diagnostic | mechanics reach | чи бачать ключове пояснення |
| Diagnostic | CTA CTR by location | hero vs intro vs offer |
| Guardrail | performance / errors | візуальний ефект не має ламати funnel |

Визначте owner, data source, denominator і attribution window до release.

## 3. Мінімальна event taxonomy

| Event | Коли | Ключові parameters |
|---|---|---|
| `promo_landing_view` | один раз після eligible render | campaign_id, host_brand, destination_brand, placement, locale |
| `promo_section_view` | P0 section ≥50% visible один раз | section_id, order |
| `promo_cta_impression` | CTA реально видимий | cta_id, location, label |
| `promo_cta_click` | до navigation | cta_id, location, destination, campaign_id |
| `promo_video_start` | user/autoplay start за потреби | asset_id, autoplay, viewport_group |
| `promo_video_complete` | loop/creative має meaningful end | asset_id |
| `promo_interaction` | лише meaningful choice | interaction_id, value; без PII |
| `promo_error` | media/integration/route failure | type, asset_id/action_id |

Не відправляйте подію на кожен decorative animation або кожні 10% scroll без аналітичного питання.

## 4. Cross-domain attribution

Узгодьте один механізм:

- cross-domain analytics linker;
- approved campaign parameters (`utm_*`, `campaign_id`, `placement`);
- host `event_action` / bridge payload;
- server-side join за anonymous campaign/session id, якщо продукт підтримує.

Не передавайте user id, телефон, email, token або інші PII в URL.

## 5. CTA contract

Кожен CTA row в [ANALYTICS-PLAN.md](../templates/ANALYTICS-PLAN.md) містить:

- stable `cta_id`;
- visible label;
- location;
- destination route;
- navigation channel (`href`, `_top`, bridge event);
- analytics channel;
- expected destination marker;
- QA evidence.

Верхня й нижня кнопки можуть мати різний label, але мають одну primary business action, якщо brief не
доводить інше.

## 6. Placement і brand dimensions

Обов'язкові dimensions для двох продуктів:

- `campaign_id` — стабільний id кампанії, не display name;
- `host_brand` — де сторінку показано;
- `destination_brand` — куди ведемо;
- `placement` — route/component slot;
- `creative_version` — дизайн/asset release;
- `landing_version` — release version;
- `viewport_group` — mobile/tablet/desktop;
- `locale` і `geo`, якщо legal дозволяє та це вже доступно без PII.

## 7. Consent і ownership

- Full-page embed зазвичай використовує consent та analytics layer host-продукту.
- Iframe не повинен тихо запускати другий analytics stack; preferred — bridge events до host.
- Події мають deduplication rule.
- Product analyst апрувить taxonomy; frontend доводить emission; QA перевіряє network/dataLayer.

## 8. Pre-release QA

- `promo_landing_view` один раз, не дублюється hydration/route updates.
- CTA impression не fire-иться offscreen.
- CTA click встигає відправитися до navigation.
- label/location/id відповідають UI.
- Cross-domain parameters переживають redirect і доступні destination analytics.
- Consent-off режим не відправляє заборонені дані.
- Усі події задокументовані й мають owner-а.
- Аналітика не блокує LCP та не додає console errors.

## 9. Post-launch review

Через 24–72 години:

- перевірити event volume, duplicates, parameter completeness;
- порівняти CTA locations;
- знайти найбільший funnel drop;
- сегментувати за viewport/browser/host placement;
- звірити creative version;
- відділити UX-проблему від проблеми attribution;
- створити одну дизайн-гіпотезу на наступну ітерацію, а не хаотичний redesign.

Детальна GA4-конвенція: [GA-ANALYTICS-SPEC.md](../GA-ANALYTICS-SPEC.md).
