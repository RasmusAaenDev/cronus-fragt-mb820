# Step 09: Create the setup page and open it from search

Delivers page 50100 `CRF Freight Setup` (`app/src/Setup/CRFFreightSetup.Page.al`): a card on the setup table with a General group (default carrier, API base URL) and a Numbering group (shipment number series), without the Primary Key field. It is found in Tell me by its caption "Cronus Freight Setup" or by the extra terms carrier, shipping, freight, shipment.

| Checklist item | Where |
|---|---|
| Card page on the setup table, no Primary Key shown | `PageType = Card`, `SourceTable`; the layout lists only fields 2-4. |
| `InsertAllowed` and `DeleteAllowed` false | Page properties. |
| `OnOpenPage` inserts the record when missing | `OnOpenPage` trigger: `Reset`, `Get`, else `Init` and `Insert`. |
| `ApplicationArea` and `UsageCategory = Administration` | Page properties (inherited by the controls); every field has a ToolTip. |

Not verified: that searching for "Cronus Freight Setup" in the web client finds the page; that needs a sandbox. Compile: `scripts/compile.sh app` 0 errors. Status in `object-ids.md`: page 50100 built.
