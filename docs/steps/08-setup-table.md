# Step 08: Create the freight setup table

Delivers table 50100 `CRF Freight Setup` (`app/src/Setup/CRFFreightSetup.Table.al`) with three fields: `Primary Key` (Code[10], field 1), `Default Shipping Agent Code` (Code[10], field 2, `TableRelation = "Shipping Agent"`) and `Shipment Tracking Nos.` (Code[20], field 3, `TableRelation = "No. Series"`). There is no enum, no API address and no API key in the setup: the carrier and the address belong to each shipping agent (step 13), the key to the shipping agent too (step 21). The id is marked `built` in `docs/design/object-ids.md`.

| Checklist item | Where |
|---|---|
| `Primary Key` Code[10], the only key field | Field 1 and key `PK` in the table. |
| Fields Default Shipping Agent Code and Shipment Tracking Nos., nothing about carriers, addresses or keys | Fields 2 and 3; the table has no other fields. |
| Default Shipping Agent Code is Code[10] related to Shipping Agent | `TableRelation = "Shipping Agent"` on field 2. |
| Shipment Tracking Nos. is Code[20] related to No. Series | `TableRelation = "No. Series"` on field 3. |
| Compiles and publishes | `scripts/compile.sh app`: 0 errors with the BC 28 compiler. Publishing: see below. |

Note for Mette: the key to a carrier's system is not kept in the setup table, because anyone who may read the table could read it. It is stored separately, per shipping agent, in step 21.

Not done here: publishing to a sandbox (no sandbox available); only the compile was run. The record is created by the setup page (step 09), the install code (step 31) and the setup guide (step 10), not by this step.
