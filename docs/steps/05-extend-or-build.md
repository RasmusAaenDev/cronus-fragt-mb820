# Step 05: Extend standard or build your own?

Delivers `docs/design/02-extend-or-build.md`: what standard Business Central offers for shipping, a decision table per piece of data, the three angles (upgrade safety, data volume and performance, ownership) and a plain summary for Mette. Consistent with the object list: the same ids and names as `docs/design/object-ids.md`.

| Checklist item | Where |
|---|---|
| Every piece of data has a decision with a reason | "Decisions" table: shipment, packages, tracking number, default carrier, setup (plus rates and cue). |
| Reasons cover upgrade safety, volume and performance, ownership | "The three angles". |
| Default carrier is a table extension on Customer, with the reason | Row "Customer's default carrier". |
| Standard shipping offer checked before building | "What standard Business Central already offers". |
| Summary free of technical terms | "Summary for Mette". |

Not verified: the statements about standard objects (Shipping Agents, Package Tracking No.) come from the workbook's references and knowledge of the base application; they were not inspected in a running sandbox.
