# Step 14: Card, list and subform pages

Cronus Fragt · MB-820 workbook · Build the solution › Shipment

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> The warehouse needs to be able to see all shipments in a list, with the shipping agent and the status, open
> a shipment and see the packages underneath, like on a sales order. I'd also like to see the total weight of
> the shipment without adding up the packages myself. And a package can't weigh zero or less, so the system
> should object to that.

## Your task

Create the pages for the shipment tracking document: a list, a card and a lines subform, plus a total weight that updates by itself.

**Do this**

1. Create CRF Shipment Tracking List (page 50101): a read-only list that shows No., Customer No., Shipping Agent Code, Status and Total Weight, opens CRF Shipment Tracking Card and can be found in search.
2. Create CRF Shipment Tracking Card (page 50102): it shows the header fields, including Shipping Agent Code and Package Tracking No., and, below them, the lines in CRF Shipment Tracking Subform (page 50103), a list part on CRF Shipment Tracking Line that numbers new lines by itself.
3. Add a FlowField Total Weight to CRF Shipment Tracking Header that sums the weight of the shipment's lines. Show it on the card and the list, and make it update when a line's weight changes.
4. In CRF Shipment Tracking Line, reject a weight of zero or less with a clear error.
5. Publish, create a shipment tracking record with two packages for a customer and show Mette the total weight and the shipping agent it got.

## Checklist

- [ ] Page 50101 CRF Shipment Tracking List is a List page with CardPageId set to CRF Shipment Tracking Card, shows Shipping Agent Code, is not editable and is found in search.
- [ ] Page 50102 CRF Shipment Tracking Card has a part for CRF Shipment Tracking Subform with SubPageLink from Document No. to the header's No.
- [ ] Page 50103 CRF Shipment Tracking Subform is a ListPart that doesn't show Document No. or Line No. and numbers new lines automatically.
- [ ] Total Weight is a FlowField with CalcFormula = sum over the lines of the shipment, and it updates when a line's weight changes.
- [ ] Entering a weight of 0 or less on a line fails with an error that says the weight must be positive.

## In this branch

- [Notes for this step](docs/steps/14-shipment-tracking-pages.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/shipment-pages

---

[← Step 13](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/13-shipment/extend-the-shipping-agent/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 15 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/15-shipment/permission-sets-and-entitlements/README.md)
