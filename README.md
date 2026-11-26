# Step 19: A facade codeunit

Cronus Fragt · MB-820 workbook · Build the solution › Carriers and the outbound API

**[See what this step changed: diff against step 18](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/1efd9f5236748777c8aca93c5bc1237ad3d68c2b...4a06cc171b5c1f811f6f5a59d8f6bb6a16194151)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> When the warehouse presses a button to get the latest status on a shipment, the system must know by itself
> which shipping agent to ask, and how. And if something goes wrong, I want a message the warehouse can
> understand, not a long technical text they have to call you about. If you need the details, they're welcome
> to sit behind it.

## Your task

Create one public entry point to the carriers, a facade codeunit, that finds the carrier through the shipping agent and handles carrier errors cleanly.

**Do this**

1. Create CRF Freight Mgt (codeunit 50100) as the one public entry point to the carriers.
2. Give it GetCarrier, which takes a shipment tracking record, looks up its shipping agent in the Shipping Agent table and returns the CRF ICarrier implementation of the agent's CRF Carrier field. A record without a shipping agent gets a clear error that says so.
3. Give it GetRate, which returns the price of the shipment from that carrier.
4. Give it UpdateStatus(var TrackingHeader: Record "CRF Shipment Tracking Header"), which asks the carrier for the status and saves it on the record when it has changed.
5. Wrap the carrier lookup and the carrier call so that an error is caught: offer a second procedure, UpdateStatusNoError, that returns false and the error text instead of stopping, which the job queue codeunit in step 22 will use.
6. Let UpdateStatus raise one clear error built with ErrorInfo, with a message for the warehouse and the technical details in the detailed message.
7. Keep database writes out of the part that can fail.
8. Add an Update Status action to CRF Shipment Tracking Card (page 50102) that calls UpdateStatus, and add the codeunit to CRF Freight Basic.

## Checklist

- [ ] Codeunit 50100 CRF Freight Mgt has Access = Public, and its GetCarrier reads the record's shipping agent and returns the agent's CRF Carrier value as an Interface "CRF ICarrier".
- [ ] GetCarrier raises an error that names the shipment tracking record when its Shipping Agent Code is blank.
- [ ] The call to GetCarrier and the call to GetStatus sit in a local procedure with the [TryFunction] attribute that doesn't write to the database, and the caller uses its return value.
- [ ] UpdateStatus raises one error through an ErrorInfo with Message and DetailedMessage, using GetLastErrorText for the details.
- [ ] The non-failing variant returns false and the error text, and the status is modified only after the carrier call succeeded.
- [ ] Running Update Status on a record whose shipping agent has a blank Carrier shows the facade's ErrorInfo message, with the error from CRF No Carrier in the details.

## In this branch

- [Notes for this step](docs/steps/19-carrier-facade.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/1efd9f5236748777c8aca93c5bc1237ad3d68c2b...4a06cc171b5c1f811f6f5a59d8f6bb6a16194151): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/carrier-facade

---

[← Step 18](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/18-carriers-and-the-outbound-api/one-interface-for-every-carrier/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 20 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/20-carriers-and-the-outbound-api/call-the-carrier-s-service/README.md)
