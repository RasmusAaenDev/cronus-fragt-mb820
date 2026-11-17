# Step 04: Design document, part 1: the object list

Delivers `docs/design/README.md` (index, requirements, conventions), `docs/design/01-object-list.md` (all objects, relations, coverage of Mette's wishes) and `docs/design/object-ids.md` (the id allocation every later step follows). The list covers the whole project, steps 08 to 39, not only the model answer's seven areas: it adds the cue objects, the status API page, the install and upgrade codeunits, the telemetry and test ids.

| Checklist item | Where |
|---|---|
| Every object has type, CRF name, id in 50100-50149 | `01-object-list.md` tables; ids in `object-ids.md`. The interface has a name only. |
| Shipment is a document, header and line tables with a relation | Tables 50101 and 50102; relation block in `01-object-list.md`. |
| Carriers are an enum implementing an interface, one codeunit per carrier | Enum 50100, interface `CRF ICarrier`, codeunits 50101, 50102, 50106. |
| Setup table and page, report, API pages and permission set are included | Tables/pages 50100, report 50100, API pages 50105/50106/50109, permission set 50100. |
| Relations header, lines, customer, carrier written down | "Relations" in `01-object-list.md`. |

Compile: `scripts/compile.sh app` still 0 errors (no AL changed). Nothing in this step could not be done.
