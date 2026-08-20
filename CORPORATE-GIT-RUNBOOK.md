# Corporate Git Runbook: `cb/ai_landings`

Канонічний deployment flow для корпоративних лендінгів. Він має вищий пріоритет за legacy
GitHub/Vercel flow у [DEPLOY-AND-LAUNCH.md](DEPLOY-AND-LAUNCH.md).

**Repository:** `https://git.sharkscode.com/cb/ai_landings.git`

**Підтверджені джерела:** repository README snapshot і процедура SlotsCityUA від 2026-08-20.
Live GitLab потребує корпоративної авторизації; конкретні protected-branch/MR правила треба
підтвердити в UI перед першим релізом.

## 1. Незмінний production flow

```text
Development
→ Merge Request + Frontend Review
→ Stage branch
→ validation + repository security scan + landing build
→ manual Stage deploy job
→ Stage analysis + mandatory minimum QA
→ production release task / MR according to current branch policy
→ prod branch
→ validation + security scan + landing build
→ manual Production deploy job
→ Production smoke test + CDN/cache verification
→ close release or rollback/hotfix
```

Не позначати G10/G11 зеленими на підставі local build. Stage deployment після G9 потрібен для G10,
але не дозволяє Production. Stage QA і Production smoke — різні
обов'язкові докази.

## 2. Repository contract

Кожен лендінг ізольований у власній директорії. `dist/` та інші generated build outputs не
комітяться. `landings.json` у root — єдине джерело правди для публікації.

```text
ai_landings/
├── <landing-id>/
│   ├── package.json
│   ├── package-lock.json
│   └── src/
└── landings.json
```

Built landing:

```json
{
  "<landing-id>": {
    "enabled": true,
    "path": "/<public-path>",
    "dist": "<landing-id>/dist/<optional-base-path>",
    "build": "npm ci && npm run build:static"
  }
}
```

Static landing uses `"build": "static"`; its `dist` may point directly to the landing directory.

### Field rules

| Field | Contract |
|---|---|
| `enabled` | boolean; `false` generates a manual removal job after push |
| `path` | starts with `/`, is not `/`, has no trailing `/`, unique across enabled/disabled entries |
| `dist` | relative to repository root; after build contains deployable `index.html` |
| `build` | command executed from landing directory, or exact value `static` |

For npm builds, keep `package.json` and `package-lock.json` synchronized because CI uses `npm ci`.
Only the configured `dist` contents are published.

## 3. Local delivery gate

Before an MR:

1. Rebase/update from the current target branch according to team policy; resolve conflicts without
   overwriting other landings.
2. Validate `landings.json` and uniqueness of `path`:

   ```bash
   node methodology/scripts/validate-landings-config.mjs .
   ```

3. Run the exact configured `build` from inside the landing directory.
4. Verify configured `dist` exists and contains `index.html`:

   ```bash
   node methodology/scripts/validate-landings-config.mjs . --require-dist
   ```

5. Run lint/typecheck/tests and production preview; confirm no generated build output or secrets are
   staged.
6. Update `GIT-DELIVERY.md`, `QA-TASK.md`, board task and MR description with exact commit/scope.

## 4. Merge Request and Stage

- MR needs Frontend Developer with appropriate rights or Frontend Lead review.
- CI first validates configuration, runs one repository security scan, detects changed landing
  directories and builds only affected landings.
- Failed validation, scan or build blocks deploy.
- Deploy/remove jobs exist only for `stage` and `prod`; other branches validate but cannot deploy.
- Stage deploy job is manual and can run only after required build succeeds.
- Deployment permission follows the main product access model; the framework never grants access.

### Mandatory Stage QA

- page loads and public path/base URL are correct;
- primary functional journey and CTA redirects work;
- responsive and GEO browser/device matrix pass;
- changed tracking/analytics is verified without duplication;
- no critical frontend/backend/console/hydration errors;
- iframe, Smartico and other integrations pass applicable states;
- QA owner records exact build SHA, evidence and `APPROVED` or blockers.

Any Critical/Blocker keeps Production release blocked.

## 5. Production release

Create a release task tied to the exact reviewed commit/build and Stage QA evidence. Do not infer the
promotion topology: confirm whether current policy uses an MR to `prod`, a controlled promotion or
another protected-branch mechanism. In all cases, the production source must be traceable to the Stage
build that QA approved.

Production deploy is a manual job after validation, security scan and build. It can be run only by a
Frontend Developer/Lead/DevOps user with the existing production rights. AI may prepare instructions
and evidence, but may not self-approve or bypass CI/manual jobs.

## 6. Production smoke and CDN/cache

Immediately after terminal deployment success verify:

- public URL availability and correct page load;
- primary UI, CTA redirects, tracking and critical integrations;
- zero Critical/Blocker runtime errors;
- served build marker/asset hashes match the released build;
- no stale version is returned after the documented approximately 5-minute landing cache window;
- relevant CDN nodes/regions serve the current version when the infrastructure provides that check.

On Critical/Blocker, the authorized owner decides rollback vs hotfix. Record decision, owner, timing,
affected commit and repeated smoke evidence.

## 7. Disable and remove safely

Removal is deliberately two changes:

1. Set `enabled: false`; keep the directory and `landings.json` entry.
2. Push to `stage` or `prod` as applicable and run the generated manual `remove-<landing>` job.
3. Verify the URL is unavailable and CDN cache is cleared; repeat for the other environment if needed.
4. Only after removal from every required environment, delete source and configuration in a separate MR.

Never delete the entry first: CI needs its `path` to remove the published landing.

## 8. Access and responsibility matrix

| Action | Required human role |
|---|---|
| Code review | Frontend Developer with rights / Frontend Lead |
| Stage deploy | Developer with corresponding main-product rights |
| Stage minimum QA | QA / named testing owner |
| Production deploy | Frontend Developer with Prod access / Frontend Lead / DevOps |
| Production smoke | QA / named testing owner |
| Rollback | User with corresponding Prod access |
