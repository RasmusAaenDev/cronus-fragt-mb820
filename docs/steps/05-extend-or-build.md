# Step 05: Extend standard or build your own?

Delivers `docs/design/02-extend-or-build.md`: what standard Business Central offers for shipping, a decision table per piece of data, the three angles (upgrade safety, data volume and performance, ownership) and a plain summary for Mette. Consistent with the object list: the same ids and names as `docs/design/object-ids.md`.

The decision has two sides. **Extend** Shipping Agent: it already is the carrier master data (code, name, internet address, account no., services), so the carrier and the API address become fields on it. Customer is **not** extended: it already has `Shipping Agent Code`, and so do Sales Header and Sales Shipment Header (which also carries `Package Tracking No.`). **Build our own** shipment tracking tables, because a posted sales shipment cannot be changed after posting, and the webshop creates records without a sales order.

| Checklist item | Where |
|---|---|
| Every piece of data has a decision with a reason | "Decisions" table: shipment tracking, packages, package tracking number, carrier settings, setup (plus rates and cue). |
| Reasons cover upgrade safety, volume and performance, ownership | "The three angles". |
| Carrier settings are a table extension on Shipping Agent, not a Carrier table, with the reason | Row "Carrier and API address". |
| Customer is not extended, with the reason | Row "Customer's shipping agent". |
| Shipment tracking gets own tables, with the reason sales order and posted sales shipment cannot hold it | Row "Shipment tracking". |
| Summary free of technical terms | "Summary for Mette". |

Not verified: the statements about standard objects (Shipping Agent, `Shipping Agent Code` on Customer and the sales documents, `Package Tracking No.` on Sales Shipment Header) come from the workbook's references and knowledge of the base application; they were not inspected in a running sandbox. The document itself is rewritten for v2 separately from this note.
