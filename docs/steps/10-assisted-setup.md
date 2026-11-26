# Step 10: Add an assisted setup guide

Delivers NavigatePage 50104 `CRF Cronus Freight Wizard` (`app/src/Setup/CRFCronusFreightWizard.Page.al`) and codeunit 50105 `CRF Assisted Setup Subs` (`app/src/Setup/CRFAssistedSetupSubs.Codeunit.al`). The guide has three steps: welcome with the default shipping agent, shipment tracking numbers, and finish. The standard assisted setup banners are shown at the top when the media is available. The source table is temporary, so nothing reaches `CRF Freight Setup` until Finish. The codeunit subscribes to `OnRegisterAssistedSetup` of codeunit "Guided Experience" and registers the guide in the group `Ready for Business`, guarded by `Exists`.

| Checklist item | Where |
|---|---|
| NavigatePage with welcome, default shipping agent, number series and finish | Page 50104, groups `Step1` (welcome and `StepCarrier`, the field `Default Shipping Agent Code`), `Step2` (field `Shipment Tracking Nos.`) and `Step3` (finish), shown by `EnableControls` through `ShowStep1`, `ShowStep2` and `ShowStep3`. |
| Back, Next, Finish in the footer, enabled where they make sense | Actions `ActionBack`, `ActionNext` and `ActionFinish` with `InFooterBar = true`; `ResetControls` and the `ShowStep` procedures set `BackActionEnabled`, `NextActionEnabled` and `FinishActionEnabled`. |
| Saved only on Finish | `SourceTableTemporary = true`; `OnOpenPage` copies the existing setup into the temporary record, and only `FinishAction` calls `StoreFreightSetup`. |
| Subscriber registers the guide | Codeunit 50105, `RegisterFreightSetupGuide`. |
| Running it updates the setup page | `StoreFreightSetup` gets or creates the real record and copies the fields with `TransferFields(Rec, false)`. |

How the steps work: `Step` is an Option (`Start,Step2,Finish`). `NextStep` moves it back or forward and calls `EnableControls`, which first resets every step and action (`ResetControls`) and then shows one step. `LoadTopBanners` (called from `OnInit`) reads the standard `AssistedSetup-NoText-400px.png` and `AssistedSetupDone-NoText-400px.png` from the Media Repository.

Compile: BC 28 compiler, 0 errors. Not run: opening Assisted Setup in the web client, running the guide and checking the result on the setup page need a sandbox. The ids are marked built in `object-ids.md` (page 50104, codeunit 50105). The permission set for them comes in step 15.
