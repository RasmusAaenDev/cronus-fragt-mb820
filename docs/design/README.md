# Cronus Fragt: design document

Cronus Fragt lets Cronus create shipment tracking for customers, book it with the shipping agents' carriers, follow the status, print a freight list for the warehouse and let the webshop read and create shipment tracking.

The document grows over four steps and stays consistent with `object-ids.md`, which is the only place where ids are allocated.

| Part | File | Content |
|---|---|---|
| 1 | [01-object-list.md](01-object-list.md) | Every object of the extension, with type, name, id and purpose; the relations between them |
| 2 | [02-extend-or-build.md](02-extend-or-build.md) | Table extension or own table, per piece of data |
| 3 | [03-events.md](03-events.md) | How the extension hooks into Business Central with events |
| 4 | [04-architecture.md](04-architecture.md) | Architecture sketch with a diagram |
| - | [object-ids.md](object-ids.md) | Id allocation per object type, 50100-50149 |

## Requirements (from Mette)

1. Keep shipment tracking for a customer with delivery address, shipping agent, status and package tracking number; a shipment has several packages with weight and dimensions.
2. One place to choose the regular shipping agent, and a place on each shipping agent for the address and access to its system.
3. A printable freight list for the warehouse.
4. The webshop can see and create shipment tracking.
5. Status updates itself.
6. Posting a delivery creates the tracking automatically.
7. Every customer has a regular shipping agent (it already does: the standard `Shipping Agent Code`).
8. Several shipping agents today, more later.

## Conventions

- Affix `CRF` on every object name; fields added to standard tables also carry it (`CRF Carrier`, `CRF API Base URL`).
- Ids 50100-50149, allocated per object type. Interfaces have no id.
- Publisher `Cronus`, target Cloud (per-tenant extension), no changes to standard objects.
- The shipping agent is the carrier master data. "Carrier" is the name of the implementation behind a shipping agent (enum `CRF Carrier`, interface `CRF ICarrier`), not of a table.
- The test app (step 30) lives in its own project and uses codeunit id 50140 from the same range.
