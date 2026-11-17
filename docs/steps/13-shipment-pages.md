# Step 13: Card, list and subform pages

Delivers page 50101 `CRF Shipment List`, page 50102 `CRF Shipment Card` (a Document page) and page 50103 `CRF Shipment Subform` (ListPart), all in `app/src/Shipment/`. Adds the FlowField `Total Weight` (field 12) to `CRF Shipment Header` and the weight check to `CRF Shipment Line`.

| Checklist item | Where |
|---|---|
| List: `CardPageId`, not editable, in search | `CRFShipmentList.Page.al`: `CardPageId = "CRF Shipment Card"`, `Editable = false`, `UsageCategory = Lists`. |
| Card with a part for the subform, `SubPageLink` | `CRFShipmentCard.Page.al`: part `Lines`, `SubPageLink = "Shipment No." = field("No.")`, `UpdatePropagation = Both`. |
| Subform ListPart without Shipment No. and Line No., numbers lines itself | `CRFShipmentSubform.Page.al`: neither key field in the repeater, `AutoSplitKey = true`, `DelayedInsert = true`. |
| Total Weight is a FlowField summing the lines, updates on change | Header field 12, `CalcFormula = sum(...)`; `CurrPage.Update()` after Weight is validated on the subform. |
| Weight of 0 or less fails with a clear error | `OnValidate` on `Weight` in the line table: "The weight of a package must be greater than zero." |

Choices: the card's Status is editable for now, because the facade that changes it comes in step 18; the Update Status action from the design arrives with the facade, not here. The weight error is a Label. Every field has a ToolTip.

A limit worth knowing: the weight check runs when Weight is validated, so a package line saved without ever touching Weight keeps weight 0. A check on insert would close that; it is outside this step's wording.

Compile: `scripts/compile.sh app` 0 errors. Not done: creating a shipment with two packages and reading the total weight in the web client (needs a sandbox). `object-ids.md`: pages 50101-50103 built.
