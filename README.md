# Step 8: Create the freight setup table

Cronus Fragt · MB-820 workbook · Build the solution › Setup and assisted setup

**[See what this step changed: diff against step 7](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/032acd4ede835266ed4c7fb264ed0ecc5b2c30d8...c79fed0bbb91939ac6a78bc8459ca3ced07e4c2f)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> Hi! We need one place where we decide which carrier we use by default, and where we store the address and the
> password for the carrier's system. The shipments also need their own running numbers, just like our orders
> have. And it should only exist once, so we don't suddenly end up with two different setups that people edit
> separately.

## Your task

Create the setup table CRF Freight Setup (table 50100) using the setup table pattern of Business Central. Give it a primary key field named Primary Key, a field for the default carrier, a field for the base URL of the carrier service and a field for the number series that numbers new shipments. The default carrier needs the enum CRF Carrier (50100) from your design: create it now with a blank value and one value per carrier, and module 3c makes it implement the CRF ICarrier interface. Do not add a field for the API key: tell Mette that the key is stored elsewhere and that module 3c covers it. Compile and publish the extension.

## Checklist

- [ ] Table 50100 CRF Freight Setup has a Primary Key field of type Code[10] and that field is the table's only key field.
- [ ] The table has fields for the default carrier (enum CRF Carrier), the API base URL and the shipment number series.
- [ ] The number series field has a table relation to the No. Series table.
- [ ] The table has no field for the API key.
- [ ] The extension compiles and publishes to the sandbox without errors.

## In this branch

- [Notes for this step](docs/steps/08-setup-table.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/032acd4ede835266ed4c7fb264ed0ecc5b2c30d8...c79fed0bbb91939ac6a78bc8459ca3ced07e4c2f): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/setup-table

---

[← Step 7](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/07-solution-design/sketch-the-architecture/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 9 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/09-setup-and-assisted-setup/create-the-setup-page-and-open-it-from-search/README.md)
