# Step 24: An OData action and read scale-out

Cronus Fragt · MB-820 workbook · Build the solution › Report and API pages

**[See what this step changed: diff against step 23](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/0d53db0ed5618be264642b7e8cd9186ea3678c60...eaca5e814811db5829879d79d2b2a91869ec0dc8)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> When the webshop has created a shipment, it should also be able to say "book it now" by itself, without anyone
> here having to go in and press anything. And the webshop asks about the shipments very often. The warehouse
> must not notice the system getting slow just because the webshop is constantly looking.

## Your task

Add a bound action bookShipment to CRF Shipment API that books an open shipment. Put the logic in a new public procedure BookShipment in CRF Freight Mgt: it accepts only shipments with status Open, gets the price through GetRate, so a shipment without a carrier or without a matching rate fails with the existing errors, and then sets Status to Booked. The fictional carrier service from module 3c defines no booking call, so booking doesn't send anything to the carrier. Then give the webshop's frequent status lookups their own read-only API page, CRF Shipment Status API (page 50109), with DataAccessIntent = ReadOnly, and find out on Learn what that property does and doesn't promise. Add the page to CRF Freight, publish, and book a test shipment with a POST from a REST client.

## Checklist

- [ ] CRF Shipment API has a [ServiceEnabled] procedure bookShipment(var ActionContext: WebServiceActionContext) that calls CRF Freight Mgt and sets a result code.
- [ ] BookShipment in CRF Freight Mgt rejects a shipment that isn't Open, fails with a clear error without a carrier or rate, and sets Status to Booked.
- [ ] A POST to .../shipments({id})/Microsoft.NAV.bookShipment books the test shipment, and a GET shows status Booked.
- [ ] Page 50109 CRF Shipment Status API has PageType = API, Editable = false and DataAccessIntent = ReadOnly, and a GET returns status and tracking number.
- [ ] The new page is in the CRF Freight Basic permission set.

## In this branch

- [Notes for this step](docs/steps/24-bound-action-and-scale-out.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/0d53db0ed5618be264642b7e8cd9186ea3678c60...eaca5e814811db5829879d79d2b2a91869ec0dc8): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/bound-action-and-scale-out

---

[← Step 23](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/23-report-and-api-pages/api-pages-for-the-webshop/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 25 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/25-report-and-api-pages/tell-the-webshop-when-a-shipment-changes/README.md)
