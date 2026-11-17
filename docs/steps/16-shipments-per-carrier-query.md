# Step 16: A query for shipments per carrier

Delivers query 50100 `CRF Shipments by Carrier` (`app/src/Cue/CRFShipmentsByCarrier.Query.al`), cue table 50104 `CRF Freight Cue`, CardPart 50108 `CRF Freight Activities` and page extension 50102 `CRF Order Processor RC` (all in `app/src/Cue/`). The query, table and part are in the `CRF Freight` permission set (the page extension needs no entry).

| Checklist item | Where |
|---|---|
| Query: Carrier column, Status filter, Count column without source field | Query file: `column(Carrier)`, `filter(Status; Status)`, `column(NoOfShipments) { Method = Count; }`. |
| Cue table: Primary Key, Integer FlowField counting open shipments, Integer normal field | `CRFFreightCue.Table.al`, fields 1-3. |
| CardPart with cuegroup, fills the normal field from the query, action tile to the list | `CRFFreightActivities.Page.al`: `OnAfterGetRecord` sets Status = Open and Carrier = the setup's default carrier, then `Open`, `Read`, `Close`; action `AllShipments` runs `CRF Shipment List`. |
| Page extension adds the part to the Role Center | `addfirst(rolecenter)` in `CRFOrderProcessorRC.PageExt.al`. |
| All four objects in the permission set | Permission set file. |

Choices: the drill-down on Open Shipments opens the shipment list (not filtered to open ones, which a FlowField drill-down on this table does not do by itself; a filtered drill-down is a later refinement). Open with Default Carrier has no drill-down, because it would show all shipments and mislead. If the setup record is missing or has no default carrier, the count is for the blank carrier value; that is only a number, not an error.

Compile: `scripts/compile.sh app` 0 errors. Not verified: the cues under Activities on the Role Center with real numbers, since that needs a sandbox and a few shipments. `object-ids.md`: query 50100, table 50104, page 50108 and page extension 50102 built.
