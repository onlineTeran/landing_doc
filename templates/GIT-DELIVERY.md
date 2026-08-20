# Git Delivery & Release Record — <campaign>

## Repository contract

- Corporate repository: `https://git.sharkscode.com/cb/ai_landings.git`
- Landing ID / directory:
- `landings.json` path / dist / build / enabled:
- Default branch / protected branch rules:
- Working branch:
- Required reviewers / CODEOWNERS:
- CI checks:
- Hosting target and environment:
- Rollback owner/method:

## Local completion / Stage MR readiness

- [ ] G9 Feature Complete is approved.
- [ ] No secrets, raw masters, debug panels or unused assets are included.
- [ ] Production build/tests/lint/typecheck pass; commands and outputs linked.
- [ ] Content, asset and methodology versions are frozen.
- [ ] Diff is limited to approved scope.
- [ ] `landings.json` passes structural validation; public path is unique.
- [ ] Exact configured build passes from the landing directory and configured dist contains `index.html`.
- [ ] Generated `dist/` is not committed; package and lock file are synchronized.

## Change set

- Commit SHA:
- Build artifact/checksum:
- PR URL and summary:
- User-visible changes:
- Config/migration/cache notes:
- Known risks and waivers:
- Rollback signal:

## Stage evidence

- MR/review and reviewed SHA:
- Validation / repository security scan / build jobs:
- Manual Stage deploy job / authorized operator:
- Stage URL and served build marker:
- Stage QA approval / residual risks:

## Explicit release approval

- [ ] G10 QA Green is approved for the Stage build below.
- Exact commit/tag:
- Target/environment:
- Approver and role:
- Approval text/link:
- Timestamp/timezone:
- Promotion mechanism from Stage-approved source to `prod`:

## Post-deploy verification

- Deployment terminal result:
- Public URL:
- Smoke-test evidence:
- CTA/analytics/legal/asset verification:
- Served build marker after deploy and after cache window:
- CDN/node freshness evidence:
- Rollback required: yes/no; decision owner:
