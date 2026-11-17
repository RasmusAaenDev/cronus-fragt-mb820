# Step 27: Create a shipment when a sales shipment is posted

Cronus Fragt · MB-820 workbook · Build the solution › Link to standard Business Central

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> When the warehouse has packed an order, they post the delivery. That means Business Central records that the
> goods have been shipped, takes them out of inventory and creates a shipping document that can't be changed
> afterwards. Right there, the shipment should be created by itself, with the customer's address and regular
> carrier, so nobody has to key it in afterwards. The same delivery must never produce two shipments. And when
> people are just previewing the posting, nothing must be created.

## Your task

In CRF Sales Post Subs (codeunit 50104 from the phase 2 design), subscribe to the integration event OnAfterPostSalesDoc of codeunit 80 Sales-Post. When the posting created a posted sales shipment and isn't a preview, call a new public procedure CreateShipmentFromSalesShipment in CRF Freight Mgt that creates a CRF Shipment Header for the sell-to customer and stores the number of the posted sales shipment in a new field Sales Shipment No., and that does nothing when a shipment for that posted sales shipment already exists. At the end, raise Cronus Fragt's own integration event OnAfterCreateShipmentFromSalesShipment, which you publish in CRF Freight Mgt. Add the codeunit to CRF Freight, publish, post the shipment of a sales order for a customer with a default carrier, and find the new shipment in CRF Shipment List.

## Checklist

- [ ] Codeunit 50104 CRF Sales Post Subs has an EventSubscriber on Codeunit::"Sales-Post" and 'OnAfterPostSalesDoc' whose parameter names and types match the publisher.
- [ ] The subscriber exits when PreviewMode is true or SalesShptHdrNo is blank, and otherwise only calls CRF Freight Mgt.
- [ ] CRF Shipment Header has a Sales Shipment No. field, and CreateShipmentFromSalesShipment exits when a shipment with that number already exists.
- [ ] CRF Freight Mgt publishes OnAfterCreateShipmentFromSalesShipment as an integration event and raises it after the shipment is saved.
- [ ] Posting the shipment of a sales order creates a CRF shipment with the customer's address and default carrier, and no code in the base application was changed.

## In this branch

- [Notes for this step](docs/steps/27-shipment-event.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Changes since the previous step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/26-link-to-standard-business-central/give-customers-a-default-carrier...27-link-to-standard-business-central/create-a-shipment-when-a-sales-shipment-is-posted)
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/shipment-event

---

[← Step 26](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/26-link-to-standard-business-central/give-customers-a-default-carrier/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 28 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/28-link-to-standard-business-central/log-what-happens/README.md)
