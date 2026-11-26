# Step 23: The freight list for the warehouse

Cronus Fragt · MB-820 workbook · Build the solution › Report and API pages

**[See what this step changed: diff against step 22](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/8cbbf5c9136447e59de719f2a3c5e011bbd61813...419d0b10429d76d9a2c7e9eaa672f83ebe1ea499)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> The warehouse would like a paper list every morning of the shipments that need to go out, with the packages
> under each shipment, so they can tick them off while they pack. They should be able to choose for themselves
> whether the list shows only the open shipments or also the booked ones, and whether the packages are
> included. And if we want our logo on it one day or want to move things around, it mustn't become a big
> project.

## Your task

Create the freight list for the warehouse, a printable list of shipment tracking records with their packages.

**Do this**

1. Create the report CRF Warehouse Freight List (report 50100). Don't call it a warehouse shipment list: Warehouse Shipment is already a document in Business Central.
2. Its dataset has a data item on CRF Shipment Tracking Header with the number, customer, ship-to address, shipping agent code, status, package tracking number and total weight.
3. Add an indented data item on CRF Shipment Tracking Line with the description, weight and dimensions of each package, linked to its header.
4. Let users filter on status and shipping agent on the request page, and add an option Show Packages that decides whether the lines are printed.
5. Give the report a layout type that Learn describes for reports that are printed and whose look Cronus may want to adjust later, make it the default layout, and make the report searchable.
6. Add the report to CRF Freight Basic, publish and print the list for the open records.

## Checklist

- [ ] Report 50100 CRF Warehouse Freight List has a CRF Shipment Tracking Header data item with an indented CRF Shipment Tracking Line data item, linked with DataItemLink on Document No.
- [ ] The header data item has RequestFilterFields for Status and Shipping Agent Code, and the request page has a Show Packages option that skips the lines when it's off.
- [ ] The rendering section declares a Word layout that DefaultRenderingLayout names, and the generated .docx shows each record with its packages repeated below it.
- [ ] The report sets UsageCategory and ApplicationArea, is found in search and is in the CRF Freight Basic permission set.
- [ ] Running the report with Status = Open prints only open records, each with its packages.

## In this branch

- [Notes for this step](docs/steps/23-freight-list-report.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/8cbbf5c9136447e59de719f2a3c5e011bbd61813...419d0b10429d76d9a2c7e9eaa672f83ebe1ea499): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/shipment-report

---

[← Step 22](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/22-carriers-and-the-outbound-api/update-the-tracking-status-from-the-carrier/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 24 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/24-report-and-api-pages/api-pages-for-the-webshop/README.md)
