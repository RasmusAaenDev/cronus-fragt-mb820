# Step 11: Create the shipment tables

Delivers table 50101 `CRF Shipment Header` (`app/src/Shipment/CRFShipmentHeader.Table.al`), table 50102 `CRF Shipment Line` (`app/src/Shipment/CRFShipmentLine.Table.al`) and enum 50101 `CRF Shipment Status` (`app/src/Shipment/CRFShipmentStatus.Enum.al`) with only the value Open, as the task says; step 12 finishes it. The shipment is a document: header keyed by No., lines keyed by Shipment No. and Line No.

| Checklist item | Where |
|---|---|
| Header has the listed fields, No. is the primary key | Fields 1-10 and key `PK` in the header table. |
| Customer relation, validation copies name and address | `TableRelation = Customer` and `OnValidate` on `Customer No.`. |
| Line has Shipment No. related to the header, and Line No. | Fields 1 and 2 of the line table; the key is both fields. |
| Deleting the header deletes the lines | `OnDelete` in the header, `DeleteAll(true)` on the lines. |
| Compiles and publishes | `scripts/compile.sh app`: 0 errors. Publishing: not done, no sandbox. |

Left for later steps on purpose: `No. Series` (step 12), `Total Weight` and the weight check (step 13), and `Sales Shipment No.` from the design's object list (step 27, where the posted sales shipment is linked); the design document lists these fields on the header and stays correct. Weight and dimensions have captions with the unit (kg, cm). The enum is not extensible yet. `object-ids.md`: tables 50101 and 50102 and enum 50101 are marked built.
