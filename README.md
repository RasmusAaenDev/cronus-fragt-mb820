# Step 24: API pages for the webshop

Cronus Fragt · MB-820 workbook · Build the solution › Report and API pages

**[See what this step changed: diff against step 23](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/419d0b10429d76d9a2c7e9eaa672f83ebe1ea499...58ebd06aa30dcd65b1b9f1030a5d6f86ea561016)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> Our webshop needs to be able to register the shipments in Business Central itself when a customer has paid,
> instead of us keying them in from an email. The packages must come along in the same go, so there are no
> half shipments lying around. And the webshop must be able to look up how a shipment is doing, so the
> customers can see it on their page.

## Your task

Create two API pages that the webshop can call, so that it can create a shipment tracking record with its packages in one request and read them back.

**Do this**

1. Create CRF Shipment Tracking API (page 50105) that exposes CRF Shipment Tracking Header as the entity shipmentTracking with the entity set shipmentTrackings.
2. Create CRF Shipment Tracking Line API (page 50106) that exposes CRF Shipment Tracking Line as shipmentTrackingLine with the set shipmentTrackingLines.
3. Use the API publisher cronus, the group freight and the version v1.0, use SystemId as the OData key on both pages, and expose lastModifiedDateTime.
4. Expose the shipping agent as shippingAgentCode and the Package Tracking No. as trackingNumber, and keep the fields that the system sets (id, number, status, total weight) read-only.
5. Put the lines on the header page as a part, so the webshop can create a record with its packages in one request and read them back with $expand.
6. Add both pages to CRF Freight Basic, publish, and create a record with two packages from a REST client.
7. A ready-made set of requests (token, create with lines, read back with $expand, book) is in the repository SekvensApS/Sekvens-CertPractice-MockApi, file docs/bc-api-requests.http. Business Central checks real Microsoft Entra tokens, so these go to your own sandbox.

## Checklist

- [ ] Pages 50105 and 50106 have PageType = API, APIPublisher cronus, APIGroup freight, APIVersion v1.0 and camelCase EntityName and EntitySetName values.
- [ ] Both pages set ODataKeyFields = SystemId, show SystemId as the field id with Editable = false, and show SystemModifiedAt as lastModifiedDateTime.
- [ ] CRF Shipment Tracking API has a part shipmentTrackingLines on CRF Shipment Tracking Line API with EntityName, EntitySetName and a SubPageLink from Document No. to the header's No.
- [ ] A POST to .../api/cronus/freight/v1.0/companies({id})/shipmentTrackings with a shipmentTrackingLines array creates the header and both lines, and the header gets its number from the series and its shipping agent from the customer unless the request sends shippingAgentCode.
- [ ] A GET with $expand=shipmentTrackingLines returns the record with its lines.

## In this branch

- [Notes for this step](docs/steps/24-api-pages.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/419d0b10429d76d9a2c7e9eaa672f83ebe1ea499...58ebd06aa30dcd65b1b9f1030a5d6f86ea561016): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/api-pages

---

[← Step 23](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/23-report-and-api-pages/the-freight-list-for-the-warehouse/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 25 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/25-report-and-api-pages/an-odata-action-and-read-scale-out/README.md)
