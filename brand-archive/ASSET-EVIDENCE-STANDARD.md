# Asset Evidence Pack Standard

This standard defines which visual files belong inside the methodology and how an agent may use them.
The goal is reproducible generation from exact evidence, not a folder of anonymous inspiration.

## Required layers

Each brand package keeps small, decision-critical files under `assets/`:

```text
assets/
  README.md             # human-readable role, source, rights and restrictions
  manifest.json         # checksum, capture date and machine selection rules
  reference/            # dated immutable snapshots used for identity/style/composition evidence
  canonical/            # only owner-approved masters; empty until approval exists
```

Large editable masters may remain in the corporate DAM/Figma, but their exact source, version, owner and
checksum must be recorded. A small identity-critical snapshot should live in the repository when rights
allow it, so Codex/Claude does not depend on a chat attachment or mutable URL.

## Evidence classes

| Class | Meaning | Agent permission |
|---|---|---|
| `CANONICAL_MASTER` | owner-approved source of truth | reuse/modify only by its explicit contract |
| `LIVE_SNAPSHOT` | dated file from current production | reference/reuse only as recorded; not a master |
| `APPROVED_CAMPAIGN` | exact asset approved for one known campaign | identity/style evidence; scope does not expand automatically |
| `OWNER_SUPPLIED_BRAND_SOURCE` | file supplied as internal brand/design evidence | extract and reference within recorded scope; approval/rights stay explicit |
| `DERIVED_IDENTITY_CROP` | lossless/controlled crop from a recorded source | identity role only; inherits source status and rights |
| `DERIVED_POSE_CROP` | focused crop from a recorded source used only for body/action arrangement | pose role only; cannot redefine identity, props or rights |
| `REFERENCE_ONLY` | useful visual evidence with unresolved rights/status | guide only the assigned role; never ship/copy by default |
| `NEGATIVE_EVIDENCE` | rejected or superseded example | use only to prevent recurrence |

`LIVE_SNAPSHOT` and `APPROVED_CAMPAIGN` do not become canonical because they are stored locally.

## Minimum manifest record

```json
{
  "id": "BRAND-ASSET-001",
  "path": "reference/file.ext",
  "sha256": "...",
  "sourceUrl": "https://...",
  "capturedAt": "YYYY-MM-DD",
  "evidenceClass": "LIVE_SNAPSHOT",
  "allowedRoles": ["identity"],
  "rightsStatus": "owner-confirmation-pending",
  "allowedUse": "reference-only",
  "identityRegion": "optional exact subject/region",
  "owner": null,
  "lastVerified": "YYYY-MM-DD"
}
```

## Generation selection

1. Select the product and task role before selecting a file.
2. Use one explicit role per reference in the prompt: identity, environment, material, composition,
   camera/light or negative evidence.
3. Use an identity reference for exact character/logo features; a style image cannot substitute it.
4. Keep logos as exact vector/layout layers. Never ask an image model to spell or recreate them.
5. Unknown modification rights mean immutable/reference-only.
6. Record every used asset ID and prompt role in the project Art Brief and Asset Register.
7. When a newer source arrives, add a new dated file and diff; do not silently overwrite evidence.

## Repository limits

- Commit only relevant snapshots with source and checksum; no scraped dumps.
- Prefer SVG for exact logos and WebP/AVIF for visual references.
- Store generated output separately from source references.
- Never commit credentials, private user data, unlicensed third-party artwork or a large Figma/DAM dump.
