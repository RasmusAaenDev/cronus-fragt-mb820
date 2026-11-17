# Step 10: Add an assisted setup guide

Delivers NavigatePage 50104 `CRF Freight Setup Guide` (`app/src/Setup/CRFFreightSetupGuide.Page.al`) and codeunit 50105 `CRF Assisted Setup Subs` (`app/src/Setup/CRFAssistedSetupSubs.Codeunit.al`). The guide has four steps (welcome, default carrier, shipment numbers, finish). The source table is temporary, so nothing reaches `CRF Freight Setup` until Finish. The codeunit subscribes to `OnRegisterAssistedSetup` of codeunit "Guided Experience" and registers the guide in the group `Ready for Business`, guarded by `Exists`.

| Checklist item | Where |
|---|---|
| NavigatePage with four steps | Page 50104, groups `StepWelcome`, `StepCarrier`, `StepNumbering`, `StepFinish`, shown by `SetStep`. |
| Back, Next, Finish in the footer, enabled where they make sense | Actions with `InFooterBar = true`; `BackEnabled`, `NextEnabled`, `FinishEnabled` are set in `SetStep`. |
| Saved only on Finish | `SourceTableTemporary = true`; only the `Finish` action calls `SaveSetup`. |
| Subscriber registers the guide | Codeunit 50105, `RegisterFreightSetupGuide`. |
| Running it updates the setup page | `SaveSetup` copies Default Carrier and Shipment Nos. to the real record (created if missing). |

Differences from the model answer: step state is an Integer with visibility booleans instead of an Option variable (options cannot be incremented cleanly); the page has `UsageCategory = None` so it is reachable only through Assisted Setup; texts are Labels; the codeunit is `Access = Internal`. The guide copies the existing setup with `TransferFields`.

Compile: `scripts/compile.sh app` 0 errors. Not run: opening Assisted Setup in the web client, running the guide and checking the result on the setup page need a sandbox. The ids are marked built in `object-ids.md` (page 50104, codeunit 50105). The permission set for them comes in step 14.
