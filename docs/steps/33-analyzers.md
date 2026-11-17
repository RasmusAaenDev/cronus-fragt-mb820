# Step 33: Make the code pass the analyzers

Both projects were built with the real analyzers (CodeCop, UICop, PerTenantExtensionCop) from the BC 28 AL language extension, natively on Linux: `scripts/compile.sh app --codecop` and `scripts/compile.sh test --codecop`. The script now also passes the project's ruleset and has a trial mode `--appsource`.

- `app/.vscode/settings.json`, `test/.vscode/settings.json`: `al.enableCodeAnalysis: true`, `al.codeAnalyzers` = CodeCop, UICop, PerTenantExtensionCop (no AppSourceCop), `al.ruleSetPath: ./cronusfragt.ruleset.json`.
- `app/cronusfragt.ruleset.json` and `test/cronusfragt.ruleset.json` (same content; a ruleset path must be inside the project).
- `app/AppSourceCop.json`: affix and country settings for the trial build (not used in the normal build).
- Fixes: `CRFFreightActivities.Page.al` (AW0002, action moved out of the cue group into the page `actions`, area Processing), `CRFShipmentLine.Table.al` (AA0232, `SumIndexFields = Weight` on the primary key because "Total Weight" is a FlowField sum).

## Findings of the first full build, with rule ids

| Project | Rule | Finding | Result |
|---|---|---|---|
| app | AW0002 (warning) | Cue group 'Shipments' had both fields and an action; web client shows only fields | Fixed |
| app | PTE0012 (warning) | `internalsVisibleTo` for the test app | Lowered to Info in the ruleset, justified there |
| app | AA0232 (info) | FlowField `Total Weight` should be in a SIFT key | Fixed |
| app | AA0247 (info, 36 objects) | Use namespaces | Lowered to Hidden, justified in the ruleset: all objects carry the CRF affix; moving to namespaces touches every reference and belongs with the AppSource decision |
| app | AW0006 (info) | `CRF Shipment Card` has no UsageCategory | Stays, on purpose: the card is opened from the list (`CRF Shipment List` is searchable); a second search entry for the same data would only be noise |
| test | AA0247 (info) | Use namespaces | Hidden, same reason |

After the fixes: app and test show 0 errors, 0 warnings. Remaining diagnostics: PTE0012 (Info) and AW0006 (Info) in the app, none in the test app.

Ruleset: AA0218 and AA0215 are raised to Error (a missing or wrongly worded tooltip stops the build; I verified that by deleting one tooltip, which gave `error AA0218`). The lowered rules (PTE0012, AA0247) each have a justification.

## Checklist

| Item | Where |
|---|---|
| Settings of both projects with the three analyzers, not AppSourceCop | the two `settings.json` files |
| Full build of each project, remaining diagnostics fixed or recorded | table above; run `scripts/compile.sh app --codecop` / `test --codecop` |
| Ruleset, set in `al.ruleSetPath`, one rule Error, justification for every lowered rule | `cronusfragt.ruleset.json` |
| Trial build with AppSourceCop | below |

PTE0004 (tables need a permission set) and PTE0008 (ApplicationArea) did not fire: `CRF Freight` covers all tables and page extension controls set `ApplicationArea` themselves.

## Trial build with AppSourceCop (`scripts/compile.sh app --appsource`, then back to `--codecop`)

Errors on the app (the test app gives the same plus AS0015 TranslationFile and warning AS0092):

- AS0084: ID range `[50100..50149]` is not valid; AppSource needs a range from 1000000-75999999 allocated to the partner, outside 50000-99999.
- AS0051 for `privacyStatement`, `EULA`, `help`, `logo`, `contextSensitiveHelpUrl` (all empty or missing in `app.json`).
- AS0052: `url` must be a valid URL.
- AS0081 (warning): `internalsVisibleTo`.
- Info: namespaces (AA0247), AW0006.

Not reported although I expected it: affix problems. With `mandatoryAffixes: ["CRF"]` all objects satisfy AS0011-type rules. Whether CRF is registered with Microsoft is a separate matter (step 35).

## Not done / not possible here

- AppSourceCop baseline: there is no earlier released `.app` of Cronus Fragt, so the version-comparison part of `AppSourceCop.json` (`name`, `publisher`, `version` of a previous package) cannot be set; AS0xxx breaking-change checks start from the first release. The file only holds affix and country configuration.
- "Run every time": the pipeline is step 36 (it cannot run here).
- Settings take effect in VS Code only after a window reload; I verified the same options through the compiler command line, not in the editor.
- The workbook's PTE0012 example says Info; alc accepts that.
