# Step 24: An OData action and read scale-out

Delivers the bound action `bookShipment` on page 50105 (`app/src/Api/CRFShipmentAPI.Page.al`), the procedure `BookShipment` in `CRF Freight Mgt` and the read-only page 50109 `CRF Shipment Status API` (`app/src/Api/CRFShipmentStatusAPI.Page.al`, in the permission set).

| Checklist item | Where |
|---|---|
| `[ServiceEnabled] bookShipment(var ActionContext: WebServiceActionContext)` calls the facade, sets a result code | Page 50105: `FreightMgt.BookShipment(Rec)`, entity key, `WebServiceActionResultCode::Updated`. |
| BookShipment rejects non-Open, fails without carrier or rate, sets Booked | `CRF Freight Mgt.BookShipment`: status check, `GetRate` (errors from `CRF No Carrier` or the carrier's no-rate error), `Validate(Status, Booked)`, `Modify(true)`. |
| POST `.../shipments({id})/Microsoft.NAV.bookShipment` books, GET shows Booked | **Not run here**, see below. |
| Page 50109: API, `Editable = false`, `DataAccessIntent = ReadOnly`, status and tracking number | The page file. |
| In the permission set | Done. |

Booking sends nothing to the carrier, because the fictional carrier contract (step 19) has no booking call; the status change is local, as the workbook says.

What `DataAccessIntent = ReadOnly` does and does not promise (from the workbook's reading of Learn): it is a hint that lets the server send the read to a read-only replica if one exists. It is not a guarantee: sandboxes cannot use read scale-out, and a replica may lag slightly behind the primary database, so a status read right after a booking can show the old value. On a page it only applies to API pages with `Editable = false`, which is why `CRF Shipment API`, which the webshop writes to, stays read-write and the lookups got their own page. The intent can be overridden per request or on the Database Access Intent List page.

Compile: `scripts/compile.sh app` 0 errors, 0 warnings. Not verified: the POST and GET calls, the error text reaching the webshop, and the replica routing (needs a sandbox, or for the replica a production environment). The Learn text was not re-read from here; the statements above follow the workbook's explanation.
