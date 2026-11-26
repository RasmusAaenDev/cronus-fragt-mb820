# Step 23: The freight list for the warehouse

Delivers report 50100 `CRF Warehouse Freight List` (`app/src/Report/CRFWarehouseFreightList.Report.al`) and its Word layout `app/src/Report/CRFWarehouseFreightList.docx`. The report is in the `CRF Freight Basic` permission set. "Warehouse Shipment" is a Business Central concept of its own, so the report is called a freight list; it lists our shipment tracking records, not warehouse shipments.

| Checklist item | Where |
|---|---|
| Header data item `TrackingHeader` with an indented line data item `TrackingLine` linked on Document No. | `dataitem(TrackingHeader; "CRF Shipment Tracking Header")` / `dataitem(TrackingLine; "CRF Shipment Tracking Line")` with `DataItemLink = "Document No." = field("No.")`. |
| RequestFilterFields Status and Shipping Agent Code; Show Packages option skips the lines | `RequestFilterFields = Status, "Shipping Agent Code"`; request page field `ShowPackagesField`; `CurrReport.Break()` in the lines' `OnPreDataItem`. |
| Word layout declared in `rendering`, named by DefaultRenderingLayout; packages repeated below each record | `layout(WarehouseListWord)` with `Type = Word`, `LayoutFile = 'src/Report/CRFWarehouseFreightList.docx'`; the .docx has a repeater on `TrackingHeader` containing a table with a repeater on `TrackingLine`. |
| UsageCategory, ApplicationArea, searchable, in the permission set | `UsageCategory = ReportsAndAnalysis`, `ApplicationArea = All`; `report "CRF Warehouse Freight List" = X` in `CRFFreightBasic.PermissionSet.al`. |
| Running with Status = Open prints only open records | **Not run here**, see below. |

Layout choice: Word, not RDLC. Word is the low-code layout that supports printing from the request page and that Mette (or a consultant) can change without a development project (logo, moving fields). RDLC would give pixel-exact control, which this list does not need.

The layout shows, per record: number, status, customer, shipping agent code, ship-to address, package tracking number and total weight, and below each a package table (description, weight, length, width, height) in a nested repeater. Captions come from the report labels and the `IncludeCaption` columns. The shipping agent is shown by its code (`ShippingAgentCode`); the agent's name is not in the dataset.

How the layout was made: the compiler generates a .docx skeleton with the dataset as a custom XML part. That skeleton has an empty body, and no Word is available here, so the body was written at XML level, with a paragraph between the two closing tags as Word requires. I checked that the field paths in the .docx body are all columns of the dataset in the report file; I did not render the layout. The compiler accepts the report and layout (0 errors with the Business Central 28 compiler).

**The layout was not rendered.** Nobody has opened it in Word or printed the report in Business Central, so the look, page breaks and column widths are unseen. Known weakness: the package table's caption row is part of the record block, so with Show Packages off an empty table header still prints under each record (a Word layout cannot hide it conditionally without extra tags); fix it in Word if it matters. The compiler rewrites the schema inside the .docx on every build; the body is kept.

For a person in a sandbox: open the report, set Status = Open (and optionally one shipping agent), print, and check that each record shows its packages and that Show Packages off removes the lines.
