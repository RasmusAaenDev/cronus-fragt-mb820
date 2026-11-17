# Step 17: One interface for every carrier

Cronus Fragt · MB-820 workbook · Build the solution › Carriers and the outbound API

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> We use two carriers today, but we're already talking to a third, and there will definitely be more. I don't
> want to pay to have everything redone every time we switch or get a new carrier. Can it be built so a new
> carrier can just be plugged in, without touching what works today?

## Your task

Create the interface CRF ICarrier with two procedures: GetRate, which returns the price of a shipment, and GetStatus, which returns the shipment's current CRF Shipment Status. Create one implementation per carrier, CRF Carrier A (codeunit 50101) and CRF Carrier B (codeunit 50102), with Access = Internal. Both read their price from CRF Carrier Rate (module 3b), but they don't have to calculate it the same way; for now GetStatus just returns the shipment's current status, and step 3 replaces it with a call to the carrier. Then change the enum CRF Carrier from module 3a, don't recreate it: make it implement CRF ICarrier and let each carrier value name its codeunit. Decide what the blank value " " does, because every value of an enum that implements an interface needs an implementation. Compile and publish.

## Checklist

- [ ] The interface CRF ICarrier declares GetRate and GetStatus, and both carrier codeunits implement it with the implements keyword.
- [ ] Enum 50100 CRF Carrier has implements "CRF ICarrier" and the Implementation property on Carrier A and Carrier B; its values and ordinals from module 3a are unchanged.
- [ ] The blank value has an implementation, through DefaultImplementation on the enum or Implementation on the value, and calling it gives a clear error instead of a price.
- [ ] Code that has a CRF Carrier value gets the implementation by assigning the enum to an Interface "CRF ICarrier" variable, without a case statement on the carrier.
- [ ] The extension compiles and publishes without errors.

## In this branch

- [Notes for this step](docs/steps/17-carrier-interface.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Changes since the previous step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/16-shipment/a-query-for-shipments-per-carrier...17-carriers-and-the-outbound-api/one-interface-for-every-carrier)
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/carrier-interface

---

[← Step 16](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/16-shipment/a-query-for-shipments-per-carrier/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 18 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/18-carriers-and-the-outbound-api/a-facade-codeunit/README.md)
