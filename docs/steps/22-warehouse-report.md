# Step 22: The shipment report for the warehouse

Delivers report 50100 `CRF Warehouse Shipment List` (`app/src/Report/CRFWarehouseShipmentList.Report.al`) and its Word layout `app/src/Report/CRFWarehouseShipmentList.docx`. The report is in the `CRF Freight Basic` permission set.

| Checklist item | Where |
|---|---|
| Header data item with an indented line data item linked on Shipment No. | `dataitem(ShipmentHeader)` / `dataitem(ShipmentLine)` with `DataItemLink = "Shipment No." = field("No.")`. |
| RequestFilterFields Status, Carrier; Show Packages option skips the lines | `RequestFilterFields = Status, Carrier`; request page field `ShowPackagesField`; `CurrReport.Break()` in the lines' `OnPreDataItem`. |
| Word layout declared in `rendering`, named by DefaultRenderingLayout; packages repeated below each shipment | `layout(WarehouseListWord)` with `Type = Word`; the .docx has a repeater on `ShipmentHeader` containing a table with a repeater on `ShipmentLine`. |
| UsageCategory, ApplicationArea, searchable, in the permission set | `UsageCategory = ReportsAndAnalysis`, `ApplicationArea = All`; permission set entry. |
| Running with Status = Open prints only open shipments | **Not run here**, see below. |

Layout choice: Word, not RDLC. Word is the low-code layout that supports printing from the request page and that Mette (or a consultant) can change without a development project (logo, moving fields). RDLC would give pixel-exact control, which this list does not need.

How the layout was made: the compiler generates a .docx skeleton with the dataset as a custom XML part. That skeleton has an empty body, and no Word is available here, so the body was written at XML level: a title, a repeater over shipments with number, status, customer, carrier, ship-to address, tracking number and total weight, and below each a package table (description, weight, length, width, height) in a nested repeater, with a paragraph between the two closing tags as Word requires. Captions come from the report labels. Checked with a layout validator (0 errors, 27 bindings, schema paths all resolve) and the compiler accepts it (0 errors).

**The layout was not rendered.** Nobody has opened it in Word or printed the report in Business Central, so the look, page breaks and column widths are unseen. Known weakness: the package table's caption row is part of the shipment block, so with Show Packages off an empty table header still prints under each shipment (a Word layout cannot hide it conditionally without extra tags); fix it in Word if it matters. The compiler rewrites the schema inside the .docx on every build; the body is kept.

For a person in a sandbox: open the report, set Status = Open, print, and check that each shipment shows its packages and that Show Packages off removes the lines.
