# Step 04: Design document, part 1: the object list

Delivers `docs/design/README.md` (index, requirements, conventions), `docs/design/01-object-list.md` (all objects, relations, coverage of Mette's wishes) and `docs/design/object-ids.md` (the id allocation every later step follows). The list covers the whole project, steps 08 to 39, not only the model answer's areas: it adds the Shipping Agent extension (table extension 50100 `CRF Shipping Agent`, page extension 50101 `CRF Shipping Agents`), the cue objects, the tracking status API page, the install and upgrade codeunits, the telemetry and test ids.

The design follows the v2 idea: the shipping agent is the standard table Shipping Agent, extended with the carrier and the API address; Customer is not extended, because it already has `Shipping Agent Code`. Our own records are called shipment tracking: tables 50101 `CRF Shipment Tracking Header` and 50102 `CRF Shipment Tracking Line`, with enum 50101 `CRF Tracking Status`. "Carrier" names only the implementation: enum 50100 `CRF Carrier`, interface `CRF ICarrier`, codeunits 50101 and 50102 (Carrier A and B) and 50106 (`CRF No Carrier`).

| Checklist item | Where |
|---|---|
| Every object has type, CRF name, id in 50100-50149 | `01-object-list.md` tables; ids in `object-ids.md`. The interface has a name only. |
| Shipment tracking is a document, header and line tables with a relation | Tables 50101 and 50102; relation block in `01-object-list.md`. |
| Shipping agent is the standard table with a table extension, no Carrier master table, no Customer extension | Table extension 50100 `CRF Shipping Agent`, page extension 50101 `CRF Shipping Agents`; no object extends Customer. |
| Carriers are an enum implementing an interface, one codeunit per carrier, each shipping agent names its carrier | Enum 50100, interface `CRF ICarrier`, codeunits 50101, 50102, 50106; the field `CRF Carrier` on the shipping agent. |
| Setup table and page, report, API pages and permission sets are included | Tables/pages 50100, report 50100, API pages 50105/50106/50109, permission sets 50100/50101. |
| Relations header, lines, customer, shipping agent, carrier written down | "Relations" in `01-object-list.md`. |

Compile: `scripts/compile.sh app` still 0 errors with the BC 28 compiler (no AL changed). Nothing in this step could not be done.

Note: the three design documents named above are rewritten for v2 separately from these step notes; this note describes what they must say and refers to them by name.
