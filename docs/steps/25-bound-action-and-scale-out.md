# Step 25: An OData action and read scale-out

Delivers the bound action `book` on page 50105 `CRF Shipment Tracking API` (`app/src/Api/CRFShipmentTrackingAPI.Page.al`), the procedure `Book` in `CRF Freight Mgt` (`app/src/Freight/CRFFreightMgt.Codeunit.al`) and the read-only page 50109 `CRF Tracking Status API` (`app/src/Api/CRFTrackingStatusAPI.Page.al`, in the permission set).

| Checklist item | Where |
|---|---|
| `[ServiceEnabled] book(var ActionContext: WebServiceActionContext)` calls the facade, sets a result code | Page 50105: `FreightMgt.Book(Rec)`, entity key from `SystemId`, `WebServiceActionResultCode::Updated`. |
| Book rejects a record that is not Open, fails without a shipping agent, carrier or rate, sets Booked | `CRF Freight Mgt.Book`: status check (`NotOpenErr`), `GetRate` (errors from `GetCarrier` for a blank shipping agent, from `CRF No Carrier` for a shipping agent without a carrier, or from the carrier's no-rate error), `Validate(Status, Booked)`, `Modify(true)`. |
| POST `.../shipmentTrackings({id})/Microsoft.NAV.book` books the test record, GET shows Booked | **Not run here**, see below. |
| Page 50109: API, `Editable = false`, `DataAccessIntent = ReadOnly`; a GET on `trackingStatuses` returns status, shipping agent code and tracking number | The page file: entity `trackingStatus` / `trackingStatuses`, fields `status`, `shippingAgentCode`, `trackingNumber` (the package tracking number), plus `id`, `number` and `lastModifiedDateTime`. |
| New page in the permission set | `page "CRF Tracking Status API" = X` in `CRFFreightBasic.PermissionSet.al`. |

Booking sends nothing to the carrier, because the mock carrier contract (step 20) has no booking call; the status change is local, as the workbook says. The rate lookup is the check that the shipping agent really has a carrier and a price for this shipment.

What `DataAccessIntent = ReadOnly` does and does not promise (from the workbook's reading of Learn): it is a hint that lets the server send the read to a read-only replica if one exists. It is not a guarantee: sandboxes cannot use read scale-out, and a replica may lag slightly behind the primary database, so a status read right after a booking can show the old value. On a page it only applies to API pages with `Editable = false`, which is why `CRF Shipment Tracking API`, which the webshop writes to, stays read-write and the lookups got their own page. The intent can be overridden per request or on the Database Access Intent List page.

Compile: with the Business Central 28 compiler, 0 errors (`scripts/compile.sh app`). Not verified: the POST and GET calls, the error text reaching the webshop, and the replica routing (needs a sandbox, or for the replica a production environment). The Learn text was not re-read from here; the statements above follow the workbook's explanation.
