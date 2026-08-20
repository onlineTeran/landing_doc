<!-- promo-landing-framework:begin -->
## Corporate Promo Landing Framework

For any SlotCity/CATBET art, UI, component or visual-audit task, use the project-local
`brand-design-base` skill and route the surface before acting. For every promo landing task, also use
the project-local `promo-landing-framework` skill and read
`docs/promo-landing/PROJECT-STATE.md` before acting. For gambling copy, also use
`playcity-copy-review` before G2 and before release.

Work only on the current sequential gate. Record each human approval with owner, exact scope/version,
date and artifact path; never self-approve Product, Legal, Brand, Design, QA, Release or access rights.
Do not design before G3, generate production assets/code before G7, or implement before G8.

After G9, Stage push/MR/manual deploy requires explicit Stage approval and exists only to produce G10
QA evidence. Production merge/promotion/deploy requires G10 plus a separate explicit approval for the
exact commit/build and target. For `cb/ai_landings`, follow
`methodology/CORPORATE-GIT-RUNBOOK.md`; never substitute the legacy Vercel flow.

Resolve technical versions from the landing's `package.json` and facts from versioned project files,
not chat memory.
<!-- promo-landing-framework:end -->
