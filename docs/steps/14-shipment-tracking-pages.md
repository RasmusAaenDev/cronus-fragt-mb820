# Step 14: Card, list and subform pages

Delivers page 50101 `CRF Shipment Tracking List`, page 50102 `CRF Shipment Tracking Card` (a Document page) and page 50103 `CRF Shipment Tracking Subform` (ListPart), all in `app/src/Shipment/`. Adds the FlowField `Total Weight` (field 12) to `CRF Shipment Tracking Header` and the weight check to `CRF Shipment Tracking Line`.

| Checklist item | Where |
|---|---|
| List: `CardPageId`, shows Shipping Agent Code, not editable, in search | `CRFShipmentTrackingList.Page.al`: `CardPageId = "CRF Shipment Tracking Card"`, `Editable = false`, `UsageCategory = Lists`; the repeater has the field `Shipping Agent Code`. |
| Card with a part for the subform, `SubPageLink` from Document No. to the header's No. | `CRFShipmentTrackingCard.Page.al`: part `Lines`, `SubPageLink = "Document No." = field("No.")`, `UpdatePropagation = Both`. |
| Subform ListPart without Document No. and Line No., numbers lines itself | `CRFShipmentTrackingSubform.Page.al`: neither key field in the repeater, `AutoSplitKey = true`, `DelayedInsert = true`. |
| Total Weight is a FlowField summing the lines, updates on change | Header field 12, `CalcFormula = sum("CRF Shipment Tracking Line".Weight where("Document No." = field("No.")))`; `CurrPage.Update()` after Weight is validated on the subform. |
| Weight of 0 or less fails with a clear error | `OnValidate` on `Weight` in `CRFShipmentTrackingLine.Table.al`: "The weight of a package must be greater than zero." |

Choices: the card's Status is editable for now, because the facade that changes it comes in step 19; the Update Status action from the design arrives with the facade, not here. The weight error is a Label. Every field has a ToolTip. The card shows `Shipping Agent Code` as a plain field on the table's relation to the standard Shipping Agent table, so the lookup is the standard one. The shipment tracking pages do not carry any carrier-specific fields: the carrier is chosen on the shipping agent (step 13), not on the record.

A limit worth knowing: the weight check runs when Weight is validated, so a package line saved without ever touching Weight keeps weight 0. A check on insert would close that; it is outside this step's wording.

Compile: with the Business Central 28 compiler, 0 errors (`scripts/compile.sh app`). Not done: creating a shipment tracking record with two packages and reading the total weight in the web client (needs a sandbox). `docs/design/object-ids.md`: pages 50101-50103 built.

Design correction made in this step: `docs/design/01-object-list.md` called page 50102 a Card; a card with a lines part is a Document page, so the row now says Document (the id and name are unchanged).
