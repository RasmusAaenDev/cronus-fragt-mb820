# Step 11: Create the shipment tables

Cronus Fragt · MB-820 workbook · Build the solution › Shipment

**[See what this step changed: diff against step 10](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/017985cc48132aa15bf6a5be625d8921b4d36466...156acdbf41bc75d8c0235f42eae97d8851c53ab0)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> Now we need the shipments themselves. A shipment goes to one customer and needs the delivery address, the
> carrier, a status, the tracking number and a date. A shipment can consist of several packages, and for each
> package we need to know the weight and the dimensions, otherwise the carrier won't accept it.

## Your task

Build the shipment as a document, the way Business Central builds sales orders: a header table and a line table. Create CRF Shipment Header (table 50101) with No., Customer No. (related to Customer), Ship-to Name, Ship-to Address, Ship-to City, Ship-to Post Code, Carrier (enum CRF Carrier from module 3a), Status (enum CRF Shipment Status, 50101), Tracking No. and Posting Date. Create the status enum now with only the value Open, so the table compiles; the next step finishes it. When a user picks a customer, copy the customer's name and address into the ship-to fields. Create CRF Shipment Line (table 50102) with Shipment No. (related to the header), Line No., Description, Weight and Length, Width and Height, one line per package. Deleting a shipment must delete its lines. Compile and publish.

## Checklist

- [ ] Table 50101 CRF Shipment Header has the listed fields, and No. is its primary key.
- [ ] Customer No. has a table relation to Customer, and validating it fills the ship-to name and address.
- [ ] Table 50102 CRF Shipment Line has a Shipment No. field with a table relation to CRF Shipment Header and a Line No. field.
- [ ] Deleting a shipment header also deletes its lines.
- [ ] The extension compiles and publishes to the sandbox without errors.

## In this branch

- [Notes for this step](docs/steps/11-shipment-tables.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/017985cc48132aa15bf6a5be625d8921b4d36466...156acdbf41bc75d8c0235f42eae97d8851c53ab0): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/shipment-tables

---

[← Step 10](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/10-setup-and-assisted-setup/add-an-assisted-setup-guide/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 12 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/12-shipment/enums-and-number-series/README.md)
