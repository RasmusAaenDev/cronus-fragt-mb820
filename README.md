# Step 27: Create shipment tracking when a sales shipment is posted

Cronus Fragt · MB-820 workbook · Build the solution › Link to standard Business Central

**[See what this step changed: diff against step 26](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/6c16001e6aee8c6547ae461e2eca7116933b7f90...0239a52684bc13da616add7499bb2acea687cfd6)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> When the warehouse has packed an order, they post the delivery. That means Business Central records that the
> goods have been shipped, takes them out of inventory and creates a shipping document that can't be changed
> afterwards. Right there, the shipment tracking should be created by itself, with the customer's address and
> the shipping agent we chose for the order, so nobody has to key it in afterwards. The same delivery must
> never get two. When people are just previewing the posting, nothing must be created. And the posting must
> never stop because of the freight: in a company where the freight isn't set up yet, the delivery is posted
> as usual.

## Your task

Create a shipment tracking record automatically when a sales shipment is posted, by subscribing to the posting event and handing over to the facade.

**Do this**

1. In CRF Sales Post Subs (codeunit 50104 from the phase 2 design), subscribe to the integration event OnAfterPostSalesDoc of codeunit 80 Sales-Post.
2. When the posting created a posted sales shipment and isn't a preview, call a new public procedure CreateTrackingFromSalesShipment in CRF Freight Mgt.
3. That procedure creates a CRF Shipment Tracking Header for the sell-to customer and stores the number of the posted sales shipment in a new field Sales Shipment No. It does nothing when a record for that posted sales shipment already exists, or when CRF Freight Setup has no Shipment Tracking Nos.
4. Give the record the shipping agent of the order: the Shipping Agent Code of the posted Sales Shipment Header. When that is blank, keep the shipping agent that validating Customer No. already gave the record (the customer's own, or else the default of CRF Freight Setup, as in step 11).
5. At the end, raise Cronus Fragt's own integration event OnAfterCreateTrackingFromSalesShipment, which you publish in CRF Freight Mgt.
6. Add the codeunit to CRF Freight Basic and publish.
7. Post the shipment of a sales order with shipping agent DHL and find the new record, with DHL, in CRF Shipment Tracking List. Then post one for a customer whose order has no shipping agent and check which one the record got.

## Checklist

- [ ] Codeunit 50104 CRF Sales Post Subs has an EventSubscriber on Codeunit::"Sales-Post" and 'OnAfterPostSalesDoc' whose parameter names and types match the publisher.
- [ ] The subscriber exits when PreviewMode is true or SalesShptHdrNo is blank, and otherwise only calls CRF Freight Mgt.
- [ ] CRF Shipment Tracking Header has a Sales Shipment No. field, and CreateTrackingFromSalesShipment exits when a record with that number already exists or when CRF Freight Setup has no Shipment Tracking Nos.
- [ ] The new record takes Shipping Agent Code from the posted Sales Shipment Header, and when that is blank keeps the one that validating Customer No. gave it (the customer's, or else the setup default from step 11).
- [ ] CRF Freight Mgt publishes OnAfterCreateTrackingFromSalesShipment as an integration event and raises it after the record is saved.
- [ ] Posting the shipment of a sales order creates a shipment tracking record with the customer's address and the shipping agent of the order, and no code in the base application was changed.

## In this branch

- [Notes for this step](docs/steps/27-tracking-from-sales-shipment.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/6c16001e6aee8c6547ae461e2eca7116933b7f90...0239a52684bc13da616add7499bb2acea687cfd6): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/shipment-event

---

[← Step 26](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/26-report-and-api-pages/tell-the-webshop-when-the-tracking-status-changes/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 28 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/28-link-to-standard-business-central/log-what-happens/README.md)
