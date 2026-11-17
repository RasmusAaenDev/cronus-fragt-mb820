# Step 13: Card, list and subform pages

Cronus Fragt · MB-820 workbook · Build the solution › Shipment

**[See what this step changed: diff against step 12](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/a834401bd58f66bd26a2bc00de64173abf03c786...c581d425cb5638f4f0c40be2027b96a6ecd5cf58)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> The warehouse needs to be able to see all shipments in a list, open a shipment and see the packages
> underneath, like on a sales order. I'd also like to see the total weight of the shipment without adding up the
> packages myself. And a package can't weigh zero or less, so the system should object to that.

## Your task

Create the pages for the shipment document. CRF Shipment List (page 50101) is a read-only list that opens CRF Shipment Card and can be found in search. CRF Shipment Card (page 50102) shows the header fields and, below them, the lines in CRF Shipment Subform (page 50103), a list part on CRF Shipment Line that numbers new lines by itself. Add a FlowField Total Weight to CRF Shipment Header that sums the weight of the shipment's lines, show it on the card and the list, and make it update when a line's weight changes. In CRF Shipment Line, reject a weight of zero or less with a clear error. Publish, create a shipment with two packages and show Mette the total weight.

## Checklist

- [ ] Page 50101 CRF Shipment List is a List page with CardPageId set to CRF Shipment Card, is not editable and is found in search.
- [ ] Page 50102 CRF Shipment Card has a part for CRF Shipment Subform with SubPageLink from Shipment No. to the header's No.
- [ ] Page 50103 CRF Shipment Subform is a ListPart that doesn't show Shipment No. or Line No. and numbers new lines automatically.
- [ ] Total Weight is a FlowField with CalcFormula = sum over the lines of the shipment, and it updates when a line's weight changes.
- [ ] Entering a weight of 0 or less on a line fails with an error that says the weight must be positive.

## In this branch

- [Notes for this step](docs/steps/13-shipment-pages.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/a834401bd58f66bd26a2bc00de64173abf03c786...c581d425cb5638f4f0c40be2027b96a6ecd5cf58): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/shipment-pages

---

[← Step 12](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/12-shipment/enums-and-number-series/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 14 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/14-shipment/permission-sets-and-entitlements/README.md)
