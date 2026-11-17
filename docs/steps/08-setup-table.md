# Step 08: Create the freight setup table

Delivers table 50100 `CRF Freight Setup` (`app/src/Setup/CRFFreightSetup.Table.al`) and, because its default carrier needs it, enum 50100 `CRF Carrier` (`app/src/Setup/CRFCarrier.Enum.al`) with a blank value, `Carrier A` and `Carrier B`. The enum is extensible and does not implement `CRF ICarrier` yet; step 17 adds that. Both ids are marked `built` in `docs/design/object-ids.md`.

| Checklist item | Where |
|---|---|
| `Primary Key` Code[10], the only key field | Field 1 and key `PK` in the table. |
| Fields for default carrier, API base URL, number series | Fields 2, 3 and 4 (`Default Carrier`, `API Base URL`, `Shipment Nos.`). |
| Number series has a table relation to No. Series | `TableRelation = "No. Series"` on field 4. |
| No field for the API key | None; step 20 keeps the key in isolated storage. |
| Compiles and publishes | `scripts/compile.sh app`: 0 errors. Publishing: see below. |

Note for Mette: the key to the carrier's system is not kept in the setup table, because anyone who may read the table could read it. It is stored separately in step 20.

Not done here: publishing to a sandbox (no sandbox available); only the compile was run. The record is created by the setup page (step 09), the install code (step 31) and the setup guide (step 10), not by this step. Extra over the model answer: `ExtendedDatatype = URL` on the base URL field.
