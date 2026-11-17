# Step 21: Update shipment status from the carrier

Delivers codeunit 50103 `CRF Update Status` (`app/src/Freight/CRFUpdateStatus.Codeunit.al`), a temporary action `Update All Statuses` on `CRF Shipment List` and the permission set entry.

| Checklist item | Where |
|---|---|
| OnRun filters Status Booked or In Transit and a non-blank Tracking No. | `SetFilter(Status, '%1|%2', ...)` and `SetFilter("Tracking No.", '<>%1', '')`. |
| Every update goes through the facade; no carrier or HTTP code | `FreightMgt.UpdateStatusNoError`. |
| Failure is logged with Session.LogMessage and the loop continues; no dialogs | `LogFailure`, telemetry event `CRF-0002`; no Message or Confirm. |
| Loop does not modify the iterated record | Second variable `ShipmentToUpdate` is fetched with `Get` and updated. |
| One failing and one working shipment | **Not run here**, see below. |

Telemetry privacy: the shipment number is CustomerContent, so the dimensions are the shipment's SystemId and the carrier only, and the error text is left out (judgement call for a privacy review, as in the workbook). The id is `CRF-0002` because `CRF-0001` is used in step 19; `object-ids.md` records this.

The action on the shipment list is the "temporary action" the step asks for; step 29 schedules the codeunit with a job queue entry and the action can then be removed or kept as a manual trigger.

Compile: `scripts/compile.sh app` 0 errors. Not verified: the failure path (needs a failing and a working carrier endpoint and the debugger or Application Insights), and whether a job queue entry can start an `Access = Internal` codeunit (expected to work, since the job queue is not AL code calling it; step 29 must confirm in a sandbox).
