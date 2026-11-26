# Step 11: Create the shipment tracking tables

Cronus Fragt · MB-820 workbook · Build the solution › Shipment

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> Now we need to keep track of the shipments themselves. A shipment goes to one customer and needs the
> delivery address, the shipping agent, a status, the package tracking number and a date. A shipment can
> consist of several packages, and for each package we need to know the weight and the dimensions, otherwise
> the carrier won't accept it.

## Your task

Build shipment tracking as a document, the way Business Central builds sales orders: a header table and a line table.

**Do this**

1. Create CRF Shipment Tracking Header (table 50101) with No., Customer No. (related to Customer), Ship-to Name, Ship-to Address, Ship-to City, Ship-to Post Code, Shipping Agent Code (related to the standard Shipping Agent table), Status (enum CRF Tracking Status, 50101), Package Tracking No. and Posting Date.
2. Create the status enum now with only the value Open, so the table compiles. The next step finishes it.
3. When a user picks a customer, copy the customer's name and address into the ship-to fields, and take the customer's standard Shipping Agent Code. If the customer has none, use Default Shipping Agent Code from CRF Freight Setup.
4. Create CRF Shipment Tracking Line (table 50102) with Document No. (related to the header), Line No., Description, Weight and Length, Width and Height, one line per package.
5. Make sure deleting a shipment tracking record deletes its lines.
6. Compile and publish.

## Checklist

- [ ] Table 50101 CRF Shipment Tracking Header has the listed fields, and No. is its primary key.
- [ ] Shipping Agent Code is Code[10] with a table relation to the standard Shipping Agent table; the header has no carrier field of its own.
- [ ] Customer No. has a table relation to Customer, and validating it fills the ship-to name and address and the shipping agent (the customer's, else the setup's default).
- [ ] Table 50102 CRF Shipment Tracking Line has a Document No. field with a table relation to CRF Shipment Tracking Header and a Line No. field.
- [ ] Deleting a shipment tracking header also deletes its lines.
- [ ] The extension compiles and publishes to the sandbox without errors.

## In this branch

- [Notes for this step](docs/steps/11-shipment-tracking-tables.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/shipment-tables

---

[← Step 10](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/10-setup-and-assisted-setup/add-an-assisted-setup-guide/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 12 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/12-shipment/enums-and-number-series/README.md)
