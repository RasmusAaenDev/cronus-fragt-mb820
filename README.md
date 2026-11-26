# Step 8: Create the freight setup table

Cronus Fragt · MB-820 workbook · Build the solution › Setup and assisted setup

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> Hi! We need one place where we decide which shipping agent we use when a customer hasn't got one of its own.
> The shipment tracking records also need their own running numbers, just like our orders have. And it should
> only exist once, so we don't suddenly end up with two different setups that people edit separately.

## Your task

Mette needs one place for the default shipping agent and the numbering of shipment tracking records. Create the setup table CRF Freight Setup (table 50100) using the setup table pattern of Business Central.

**Do this**

1. Create table 50100 CRF Freight Setup with a primary key field named Primary Key, a field Default Shipping Agent Code related to the standard Shipping Agent table, and a field Shipment Tracking Nos. for the number series that numbers new shipment tracking records.
2. Don't add the carrier, the address of the carrier service or the API key here. They belong to each shipping agent: step 13 adds the carrier and the address to the Shipping Agent table, and step 21 stores the key. Tell Mette why.
3. Compile and publish the extension.

## Checklist

- [ ] Table 50100 CRF Freight Setup has a Primary Key field of type Code[10] and that field is the table's only key field.
- [ ] The table has the fields Default Shipping Agent Code and Shipment Tracking Nos., and nothing about carriers, addresses or keys.
- [ ] Default Shipping Agent Code is Code[10] with a table relation to the Shipping Agent table.
- [ ] Shipment Tracking Nos. is Code[20] with a table relation to the No. Series table.
- [ ] The extension compiles and publishes to the sandbox without errors.

## In this branch

- [Notes for this step](docs/steps/08-setup-table.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/setup-table

---

[← Step 7](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/07-solution-design/sketch-the-architecture/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 9 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/09-setup-and-assisted-setup/create-the-setup-page-and-open-it-from-search/README.md)
