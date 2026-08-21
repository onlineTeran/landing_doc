# Контракт корпоративного Git

Використовуйте для доставки до `https://git.sharkscode.com/cb/ai_landings.git`.

- Each landing is a self-contained root directory; do not commit generated `dist/`.
- Root `landings.json` is the publication source of truth with exactly `enabled`, `path`, `dist`,
  `build`. Path starts `/`, is not `/`, has no trailing slash and is unique. Dist is repo-relative.
  Build is executed inside the landing directory; use exact `static` for no-build landings.
- Branch `stage` maps only to Stage; branch `prod` maps only to Production. Other branches validate
  but cannot deploy/remove.
- CI validation, one repository security scan and affected landing build must pass before manual
  deploy/remove jobs appear.
- Required flow: Development → MR/review → manual Stage deploy → mandatory Stage QA → release
  task/controlled promotion → manual Production deploy → Production smoke → CDN/cache verification.
- Code review: authorized Frontend Developer or Frontend Lead. Deploy permissions reuse the main
  product access model. QA owns Stage minimum QA and Production smoke. AI never self-approves access.
- Record exact Stage-approved commit/build. Confirm current protected-branch promotion mechanism; do
  not invent whether it is stage→prod MR, cherry-pick or another policy.
- Approximately five-minute landing cache is documented. Verify the current build marker after deploy
  and after the cache window; decide rollback/hotfix on Critical/Blocker.
- Removal: set `enabled:false`, run manual `remove-<landing>` separately in required environments,
  verify URL/cache removal, then delete source/config in a later MR. Never delete the entry first.

Використовуйте `<methodology-root>/CORPORATE-GIT-RUNBOOK.md`, `GIT-DELIVERY.md`, `RELEASE-TASK.md`, `QA-TASK.md`
and `node <methodology-root>/scripts/validate-landings-config.mjs . [--require-dist]`.
