# Stage / Production Release Task — <campaign> / <version>

## Traceability

- Board task:
- Landing ID / `landings.json` path:
- Source branch / target branch:
- MR and reviewed commit SHA:
- Build job/artifact:
- Stage URL:
- Production URL:
- Related `QA-TASK.md` and `GIT-DELIVERY.md`:

## Stage release

- [ ] Configuration validation, repository security scan and landing build passed.
- [ ] Manual Stage deployment job and authorized operator recorded.
- [ ] Stage build marker matches reviewed commit/build.
- [ ] Mandatory Stage QA completed; P0/P1 status and evidence linked.
- [ ] QA owner explicitly confirms Production readiness.

## Production authorization

- Promotion mechanism / MR into `prod` confirmed:
- Exact source commit/build approved for Production:
- Approver/role and timestamp/timezone:
- Authorized deployment operator:
- Rollback owner, signal and last-known-good version:

## Production release and smoke

- [ ] Production CI validation, security scan and build passed.
- [ ] Manual Production deploy job reached terminal success.
- [ ] Public availability, UI, CTA/redirects, tracking and integrations smoke passed.
- [ ] Served build marker/hash matches release.
- [ ] CDN/cache checked after the documented approximately 5-minute window.
- [ ] QA owner recorded result; Critical/Blocker count is zero.

## Incident decision

- Result: `RELEASED | ROLLED BACK | HOTFIX IN PROGRESS | BLOCKED`
- Issue/decision/owner/time:
- Rollback or hotfix commit/job:
- Repeated smoke evidence:
