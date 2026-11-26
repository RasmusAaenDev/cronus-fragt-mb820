# Step 22: Update the tracking status from the carrier

Delivers codeunit 50103 `CRF Update Status` (`app/src/Freight/CRFUpdateStatus.Codeunit.al`), a temporary action `Update All Statuses` on `CRF Shipment Tracking List` and the permission set entry (`codeunit "CRF Update Status" = X` in `CRF Freight Basic`).

| Checklist item | Where |
|---|---|
| OnRun filters Status Booked or In Transit and a non-blank Package Tracking No. | `SetFilter(Status, '%1|%2', ...)` and `SetFilter("Package Tracking No.", '<>%1', '')` on `CRF Shipment Tracking Header`. |
| Every update goes through the facade; no carrier, shipping agent or HTTP code | `FreightMgt.UpdateStatusNoError`; the codeunit never reads the shipping agent. The facade finds the carrier through it (step 19). |
| Failure is logged with Session.LogMessage and the loop continues; no dialogs | `LogFailure`, telemetry event `CRF-0002`; no Message or Confirm. |
| Dimensions hold the record's SystemId and the carrier from `CarrierOf`, nothing else | `LogFailure`: `TrackingSystemId` and `Carrier` (`FreightMgt.CarrierOf`); no number, shipping agent code or error text. |
| Loop does not modify the iterated record | Second variable `TrackingToUpdate` is fetched with `Get` and updated. |
| One failing and one working record (for example `CA-FAIL-503`) | **Not run here**, see below. |

Telemetry privacy: the shipment tracking number is CustomerContent and so is the shipping agent code, so the dimensions are the record's SystemId and the carrier (the implementation, such as Carrier A) only, and the error text is left out (judgement call for a privacy review, as in the workbook). The id is `CRF-0002` because `CRF-0001` is used in step 20; `docs/design/object-ids.md` records this.

The action on the shipment tracking list is the "temporary action" the step asks for; step 29 schedules the codeunit with a job queue entry and the action can then be removed or kept as a manual trigger.

Compile: with the Business Central 28 compiler, 0 errors (`scripts/compile.sh app`). Not verified: the failure path (needs a failing and a working carrier endpoint, such as the mock's `CA-FAIL-503`, and the debugger or Application Insights), and whether a job queue entry can start an `Access = Internal` codeunit (expected to work, since the job queue is not AL code calling it; step 29 must confirm in a sandbox).
