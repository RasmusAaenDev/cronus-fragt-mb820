# Step 24: API pages for the webshop

Delivers page 50105 `CRF Shipment Tracking API` and page 50106 `CRF Shipment Tracking Line API` (`app/src/Api/CRFShipmentTrackingAPI.Page.al` and `CRFShipmentTrackingLineAPI.Page.al`), both in the `CRF Freight Basic` permission set.

Endpoint: `/api/cronus/freight/v1.0/companies({company id})/shipmentTrackings` and `.../shipmentTrackingLines`. The entities are `shipmentTracking` / `shipmentTrackings` and `shipmentTrackingLine` / `shipmentTrackingLines`.

| Checklist item | Where |
|---|---|
| PageType API, publisher `cronus`, group `freight`, version `v1.0`, camelCase entity names | Properties of both pages (`shipmentTracking`/`shipmentTrackings`, `shipmentTrackingLine`/`shipmentTrackingLines`). |
| `ODataKeyFields = SystemId`; `id` not editable; `lastModifiedDateTime` from SystemModifiedAt | Both pages; `id` and `lastModifiedDateTime` have `Editable = false`. |
| Part `shipmentLines` on `CRF Shipment Tracking Line API` with entity names and SubPageLink from Document No. to the header's No. | `part(shipmentLines; "CRF Shipment Tracking Line API")` with `EntityName = 'shipmentTrackingLine'`, `EntitySetName = 'shipmentTrackingLines'` and `SubPageLink = "Document No." = field("No.")`. |
| POST with a shipmentTrackingLines array creates header and lines; number from the series; shipping agent from the customer unless the request sends `shippingAgentCode` | **Not run here**, see below. The code for the number is `OnInsert` in `CRFShipmentTrackingHeader.Table.al`; the shipping agent is set in the `OnValidate` of `Customer No.` (the customer's `Shipping Agent Code`, else the setup's `Default Shipping Agent Code`). |
| GET with `$expand=shipmentTrackingLines` | **Not run here**. |

The JSON field names include `shippingAgentCode` (header) and `documentNumber` (line), plus `number`, `customerNumber`, `trackingNumber` (the package tracking number), `status` and `totalWeight`. The part is named `shipmentLines` in the page source, but its `EntitySetName` is `shipmentTrackingLines`, and that is the name the webshop uses in the request and in `$expand`.

Read-only fields: `id`, `number`, `status`, `totalWeight`, `lastModifiedDateTime`. `DelayedInsert = true` on both (compiler requirement for insertable API pages). The header gets its number from the `OnInsert` trigger of the table (steps 11 and 12), as on the card; the webshop supplies `lineNumber` for each package and `shippingAgentCode` only when it wants a shipping agent other than the customer's. `Extensible = false` because API pages cannot be extended anyway.

One thing to test: `shippingAgentCode` is filled when `customerNumber` is validated. If the request body sets both, the order in which the fields are applied decides which one wins; check that an explicit `shippingAgentCode` survives, or send it in a later PATCH.

API pages are not shown in the UI, so they carry captions but no ToolTips or ApplicationArea.

Compile: with the Business Central 28 compiler, 0 errors (`scripts/compile.sh app`). Not verified: the deep insert and `$expand`, the number series being set up for the API caller, and OData metadata (needs a sandbox, a REST client and a bearer token).
