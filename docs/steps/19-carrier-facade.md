# Step 19: A facade codeunit

Delivers codeunit 50100 `CRF Freight Mgt` (`app/src/Freight/CRFFreightMgt.Codeunit.al`) and an Update Status action on `CRF Shipment Tracking Card`. The codeunit is in the `CRF Freight Basic` permission set.

The facade finds the carrier through the shipping agent: `GetCarrier(TrackingHeader)` reads `Shipping Agent Code` on the record, gets the standard `Shipping Agent` record and returns its `CRF Carrier` value as an `Interface "CRF ICarrier"`. Nothing on the shipment tracking record names a carrier.

| Checklist item | Where |
|---|---|
| `Access = Public`; `GetCarrier` reads the shipping agent and returns its `CRF Carrier` as the interface | `GetCarrier`: `ShippingAgent.Get(TrackingHeader."Shipping Agent Code"); Carrier := ShippingAgent."CRF Carrier";`. `GetRate` and the try function use it; no case statement. |
| Blank Shipping Agent Code gives an error that names the shipment tracking record | `GetCarrier`: `NoShippingAgentErr`, "Shipment tracking %1 has no shipping agent. Choose a shipping agent on it first." |
| `GetCarrier` and `GetStatus` in a `[TryFunction]` without writes, return value used | `TryGetStatus` (local); `UpdateStatusNoError` tests its result. Finding the carrier is inside the try function on purpose, so a missing shipping agent becomes the same kind of error as a failing call. |
| One error with ErrorInfo, Message and DetailedMessage from GetLastErrorText | `UpdateStatus`: Title, Message (for the warehouse), DetailedMessage = the error text from the try call. |
| Non-failing variant returns false and text; Status modified only after success | `UpdateStatusNoError(var TrackingHeader; var ErrorText): Boolean`; Validate and Modify come after the try call, and only if the status changed. |
| Shipping agent without a carrier shows the facade message with the No Carrier error in the details | `DefaultImplementation` (step 18) raises "Shipping agent %1 on shipment tracking %2 has no carrier..." inside the try function; the facade wraps it. Read from the code, not run. |

The action `UpdateStatus` on the card calls `FreightMgt.UpdateStatus(Rec)` and refreshes the page; it is promoted through an `actionref`.

Also in the codeunit, ahead of the step that uses it: `CarrierOf` (internal) returns the carrier of the record's shipping agent, or blank. It is for the telemetry step, which logs the carrier and not the shipping agent code.

Scope: the events from the design (`OnAfterCreateTrackingFromSalesShipment` and the `trackingstatuschanged` business event) belong to steps 27 and 26 and are not added here; `Book` comes with step 25 and `CreateTrackingFromSalesShipment` with step 27.

Compile: with the Business Central 28 compiler, 0 errors (`scripts/compile.sh app`). Not verified: the action and the ErrorInfo dialog in the web client (needs a sandbox).
