# Step 23: API pages for the webshop

Delivers page 50105 `CRF Shipment API` and page 50106 `CRF Shipment Line API` (`app/src/Api/`), both in the `CRF Freight` permission set.

Endpoint: `/api/cronus/freight/v1.0/companies({company id})/shipments` and `.../shipmentLines`.

| Checklist item | Where |
|---|---|
| PageType API, publisher `cronus`, group `freight`, version `v1.0`, camelCase entity names | Properties of both pages (`shipment`/`shipments`, `shipmentLine`/`shipmentLines`). |
| `ODataKeyFields = SystemId`; `id` not editable; `lastModifiedDateTime` from SystemModifiedAt | Both pages; `id`, `lastModifiedDateTime` have `Editable = false`. |
| Part `shipmentLines` with entity names and SubPageLink to the header's No. | `part(shipmentLines; "CRF Shipment Line API")` with `SubPageLink = "Shipment No." = field("No.")`. |
| POST with a shipmentLines array creates header and lines, number from series | **Not run here**, see below. |
| GET with `$expand=shipmentLines` | **Not run here**. |

Read-only fields: `id`, `number`, `status`, `totalWeight`, `lastModifiedDateTime`. `DelayedInsert = true` on both (compiler requirement for insertable API pages). The header gets its number from the `OnInsert` trigger of the table (step 11/12), as on the card; the webshop supplies `lineNumber` for each package. `Extensible = false` because API pages cannot be extended anyway.

API pages are not shown in the UI, so they carry captions but no ToolTips or ApplicationArea.

Compile: `scripts/compile.sh app` 0 errors, 0 warnings. Not verified: the deep insert and `$expand`, the number series being set up for the API caller, and OData metadata (needs a sandbox, a REST client and a bearer token).
