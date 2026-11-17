# Step 15: Import carrier rates with an XMLport

Delivers table 50103 `CRF Carrier Rate` (`app/src/Rate/CRFCarrierRate.Table.al`), page 50107 `CRF Carrier Rates` (`app/src/Rate/CRFCarrierRates.Page.al`) and XMLport 50100 `CRF Import Carrier Rates` (`app/src/Rate/CRFImportCarrierRates.XmlPort.al`). All three are added to the `CRF Freight` permission set. The XMLport reads `<CarrierRates carrier="Carrier A"><Rate><WeightLimit>5</WeightLimit><Price>49</Price></Rate>...</CarrierRates>`.

| Checklist item | Where |
|---|---|
| Table with Carrier, Weight Limit, Price, key Carrier + Weight Limit | Table file, fields 1-3 and key `PK`. |
| `Direction = Import`, `Format = Xml`, root is a textelement | XMLport file: properties, root `textelement(CarrierRates)`. |
| Carrier attribute turned into the enum, unknown name stops the import | `CarrierFromName`: `Names().IndexOf`, then `Ordinals().Get`; no match (or an empty or blank name) raises the Label error. |
| Import Rates runs the XMLport without request page; the sample gives two Carrier A rates | Action `ImportRates` calls `Xmlport.Run(..., false, true)`. The two-rates result is not run, see below. |
| New objects in CRF Freight | Permission set: table, tabledata, page 50107, xmlport 50100. |

Decision: the table element has `AutoReplace = true`, so a new rate sheet replaces the price of an existing carrier and weight limit instead of failing on a duplicate key. This should be agreed with Mette. A rate list that gets shorter (a limit dropped from the new sheet) keeps the old row; nothing deletes rows.

Not verified: the import itself (needs a sandbox and the sample file), and the assumption that `Names()` and `Ordinals()` list the values in the same order, which Learn does not state; test it with both Carrier A and Carrier B. Compile: `scripts/compile.sh app` 0 errors. `object-ids.md`: table 50103, page 50107, XMLport 50100 built.
