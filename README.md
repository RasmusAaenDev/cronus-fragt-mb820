# Step 22: Update the tracking status from the carrier

Cronus Fragt · MB-820 workbook · Build the solution › Carriers and the outbound API

**[See what this step changed: diff against step 21](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/cac1e6bab9d70901cac8fd54df808213f2b31792...8cbbf5c9136447e59de719f2a3c5e011bbd61813)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> The best thing would be if the status on the shipments just updated itself a couple of times an hour,
> without anyone having to remember to press anything. And if one shipping agent's system doesn't respond, the
> other shipments should still be updated, so we don't end up with a whole day without news.

## Your task

Create the codeunit that the job queue will run to update the tracking status from the carriers, without letting one failing shipment tracking record stop the round.

**Do this**

1. Create CRF Update Status (codeunit 50103).
2. Its OnRun trigger finds the shipment tracking records that are booked or in transit and have a package tracking number, and updates each one through UpdateStatusNoError in CRF Freight Mgt.
3. A failure for one record must not stop the round: log it to telemetry with Session.LogMessage and go on with the next record.
4. Log the carrier, not the shipping agent code, which is CustomerContent on the record: add an internal procedure CarrierOf to CRF Freight Mgt that returns the CRF Carrier of the record's shipping agent, or blank when there is none.
5. The codeunit must not show any dialog, because a job queue entry runs it in a background session.
6. Until it is scheduled, test it from a temporary action that calls Codeunit.Run(Codeunit::"CRF Update Status"), and add it to CRF Freight Basic.

**Keep in mind**

- Module 3e connects an Application Insights resource and then schedules the codeunit with a job queue entry. Until the resource is connected, check in the debugger that the failure path runs.

## Checklist

- [ ] Codeunit 50103 CRF Update Status has an OnRun trigger that filters CRF Shipment Tracking Header on Status Booked or In Transit and a non-blank Package Tracking No.
- [ ] Each record is updated through CRF Freight Mgt, so the codeunit contains no carrier-specific code, no shipping agent lookup and no HTTP code.
- [ ] A failing record is logged with Session.LogMessage and the loop continues; no Message, Confirm or other dialog is used.
- [ ] The telemetry dimensions hold the record's SystemId and the carrier from CarrierOf, not the number, the shipping agent code or the error text.
- [ ] The loop doesn't modify the record variable it is iterating with a filter on Status.
- [ ] With one record whose carrier service fails (for example CA-FAIL-503) and one that works, a run updates the working one and logs the failing one.

## In this branch

- [Notes for this step](docs/steps/22-update-status.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/cac1e6bab9d70901cac8fd54df808213f2b31792...8cbbf5c9136447e59de719f2a3c5e011bbd61813): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/status-polling-codeunit

---

[← Step 21](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/21-carriers-and-the-outbound-api/keep-the-api-key-out-of-the-table/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 23 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/23-report-and-api-pages/the-freight-list-for-the-warehouse/README.md)
