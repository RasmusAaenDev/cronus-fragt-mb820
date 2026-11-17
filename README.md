# Step 18: A facade codeunit

Cronus Fragt · MB-820 workbook · Build the solution › Carriers and the outbound API

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> When the warehouse presses a button to get the latest status on a shipment, the system must know by itself
> which carrier to ask. And if something goes wrong, I want a message the warehouse can understand, not a long
> technical text they have to call you about. If you need the details, they're welcome to sit behind it.

## Your task

Create CRF Freight Mgt (codeunit 50100) as the one public entry point to the carriers. Give it GetRate, which returns the price of a shipment from its carrier, and UpdateStatus(var ShipmentHeader: Record "CRF Shipment Header"), which asks the shipment's carrier for the status and saves it on the shipment when it has changed. The carrier call must be wrapped so that an error from the carrier is caught: offer a second procedure that returns false and the error text instead of stopping, which the job queue codeunit in step 5 will use, and let UpdateStatus raise one clear error built with ErrorInfo, with a message for the warehouse and the technical details in the detailed message. Keep database writes out of the part that can fail. Add an Update Status action to CRF Shipment Card that calls UpdateStatus, and add the codeunit to CRF Freight.

## Checklist

- [ ] Codeunit 50100 CRF Freight Mgt has Access = Public and gets the carrier implementation from the shipment's Carrier field through the CRF ICarrier interface.
- [ ] The call to GetStatus sits in a local procedure with the [TryFunction] attribute that doesn't write to the database, and the caller uses its return value.
- [ ] UpdateStatus raises one error through an ErrorInfo with Message and DetailedMessage, using GetLastErrorText for the details.
- [ ] The non-failing variant returns false and the error text, and the status is modified only after the carrier call succeeded.
- [ ] Running Update Status on a shipment without a carrier shows the facade's ErrorInfo message, with the error from CRF No Carrier in the details.

## In this branch

- [Notes for this step](docs/steps/18-carrier-facade.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Changes since the previous step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/17-carriers-and-the-outbound-api/one-interface-for-every-carrier...18-carriers-and-the-outbound-api/a-facade-codeunit)
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/carrier-facade

---

[← Step 17](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/17-carriers-and-the-outbound-api/one-interface-for-every-carrier/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 19 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/19-carriers-and-the-outbound-api/call-the-carrier-s-service/README.md)
