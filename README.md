# Step 25: An OData action and read scale-out

Cronus Fragt · MB-820 workbook · Build the solution › Report and API pages

**[See what this step changed: diff against step 24](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/58ebd06aa30dcd65b1b9f1030a5d6f86ea561016...bf19057565fa848aad1aa01059e0e0824b26d254)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> When the webshop has registered a shipment, it should also be able to say "book it now" by itself, without
> anyone here having to go in and press anything. And the webshop asks about the shipments very often. The
> warehouse must not notice the system getting slow just because the webshop is constantly looking.

## Your task

Add a bound action that books an open shipment tracking record, and give the webshop's frequent status lookups their own read-only API page.

**Do this**

1. Add a bound action book to CRF Shipment Tracking API that books an open record.
2. Put the logic in a new public procedure Book in CRF Freight Mgt: it accepts only records with status Open, gets the price through GetRate, so a record without a shipping agent, a shipping agent without a carrier or a missing rate fails with the existing errors, and then sets Status to Booked.
3. Booking doesn't send anything to the carrier, because the fictional carrier service from module 3c defines no booking call.
4. Give the status lookups their own read-only API page, CRF Tracking Status API (page 50109), with the entity trackingStatus, the entity set trackingStatuses and DataAccessIntent = ReadOnly.
5. Find out on Learn what that property does and doesn't promise.
6. Add the page to CRF Freight Basic, publish, and book a test record with a POST from a REST client.

## Checklist

- [ ] CRF Shipment Tracking API has a [ServiceEnabled] procedure book(var ActionContext: WebServiceActionContext) that calls CRF Freight Mgt and sets a result code.
- [ ] Book in CRF Freight Mgt rejects a record that isn't Open, fails with a clear error without a shipping agent, carrier or rate, and sets Status to Booked.
- [ ] A POST to .../shipmentTrackings({id})/Microsoft.NAV.book books the test record, and a GET shows status Booked.
- [ ] Page 50109 CRF Tracking Status API has PageType = API, Editable = false and DataAccessIntent = ReadOnly, and a GET on trackingStatuses returns the status, the shipping agent code and the tracking number.
- [ ] The new page is in the CRF Freight Basic permission set.

## In this branch

- [Notes for this step](docs/steps/25-bound-action-and-scale-out.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/58ebd06aa30dcd65b1b9f1030a5d6f86ea561016...bf19057565fa848aad1aa01059e0e0824b26d254): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/bound-action-and-scale-out

---

[← Step 24](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/24-report-and-api-pages/api-pages-for-the-webshop/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 26 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/26-report-and-api-pages/tell-the-webshop-when-the-tracking-status-changes/README.md)
