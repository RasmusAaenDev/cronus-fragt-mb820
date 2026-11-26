# Step 18: One interface for every carrier

Cronus Fragt · MB-820 workbook · Build the solution › Carriers and the outbound API

**[See what this step changed: diff against step 17](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/28f743178b3d46ac7a4cfbf75853ff756389b6a9...1efd9f5236748777c8aca93c5bc1237ad3d68c2b)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> Two of our shipping agents have a system we can talk to today, and we're already talking to a third, and
> there will definitely be more. I don't want to pay to have everything redone every time we switch or get a
> new one. Can it be built so a new one can just be plugged in, without touching what works today?

## Your task

Make it possible to add carriers without changing existing code: create an interface for carriers, one implementation per carrier, and connect them to the carrier enum that each shipping agent points to.

**Do this**

1. Create the interface CRF ICarrier with two procedures that both take the shipment tracking header record: GetRate, which returns the price of the shipment, and GetStatus, which returns its current CRF Tracking Status.
2. Create one implementation per carrier, CRF Carrier A (codeunit 50101) and CRF Carrier B (codeunit 50102), with Access = Internal.
3. Both read their price from CRF Shipping Agent Rate (step 16), filtered on the Shipping Agent Code of the record, but they don't have to calculate it the same way. For now GetStatus just returns the record's current status; step 20 replaces it in Carrier A with a call to the carrier's service.
4. Change the enum CRF Carrier from step 13, don't recreate it: make it implement CRF ICarrier and let each carrier value name its codeunit. The field CRF Carrier on the Shipping Agent table keeps using it.
5. Decide what the blank value " " does, because every value of an enum that implements an interface needs an implementation.
6. Compile and publish.

## Checklist

- [ ] The interface CRF ICarrier declares GetRate and GetStatus with a CRF Shipment Tracking Header parameter, and both carrier codeunits implement it with the implements keyword.
- [ ] Enum 50100 CRF Carrier has implements "CRF ICarrier" and the Implementation property on Carrier A and Carrier B; its values and ordinals from step 13 are unchanged.
- [ ] Both carriers filter CRF Shipping Agent Rate on the Shipping Agent Code of the record, so two shipping agents that use the same carrier keep their own prices.
- [ ] The blank value has an implementation, through DefaultImplementation on the enum or Implementation on the value, and calling it gives a clear error instead of a price.
- [ ] Code that has a shipping agent gets the implementation by assigning the agent's CRF Carrier value to an Interface "CRF ICarrier" variable, without a case statement on the carrier.
- [ ] The extension compiles and publishes without errors.

## In this branch

- [Notes for this step](docs/steps/18-carrier-interface.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/28f743178b3d46ac7a4cfbf75853ff756389b6a9...1efd9f5236748777c8aca93c5bc1237ad3d68c2b): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/carrier-interface

---

[← Step 17](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/17-shipment/a-query-for-shipment-tracking-per-shipping-agent/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 19 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/19-carriers-and-the-outbound-api/a-facade-codeunit/README.md)
