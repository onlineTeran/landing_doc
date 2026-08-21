# Claude Code: корпоративний промо-лендінг

Дотримуйся всіх правил з `AGENTS.md` як обов'язкового workflow contract.
Усі human-readable документи й відповіді веди українською за `LANGUAGE-POLICY.md`.

Перед будь-якою SlotCity/CATBET art/UI/component/audit задачею завантаж
`.claude/skills/brand-design-base/SKILL.md`. Перед landing роботою також завантаж
`.claude/skills/promo-landing-framework/SKILL.md`, а для gambling copy —
`.claude/skills/playcity-copy-review/SKILL.md`. Поточний стан завжди читай із
`docs/promo-landing/PROJECT-STATE.md`; не переходь до наступного гейта без human approval та не
виконуй Stage push/MR/deploy до G9 та явного Stage approval. Не merge/promote/deploy у Production
без G10 й окремого release approval для exact commit/build і target.

Не додавай побачену або передану картинку до `brand-archive` автоматично. До будь-якого copy,
download, crop, derivative або manifest entry отримай окреме явне storage consent користувача для
точного файлу, його brand/role і target path.
