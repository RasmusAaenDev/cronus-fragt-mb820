# Step 21: Update shipment status from the carrier

Cronus Fragt · MB-820 workbook · Build the solution › Carriers and the outbound API

**[See what this step changed: diff against step 20](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/3e1237f3c0a81834054688caf865a31e25e8d0a3...299647ac1d50861dc0230e779bf3fc5995c88d57)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> The best thing would be if the status on the shipments just updated itself a couple of times an hour, without
> anyone having to remember to press anything. And if one carrier doesn't respond, the other shipments should
> still be updated, so we don't end up with a whole day without news.

## Your task

Create CRF Update Status (codeunit 50103), the codeunit that the job queue will run. Its OnRun trigger finds the shipments that are booked or in transit and have a tracking number, and updates each one through UpdateStatusNoError in CRF Freight Mgt. A failure for one shipment must not stop the round: log it to telemetry with Session.LogMessage and go on with the next shipment. The codeunit must not show any dialog, because a job queue entry runs it in a background session. Until it is scheduled, test it from a temporary action that calls Codeunit.Run(Codeunit::"CRF Update Status"), and add it to CRF Freight. Module 3e connects an Application Insights resource and then schedules it with a job queue entry; until the resource is connected, check in the debugger that the failure path runs.

## Checklist

- [ ] Codeunit 50103 CRF Update Status has an OnRun trigger that filters CRF Shipment Header on Status Booked or In Transit and a non-blank Tracking No.
- [ ] Each shipment is updated through CRF Freight Mgt, so the codeunit contains no carrier-specific code and no HTTP code.
- [ ] A failing shipment is logged with Session.LogMessage and the loop continues; no Message, Confirm or other dialog is used.
- [ ] The loop doesn't modify the record variable it is iterating with a filter on Status.
- [ ] With one shipment whose carrier service fails and one that works, a run updates the working one and logs the failing one.

## In this branch

- [Notes for this step](docs/steps/21-update-status.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/3e1237f3c0a81834054688caf865a31e25e8d0a3...299647ac1d50861dc0230e779bf3fc5995c88d57): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/status-polling-codeunit

---

[← Step 20](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/20-carriers-and-the-outbound-api/keep-the-api-key-out-of-the-table/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 22 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/22-report-and-api-pages/the-shipment-report-for-the-warehouse/README.md)
