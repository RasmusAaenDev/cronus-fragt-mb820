# Step 26: Give customers a default carrier

Delivers a default carrier per customer and a shipment that picks it up.

- `app/src/Customer/CRFCustomer.TableExt.al`: table extension 50100 with field 50100 `CRF Default Carrier` (enum `CRF Carrier`).
- `app/src/Customer/CRFCustomerCard.PageExt.al`: page extension 50101, field in `addlast(General)`.
- `app/src/Shipment/CRFShipmentHeader.Table.al`: `Customer No.` OnValidate now sets `Carrier` from the customer, falling back to `CRF Freight Setup."Default Carrier"`.

| Checklist item | Where |
|---|---|
| Table extension 50100, field 50100, enum, caption, CustomerContent | `CRFCustomer.TableExt.al` |
| Page extension 50101, `addlast(General)`, ApplicationArea and ToolTip on the field | `CRFCustomerCard.PageExt.al` |
| CRF affix on field and control | Field and control are both named `CRF Default Carrier`; the captions stay "Default Carrier" for the user. |
| Validating Customer No. fills Carrier, with setup fallback | `Customer No.` OnValidate in `CRFShipmentHeader.Table.al` |
| Field visible on Customer Card, new shipment gets carrier | Not seen here: needs a sandbox. |

Permissions: the permission set already has `tabledata Customer = R`; extension objects need no entry of their own.

Could not be verified here: publishing, choosing a carrier on a customer and creating a shipment. `scripts/compile.sh app`: 0 errors, 0 warnings.
