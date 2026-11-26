# Step 16: Import shipping agent rates with an XMLport

Delivers table 50103 `CRF Shipping Agent Rate` (`app/src/Rate/CRFShippingAgentRate.Table.al`), page 50107 `CRF Shipping Agent Rates` (`app/src/Rate/CRFShippingAgentRates.Page.al`) and XMLport 50100 `CRF Import Agent Rates` (`app/src/Rate/CRFImportAgentRates.XmlPort.al`). The table and page are added to `CRF Freight Basic` (rates read-only); `CRF Freight Admin` gets RIMD on the rates and the XMLport. The XMLport reads `<AgentRates shippingAgent="DHL"><Rate><WeightLimit>5</WeightLimit><Price>49</Price></Rate>...</AgentRates>`.

Rates belong to a shipping agent, not to a carrier implementation: two shipping agents that use the same carrier implementation can have different price lists.

| Checklist item | Where |
|---|---|
| Table with Shipping Agent Code (related to Shipping Agent), Weight Limit, Price, key Shipping Agent Code + Weight Limit | Table file, fields 1-3 (`TableRelation = "Shipping Agent"` on field 1) and key `PK`. |
| `Direction = Import`, `Format = Xml`, root is a textelement | XMLport file: properties, root `textelement(AgentRates)`. |
| shippingAgent attribute checked against the Shipping Agent table, unknown code stops the import | `ShippingAgentCodeFromFile`: an empty or too long code, or one where `ShippingAgent.Get` finds nothing, raises the Label error `UnknownAgentErr`. |
| Import Rates runs the XMLport without request page; the sample gives two DHL rates | Action `ImportRates` in `CRFShippingAgentRates.Page.al` calls `Xmlport.Run(..., false, true)`. The two-rates result is not run, see below. |
| New objects in the permission sets | `CRF Freight Basic`: table 50103 X, tabledata R, page 50107. `CRF Freight Admin`: tabledata RIMD, xmlport 50100. |

Decision: the table element has `AutoReplace = true`, so a new rate sheet replaces the price of an existing shipping agent and weight limit instead of failing on a duplicate key. This should be agreed with Mette. A rate list that gets shorter (a limit dropped from the new sheet) keeps the old row; nothing deletes rows.

Compared with a fixed enum of carriers there is nothing to translate: the attribute holds the shipping agent code as it is in the standard Shipping Agents table, and the check is a plain `Get`. The sample file in the workbook uses `shippingAgent="DHL"`, which exists in the Cronus demo company; a candidate whose company lacks DHL creates it first (step 13).

Small leftover: the tooltip of the Import Rates action still says "Imports carrier rates from an XML file." It is accurate enough, but "shipping agent rates" would match the rest.

Not verified: the import itself (needs a sandbox and the sample file). Compile: with the Business Central 28 compiler, 0 errors (`scripts/compile.sh app`). `docs/design/object-ids.md`: table 50103, page 50107, XMLport 50100 built.
