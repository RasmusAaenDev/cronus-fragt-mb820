# Step 18: A facade codeunit

Delivers codeunit 50100 `CRF Freight Mgt` (`app/src/Freight/CRFFreightMgt.Codeunit.al`) and an Update Status action on `CRF Shipment Card`. The codeunit is in the `CRF Freight Basic` permission set.

| Checklist item | Where |
|---|---|
| `Access = Public`; carrier chosen through the interface | `Carrier := ShipmentHeader.Carrier;` in `GetRate` and `UpdateStatusNoError`; no case statement. |
| GetStatus in a `[TryFunction]` without writes, return value used | `TryGetStatus` (local); `UpdateStatusNoError` tests its result. |
| One error with ErrorInfo, Message and DetailedMessage from GetLastErrorText | `UpdateStatus`: Title, Message (for the warehouse), DetailedMessage = the carrier's error text. |
| Non-failing variant returns false and text; Status modified only after success | `UpdateStatusNoError(var ShipmentHeader; var ErrorText): Boolean`; Validate and Modify come after the try call, and only if the status changed. |
| Shipment without carrier shows the facade message with the No Carrier error in the details | `DefaultImplementation` (step 17) raises the error inside the try function; the facade wraps it. Read from the code, not run. |

The action `UpdateStatus` on the card calls `FreightMgt.UpdateStatus(Rec)` and refreshes the page; it is promoted through an `actionref`.

Scope: the events from the design (`OnAfterCreateShipmentFromSalesShipment`, the status-changed business event) belong to steps 27 and 25 and are not added here.

Compile: `scripts/compile.sh app` 0 errors, 0 warnings. Not verified: the action and the ErrorInfo dialog in the web client (needs a sandbox).
