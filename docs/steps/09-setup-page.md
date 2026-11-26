# Step 09: Create the setup page and open it from search

Delivers page 50100 `CRF Freight Setup` (`app/src/Setup/CRFFreightSetup.Page.al`): a card on the setup table with a General group (`Default Shipping Agent Code`) and a Numbering group (`Shipment Tracking Nos.`), without the Primary Key field, and a navigation action "Shipping Agents" that opens the standard page "Shipping Agents" (`RunObject = page "Shipping Agents"`). It is found in Tell me by its caption "Cronus Freight Setup" or by the extra terms carrier, shipping agent, freight, shipment tracking.

| Checklist item | Where |
|---|---|
| Card page on the setup table, no Primary Key shown | `PageType = Card`, `SourceTable`; the layout lists only fields 2 and 3. |
| `InsertAllowed` and `DeleteAllowed` false | Page properties. |
| `OnOpenPage` inserts the record when missing | `OnOpenPage` trigger: `Reset`, `Get`, else `Init` and `Insert`. |
| `ApplicationArea` and `UsageCategory = Administration`, found in search | Page properties (inherited by the controls); every field has a ToolTip; `AdditionalSearchTerms`. |
| Navigation action opens the Shipping Agents page | Action `ShippingAgents` in `area(Navigation)`. |

Not verified: that searching for "Cronus Freight Setup" in the web client finds the page, and that the action opens the list; both need a sandbox. The Shipping Agents page does not show the carrier fields until step 13 adds them. Compile: `scripts/compile.sh app` 0 errors. Status in `object-ids.md`: page 50100 built.
