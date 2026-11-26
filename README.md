# Step 12: Enums and number series

Cronus Fragt · MB-820 workbook · Build the solution › Shipment

**[See what this step changed: diff against step 11](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/5337abfa822b62764c2a3f2132f009279378d812...ba2976ce046edc763582491f9ec8eee724ab4ba5)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> We need to be able to follow where a shipment is: whether it's just been created, booked with the carrier,
> in transit or delivered. There will probably be more steps later, for example if a package is sent back. And
> when someone creates a shipment tracking record, it should get the next number by itself from the number
> series we picked in the freight setup.

## Your task

Finish the tracking status enum and give the shipment tracking header its number series with the No. Series pattern, so that every new shipment tracking record gets the next number.

**Do this**

1. Finish the enum CRF Tracking Status (50101): the values Open, Booked, In Transit and Delivered with captions, and make it extensible so another extension can add a status later.
2. Give CRF Shipment Tracking Header its number series: add a No. Series field and fill No. from the Shipment Tracking Nos. series in CRF Freight Setup when a record is inserted without a number.
3. Check in No.'s OnValidate that the series allows manual numbers.
4. Set Posting Date to the work date when it's blank.
5. In the sandbox, create a number series for shipment tracking on the No. Series page and choose it on the CRF Freight Setup page.

**You are done when**

- A shipment tracking record inserted from code (or through the pages in step 14) gets the next number.

## Checklist

- [ ] Enum 50101 CRF Tracking Status has Extensible = true and the values Open, Booked, In Transit and Delivered.
- [ ] CRF Shipment Tracking Header has a No. Series field of type Code[20] with a table relation to No. Series, and users can't edit it.
- [ ] OnInsert gets the next number from the series in CRF Freight Setup through codeunit No. Series, only when No. is blank.
- [ ] Typing a number by hand fails unless the series has Manual Nos. turned on.
- [ ] A new shipment tracking record gets the next number from the series you set up in the sandbox.

## In this branch

- [Notes for this step](docs/steps/12-enums-and-numbers.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/5337abfa822b62764c2a3f2132f009279378d812...ba2976ce046edc763582491f9ec8eee724ab4ba5): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/enums-and-numbers

---

[← Step 11](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/11-shipment/create-the-shipment-tracking-tables/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 13 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/13-shipment/extend-the-shipping-agent/README.md)
