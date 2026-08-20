# SlotCity Design System Gaps

**Design System version:** `0.9`

These gaps are explicit stop conditions, not invitations for AI inference.

| ID | Gap | Impact | Required evidence / owner |
|---|---|---|---|
| SC-GAP-001 | Tone of Voice page is empty | no brand-voice or CTA vocabulary approval | current ToV document, Brand/Content owner, version/date |
| SC-GAP-002 | live main mascot and owner-supplied supporting ensemble references exist, but no owner-approved passports | identity cues are evidenced; names, modification rights/anatomy/variant range remain unsafe | names, front/side/expression refs, anatomy/colors/materials, immutable/adaptable/forbidden matrices, rights |
| SC-GAP-003 | exact live logo SVG stored, but no complete logo contract | cannot validate clear space/minimum size/allowed variants | canonical masters and Brand owner rules |
| SC-GAP-004 | external component Markdown specs absent | exact property keys and automated Figma manipulation remain unverified | `COMPONENTS-INDEX.md` and referenced `*-SPEC.md` files or current live nodes |
| SC-GAP-005 | font licensing/ownership absent | font bundling cannot be approved from rendered evidence | font files/license/source owner |
| SC-GAP-006 | motion system absent | timing/easing/reduced-motion cannot be called canonical | approved examples and motion tokens |
| SC-GAP-007 | legal wording/binding level absent | qualifying CTA/disclaimer placement not releasable | exact Legal source and placement decision |
| SC-GAP-008 | intermediate responsive behavior undefined | only five observed breakpoints are canonical | Design owner behavior for widths between 360/414/768/1024/1440 |
| SC-GAP-009 | Brand owner approval missing | snapshot remains extracted, not canonical | approval quote, owner, date, exact snapshot scope |
| SC-GAP-010 | 3D Icon variant-count drift (172 documented vs 198 decoded labels) | automated selection may target superseded/unpublished variants | current upstream component set and publishable-variant list |

## Mascot passport required fields

- official name, role and relationship to SlotCity;
- canonical front/side/three-quarter views and expression range;
- proportions, silhouette, face, hands/paws, anatomy, colors and material;
- outfit/props and which may vary by campaign;
- immutable, adaptable and forbidden features;
- allowed crop/occlusion, interaction with prizes/copy/UI and mobile treatment;
- art style, camera, light and render family;
- generation/editing rights, source masters and approver;
- approved/rejected examples with rationale.

Until these exist, character art may use only an explicitly approved campaign source unchanged or remain
concept-only with `IDENTITY_UNVERIFIED`.
