# Step 22: The shipment report for the warehouse

Cronus Fragt · MB-820 workbook · Build the solution › Report and API pages

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> The warehouse would like a paper list every morning of the shipments that need to go out, with the packages
> under each shipment, so they can tick them off while they pack. They should be able to choose for themselves
> whether the list shows only the open shipments or also the booked ones, and whether the packages are included.
> And if we want our logo on it one day or want to move things around, it mustn't become a big project.

## Your task

Create the report CRF Warehouse Shipment List (report 50100) for the warehouse. Its dataset has a data item on CRF Shipment Header with the shipment number, customer, ship-to address, carrier, status, tracking number and total weight, and an indented data item on CRF Shipment Line with the description, weight and dimensions of each package, linked to its header. Users filter on status and carrier on the request page, and an option Show Packages decides whether the lines are printed. Give the report a layout type that Learn describes for reports that are printed and whose look Cronus may want to adjust later, make it the default layout, and make the report searchable. Add the report to CRF Freight, publish and print the list for the open shipments.

## Checklist

- [ ] Report 50100 CRF Warehouse Shipment List has a CRF Shipment Header data item with an indented CRF Shipment Line data item, linked with DataItemLink on Shipment No.
- [ ] The header data item has RequestFilterFields for Status and Carrier, and the request page has a Show Packages option that skips the lines when it's off.
- [ ] The rendering section declares a Word layout that DefaultRenderingLayout names, and the generated .docx shows each shipment with its packages repeated below it.
- [ ] The report sets UsageCategory and ApplicationArea, is found in search and is in the CRF Freight permission set.
- [ ] Running the report with Status = Open prints only open shipments, each with its packages.

## In this branch

- [Notes for this step](docs/steps/22-warehouse-report.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Changes since the previous step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/21-carriers-and-the-outbound-api/update-shipment-status-from-the-carrier...22-report-and-api-pages/the-shipment-report-for-the-warehouse)
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/shipment-report

---

[← Step 21](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/21-carriers-and-the-outbound-api/update-shipment-status-from-the-carrier/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 23 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/23-report-and-api-pages/api-pages-for-the-webshop/README.md)
