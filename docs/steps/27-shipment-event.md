# Step 27: Create a shipment when a sales shipment is posted

Posting a sales shipment now creates a CRF shipment without touching base code.

- `app/src/Freight/CRFSalesPostSubs.Codeunit.al`: codeunit 50104 (`Access = Internal`), subscriber on `Sales-Post` `OnAfterPostSalesDoc`.
- `CRFFreightMgt.Codeunit.al`: public `CreateShipmentFromSalesShipment` and the integration event `OnAfterCreateShipmentFromSalesShipment`.
- `CRFShipmentHeader.Table.al`: field 13 `Sales Shipment No.` (relation to `Sales Shipment Header`, key `SalesShipment` for the duplicate check); shown on the shipment card.
- Permission set: `CRF Sales Post Subs` and `tabledata "Sales Shipment Header" = R` added.

| Checklist item | Where |
|---|---|
| Subscriber with matching parameter names and types | The signature compiles against BC 28 (AL0282/AL0284 would flag any mismatch). It is the one listed in `docs/design/03-events.md`. |
| Exits on `PreviewMode` or blank `SalesShptHdrNo`, otherwise only calls Freight Mgt | `CreateShipmentOnAfterPostSalesDoc` |
| `Sales Shipment No.` field; exits when a shipment with that number exists | Table field 13; `SetRange` + `IsEmpty` at the top of `CreateShipmentFromSalesShipment` |
| Integration event raised after the shipment is saved | `OnAfterCreateShipmentFromSalesShipment`, called after `Modify(true)` |
| Posting creates a shipment with the customer's address and carrier | Needs a sandbox, not run here. The code uses the `Customer No.` validation from step 26. |

Design choice: if the freight setup record or its `Shipment Nos.` is missing, the procedure exits quietly, so posting a sales shipment never fails because freight is not set up. The cost is that no shipment appears in that case; step 28 logs created shipments, so a gap is visible. The user who posts needs the `CRF Freight Basic` permission set (both skip flags are false, as in the model answer).

Not verified here: posting a real shipment, the duplicate guard in practice, the subscriber binding at run time. `scripts/compile.sh app`: 0 errors, 0 warnings.
