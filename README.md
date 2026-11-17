# Step 12: Enums and number series

Cronus Fragt · MB-820 workbook · Build the solution › Shipment

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> We need to be able to follow where a shipment is: whether it's just been created, booked with the carrier, in
> transit or delivered. There will probably be more steps later, for example if a package is sent back. And when
> someone creates a shipment, it should get the next number by itself from the number series we picked in the
> freight setup.

## Your task

Finish the enum CRF Shipment Status (50101): the values Open, Booked, In Transit and Delivered with captions, and make it extensible so another extension can add a status later. Then give CRF Shipment Header its number series with the No. Series pattern: add a No. Series field, fill No. from the Shipment Nos. series in CRF Freight Setup when a shipment is inserted without a number, check in No.'s OnValidate that the series allows manual numbers, and set Posting Date to the work date when it's blank. In the sandbox, create a number series for shipments on the No. Series page and choose it on the CRF Freight Setup page. Insert a shipment from code or wait for the pages in the next step, and check that it gets the next number.

## Checklist

- [ ] Enum 50101 CRF Shipment Status has Extensible = true and the values Open, Booked, In Transit and Delivered.
- [ ] CRF Shipment Header has a No. Series field of type Code[20] with a table relation to No. Series, and users can't edit it.
- [ ] OnInsert gets the next number from the series in CRF Freight Setup through codeunit No. Series, only when No. is blank.
- [ ] Typing a number by hand fails unless the series has Manual Nos. turned on.
- [ ] A new shipment gets the next number from the series you set up in the sandbox.

## In this branch

- [Notes for this step](docs/steps/12-enums-and-numbers.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Changes since the previous step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/11-shipment/create-the-shipment-tables...12-shipment/enums-and-number-series)
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/enums-and-numbers

---

[← Step 11](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/11-shipment/create-the-shipment-tables/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 13 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/13-shipment/card-list-and-subform-pages/README.md)
