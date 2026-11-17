# Step 23: API pages for the webshop

Cronus Fragt · MB-820 workbook · Build the solution › Report and API pages

**[See what this step changed: diff against step 22](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/10b24b7ee3528dd7a2a8b29dc21cef7ef41cee27...0d53db0ed5618be264642b7e8cd9186ea3678c60)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> Our webshop needs to be able to create the shipments in Business Central itself when a customer has paid,
> instead of us keying them in from an email. The packages must come along in the same go, so there are no half
> shipments lying around. And the webshop must be able to look up how a shipment is doing, so the customers can
> see it on their page.

## Your task

Create two API pages that the webshop can call. CRF Shipment API (page 50105) exposes CRF Shipment Header as the entity shipment with the entity set shipments, and CRF Shipment Line API (page 50106) exposes CRF Shipment Line as shipmentLine with the set shipmentLines. Use the API publisher cronus, the group freight and the version v1.0, use SystemId as the OData key on both pages, expose lastModifiedDateTime, and keep the fields that the system sets (id, number, status, total weight) read-only. Put the lines on the header page as a part, so the webshop can create a shipment with its packages in one request and read them back with $expand. Add both pages to CRF Freight, publish, and create a shipment with two packages from a REST client.

## Checklist

- [ ] Pages 50105 and 50106 have PageType = API, APIPublisher cronus, APIGroup freight, APIVersion v1.0 and camelCase EntityName and EntitySetName values.
- [ ] Both pages set ODataKeyFields = SystemId, show SystemId as the field id with Editable = false, and show SystemModifiedAt as lastModifiedDateTime.
- [ ] CRF Shipment API has a part shipmentLines on CRF Shipment Line API with EntityName, EntitySetName and a SubPageLink from Shipment No. to the header's No.
- [ ] A POST to .../api/cronus/freight/v1.0/companies({id})/shipments with a shipmentLines array creates the header and both lines, and the header gets its number from the series.
- [ ] A GET with $expand=shipmentLines returns the shipment with its lines.

## In this branch

- [Notes for this step](docs/steps/23-api-pages.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/10b24b7ee3528dd7a2a8b29dc21cef7ef41cee27...0d53db0ed5618be264642b7e8cd9186ea3678c60): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/api-pages

---

[← Step 22](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/22-report-and-api-pages/the-shipment-report-for-the-warehouse/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 24 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/24-report-and-api-pages/an-odata-action-and-read-scale-out/README.md)
