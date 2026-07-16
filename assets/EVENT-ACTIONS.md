# Універсальні івенти (event_action) — офіційна таблиця продукту

> **Провенанс:** відновлено з технічного документа продуктової команди «[tech] Універсальні івенти»
> (PDF, отримано 2026-07-16; діє для Web/iOS/Android обох брендів — SC+CB). Це **канонічний перелік**
> `event_action`-id для CTA лендінгів (використовується разом із контрактом
> [`IFRAME-BRIDGE-README.md`](IFRAME-BRIDGE-README.md)): `IframeBridge.sendMessage('event_action', '<id>')`.
> Актуальність/нові id — у продуктовому Confluence; при розбіжностях перевага за їхнім документом.

## Поведінка авторизації (важливо для лендінгів)

Після кліку **продукт сам** перевіряє, чи потребує дія авторизації:
- не потребує → сторінка/дія виконується одразу;
- потребує → за наявності `auth_by` (Cookies; історично LocalStorage) користувача ведуть на **логін**
  з активним збереженим способом входу (email/phone), інакше — на **форму реєстрації**.

Тобто `event_action` безпечно слати й для неавторизованих — редірект на auth робить продукт.

## Шаблони підстановки

- `:term` — слаг сутності (акції / турніру / гри) з CMS.
- `:id` — специфічний ідентифікатор (Smartico dp, повний URL для `url/:id`, промокод).
- Розділи/категорії ігор: `event_action/section/:section_term?subsection=:subsection_term`
  (напр. `event_action/section/slots`, `event_action/section/slots?subsection=top`).

## Таблиця відповідності

### Базові
| Дія | Path | event_action |
|---|---|---|
| Головна сторінка | `/` | `event_action/home` |
| Авторизація (модалка, з урахуванням authBy) | `/?modals=auth` | `event_action/auth` |
| Реєстрація (з урахуванням authBy) | `/registration` | `event_action/registration` |

### Каса
| Дія | Path | event_action |
|---|---|---|
| Каса без передобраного бонусу | `/?modals=cashier` | `event_action/cashier` |
| Каса з передобраним бонусом | `/?modals=cashier` | `event_action/cashier_preselect_bonus/:id` |
| Розділ «Виплата» | `…cashierType=withdrawal` | `event_action/cashier/withdrawal` |
| Розділ «Історія» | `…cashierType=history` | `event_action/cashier/history` |

### Верифікація
| Дія | event_action |
|---|---|
| Загальна сторінка верифікації | `event_action/verif` |
| → «Документи» (вибір методу) | `event_action/verif/document_select` |
| → «Ліміти» | `event_action/verif/limits` |
| → «Ліміти» → таба «Витрати» | `event_action/verif/limits_payment` |
| → «Номер телефону» | `event_action/verif/phone` |
| → «Email» | `event_action/verif/email` |
| ReKYC → «Update_documents» | `event_action/verif/update_documents` |

### Акції / Promo
| Дія | Path | event_action |
|---|---|---|
| Загальна сторінка «Акції» | `/promotions` | `event_action/promotions` |
| Конкретна акція (у т.ч. кастомні: WP, City VIP, Bonus Machine…) | `/promotions/:slug` | `event_action/promotions/:term` |
| Акції → конкретна таба | `/promotions?list-id=…` | `event_action/promotions_tab` |
| Акція promobuilder з якорем | — | `event_action/promotions/:term?anchor={value}` |
| Проскрол до кастомного блоку на сторінці (web) | — | `event_action/anchor/:anchor_id` |
| Модалки Smartico | — | `event_action/smartico/:id` (`:id` = `dp:…`) |
| Зовнішній URL (напр. опитування, оферта) | — | `event_action/url/:id` (`:id` = повний URL) |

### Профіль
| Дія | event_action |
|---|---|
| Сторінка «Профіль» | `event_action/profile` |
| «Налаштування» | `event_action/profile/settings` |
| «Активні пристрої» | `event_action/profile/active_devices` |
| Відновлення паролю (security) | `event_action/profile/security` |
| Сторінка «Ліміти» | `event_action/profile/limits` |
| Ліміти → таба витрат | `event_action/profile/limits_payments` |
| Модалка «Допомога» | `event_action/modal_support` |

### Ігри
| Дія | event_action |
|---|---|
| Конкретна гра | `event_action/game/:term` |
| Модалка деталей гри | `event_action/game_modal/:term` |
| Розділ ігор | `event_action/section/:section_term` |
| Категорія в розділі | `event_action/section/:section_term?subsection=:subsection_term` |
| Випадкова гра (з анімацією) | `event_action/random_game` |
| «Переглянуте» (*only app*) | `event_action/last` |
| Модалка пошуку | `event_action/search` |

### Бонуси / Промокоди / Рівні
| Дія | event_action |
|---|---|
| «Бонуси» (з логікою переходу) | `event_action/bonuses` |
| «Бонуси» → Доступні (в обхід логіки) | `event_action/bonuses/available` |
| Промокод — дефолтна модалка | `event_action/promocode` |
| Модалка з передзаповненим кодом | `event_action/promocode/:code` |
| Запит на активацію промокоду | `event_action/promocode_activate/:code` |
| Сторінка «Рівні» | `event_action/levels` |

### Турніри / Розіграші
| Дія | event_action |
|---|---|
| «Турніри» | `event_action/tournaments` |
| Конкретний турнір | `event_action/tournament/:term` |
| «Розіграші» | `event_action/raffles` |
| Конкретний розіграш | `event_action/raffle/:term` |

### Інформаційні сторінки
| Дія | Path | event_action |
|---|---|---|
| Служба підтримки | `/info/support` | `event_action/info_support` |
| FAQ | `/faq` | `event_action/faq` |
| Ліцензія | `/info/license` | `event_action/info_license` |
| Політика AML/KYC (обʼєднана) | `/info/kyc-and-amlpolicy` | `event_action/info_kyc_amlpolicy` |
| Правила гри | `/info/game-rules` | `event_action/info_game_rules` |
| Правила та умови | `/info/rules` | `event_action/info_rules` |
| Партнерам | `/info/partners` | `event_action/info_partners` |
| Політика конфіденційності | `/info/privacy-policy` | `event_action/info_privacy_policy` |
| Відповідальна гра | `/info/responsible-gaming` | `event_action/info_responsible_gaming` |
| Інтелектуальна власність | `/info/intellectual-property` | `event_action/info_intellectual_property` |
| Благодійна допомога | `/foundation` | `event_action/foundation` |
| Мобільний застосунок | `/casino-app` | `event_action/casino_app` |

### Deprecated (НЕ використовувати в новому заповненні)
`event_action/game_hall`, `game_hall/:term`, `providers`, `providers/:term`, `slots`, `slots/:term`,
`collections`, `collections/:term`, `live`, `live/:term`, `favourites` — замінені універсальним
`event_action/section/:section_term?subsection=:subsection_term`. Також застарілі:
`event_action/casino` (сторінку прибрано), `event_action/info_amlpolicy` та
`event_action/info_know_your_customer` (обʼєднані в `info_kyc_amlpolicy`).

---

## Застосування в лендінгах (методологія)

- Кожна CTA лендінгу описується в `config/actions.ts` дією `{ kind: 'event_action', actionId, fallbackHref }`
  (див. [`CTA-AND-LINKS.md`](../CTA-AND-LINKS.md)); `fallbackHref` — реальний Path з таблиці на домені продукту.
- Для кастомних акцій id **створюються контентом** за шаблоном `event_action/promotions/:term` —
  term своєї акції підтверджуй у контент-менеджерів на етапі Discovery.
- Зовнішні переходи — `<a target="_blank" rel="noopener noreferrer">` (за контрактом), не `event_action/url/:id`,
  якщо лінк статичний і відомий лендінгу.
