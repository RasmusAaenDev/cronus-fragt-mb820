# Step 11: Create the shipment tracking tables

Delivers table 50101 `CRF Shipment Tracking Header` (`app/src/Shipment/CRFShipmentTrackingHeader.Table.al`), table 50102 `CRF Shipment Tracking Line` (`app/src/Shipment/CRFShipmentTrackingLine.Table.al`) and enum 50101 `CRF Tracking Status` (`app/src/Shipment/CRFTrackingStatus.Enum.al`) with only the value Open, as the task says; step 12 finishes it. Shipment tracking is a document: header keyed by No., lines keyed by Document No. and Line No. The records use the standard names: `Shipping Agent Code` (Code[10], `TableRelation = "Shipping Agent"`) and `Package Tracking No.` (Text[50]). The header has no carrier field of its own; the carrier comes from the shipping agent (step 13).

| Checklist item | Where |
|---|---|
| Header has the listed fields, No. is the primary key | Fields 1-10 and key `PK` in the header table. |
| Shipping Agent Code related to the standard Shipping Agent table, no carrier field | Field 7, `TableRelation = "Shipping Agent"`; no `Carrier` field. |
| Customer relation; validation copies name, address and shipping agent (customer's, else the setup's default) | `TableRelation = Customer` and `OnValidate` on `Customer No.`: ship-to fields, then `Customer."Shipping Agent Code`, and `CRF Freight Setup."Default Shipping Agent Code"` when that is blank. |
| Line has Document No. related to the header, and Line No. | Fields 1 and 2 of the line table (`TableRelation = "CRF Shipment Tracking Header"."No."`); the key is both fields. |
| Deleting the header deletes the lines | `OnDelete` in the header, `DeleteAll(true)` on the lines. |
| Compiles and publishes | `scripts/compile.sh app`: 0 errors with the BC 28 compiler. Publishing: not done, no sandbox. |

Left for later steps on purpose: `No. Series` (step 12), `Total Weight` and the weight check (step 14), and `Sales Shipment No.` from the design's object list (step 27, where the posted sales shipment is linked); the design document lists these fields on the header and stays correct. Weight and dimensions have captions with the unit (kg, cm). The enum is not extensible yet. `object-ids.md`: tables 50101 and 50102 and enum 50101 are marked built.

For Mette: our records are called shipment tracking, not shipments, because "shipment" already means the posted sales shipment and the warehouse shipment in Business Central. The shipping agent on a record is the one the customer already has, and the setup's default fills in when the customer has none.

Not verified: the `OnValidate` fill-in has not been run in a sandbox; only the compile was run.
