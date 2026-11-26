# Step 27: Create shipment tracking when a sales shipment is posted

Posting a sales shipment now creates a CRF shipment tracking record without touching base code. The record gets the shipping agent of the posted sales shipment.

- `app/src/Freight/CRFSalesPostSubs.Codeunit.al`: codeunit 50104 (`Access = Internal`), subscriber `CreateTrackingOnAfterPostSalesDoc` on `Sales-Post` `OnAfterPostSalesDoc`.
- `app/src/Freight/CRFFreightMgt.Codeunit.al`: public `CreateTrackingFromSalesShipment` and the integration event `OnAfterCreateTrackingFromSalesShipment`.
- `app/src/Shipment/CRFShipmentTrackingHeader.Table.al`: field 13 `Sales Shipment No.` (relation to `Sales Shipment Header`, key `SalesShipment` for the duplicate check); shown on `CRFShipmentTrackingCard.Page.al`.
- `app/src/Permissions/CRFFreightBasic.PermissionSet.al`: `codeunit "CRF Sales Post Subs" = X` and `tabledata "Sales Shipment Header" = R` added.

| Checklist item | Where |
|---|---|
| Subscriber with matching parameter names and types | The signature compiles against BC 28 (AL0282/AL0284 would flag any mismatch). It is the one listed in `docs/design/03-events.md`. |
| Exits on `PreviewMode` or blank `SalesShptHdrNo`, otherwise only calls Freight Mgt | `CreateTrackingOnAfterPostSalesDoc` |
| `Sales Shipment No.` field; exits when a record with that number exists or when the setup has no `Shipment Tracking Nos.` | Table field 13; `SetRange` + `IsEmpty` and the `FreightSetup` checks at the top of `CreateTrackingFromSalesShipment` |
| Shipping agent from the posted Sales Shipment Header; when blank, the one that validating `Customer No.` gave (customer's, else setup default) | `CreateTrackingFromSalesShipment` reads `"Shipping Agent Code"` from `Sales Shipment Header` and overwrites only when it is not blank. The fallback is the `OnValidate` of `Customer No.` in `CRFShipmentTrackingHeader.Table.al` (customer's `Shipping Agent Code`, else `Default Shipping Agent Code` of `CRF Freight Setup`). |
| Integration event raised after the record is saved | `OnAfterCreateTrackingFromSalesShipment`, called after `Modify(true)` |
| Posting creates a record with the customer's address and the shipping agent of the order | Needs a sandbox, not run here. |

Design choice: if the freight setup record or its `Shipment Tracking Nos.` is missing, the procedure exits quietly, so posting a sales shipment never fails because freight is not set up. The cost is that no record appears in that case; step 28 logs created records, so a gap is visible. The user who posts needs the `CRF Freight Basic` permission set (both skip flags are false, as in the model answer).

Order of the shipping agent: posted Sales Shipment Header, then the customer's own, then the setup's default. If none of them has one, the record is created with a blank shipping agent and the facade gives a clear error when someone asks for its carrier (step 19).

Not verified here: posting a real sales shipment, the duplicate guard in practice, the subscriber binding at run time. Compiled with the Business Central 28 compiler (`scripts/compile.sh app`): 0 errors, 0 warnings.
