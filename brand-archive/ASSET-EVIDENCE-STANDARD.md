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

## Reference admission consent gate

An image being attached, linked, opened, generated or used in the current task does **not** grant
permission to store it in the framework. Before every new image enters `brand-archive/**/assets`, the
agent must ask one explicit, file-specific question that states:

- exact source/file and product/brand;
- proposed reference role;
- proposed repository target path;
- whether an original, crop and/or derivative will be stored.

Only an explicit owner answer such as `так, додати <exact file/scope>` opens storage for that scope.
Silence, task feedback, permission to inspect/generate an image or approval of a design is not storage
consent. Without consent the agent may use the image transiently for the current task, but must not copy,
download, crop, checksum, register or commit it as methodology evidence.

Record approved storage in the manifest entry:

```json
"storageConsent": {
  "status": "APPROVED",
  "owner": "<name/role>",
  "date": "YYYY-MM-DD",
  "quote": "<verbatim approval>",
  "scope": "original|crop|derivative and exact target path"
}
```

Consent is per image and scope. It does not transfer to adjacent files, a whole webpage, future variants
or a different brand archive. Removing an asset also requires updating every manifest/register/link.

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
  "storageConsent": {
    "status": "APPROVED",
    "owner": "<name/role>",
    "date": "YYYY-MM-DD",
    "quote": "<verbatim approval>",
    "scope": "original|crop|derivative and exact target path"
  },
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
7. Pass the file-specific Reference Admission Consent Gate before any repository write or manifest entry.
8. When a newer source arrives, ask again, then add a new dated file and diff; do not silently overwrite evidence.

## Repository limits

- Commit only relevant snapshots with source and checksum; no scraped dumps.
- Prefer SVG for exact logos and WebP/AVIF for visual references.
- Store generated output separately from source references.
- Never commit credentials, private user data, unlicensed third-party artwork or a large Figma/DAM dump.
