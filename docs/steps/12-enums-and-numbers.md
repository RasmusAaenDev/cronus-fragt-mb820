# Step 12: Enums and number series

Finishes enum 50101 `CRF Shipment Status` (`app/src/Shipment/CRFShipmentStatus.Enum.al`): `Extensible = true`, values Open (0), Booked (1), In Transit (2), Delivered (3), each with a caption. Adds the No. Series pattern to `CRF Shipment Header` (`app/src/Shipment/CRFShipmentHeader.Table.al`): field 11 `No. Series`, an `OnInsert` trigger that fetches the next number through codeunit "No. Series", and an `OnValidate` on No. that calls `TestManual`.

| Checklist item | Where |
|---|---|
| Enum extensible with the four values | Enum file. |
| `No. Series` Code[20], relation to No. Series, not editable | Field 11 of the header: `TableRelation`, `Editable = false`. |
| `OnInsert` takes the next number from the setup series, only when No. is blank | `OnInsert`: `FreightSetup.Get`, `TestField("Shipment Nos.")`, `AreRelated`, `GetNextNo`. |
| A typed number fails unless the series allows manual numbers | `OnValidate` on `No.`: `NoSeries.TestManual(FreightSetup."Shipment Nos.")`. |
| A new shipment gets the next number from the sandbox series | Not run, see below. |

Posting Date is set to the work date first (when blank), so `GetNextNo` is called with a real date. There is no AssistEdit on the header, because Cronus uses a single series, no related series.

Not done here: creating the number series on the No. Series page, choosing it on the setup page and inserting a shipment. That needs a sandbox; `scripts/compile.sh app` only shows the code compiles (0 errors). The ids stay as in `object-ids.md`; enum 50101 is now complete.
