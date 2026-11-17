# Cronus Fragt: design document

Cronus Fragt lets Cronus create shipments for customers, book them with freight carriers, follow their status, print a warehouse list and let the webshop read and create shipments.

The document grows over four steps and stays consistent with `object-ids.md`, which is the only place where ids are allocated.

| Part | File | Content |
|---|---|---|
| 1 | [01-object-list.md](01-object-list.md) | Every object of the extension, with type, name, id and purpose; the relations between them |
| 2 | [02-extend-or-build.md](02-extend-or-build.md) | Table extension or own table, per piece of data |
| 3 | 03-events.md | How the extension hooks into Business Central with events (added in step 06) |
| 4 | 04-architecture.md | Architecture sketch with a diagram (added in step 07) |
| - | [object-ids.md](object-ids.md) | Id allocation per object type, 50100-50149 |

## Requirements (from Mette)

1. Create a shipment for a customer with delivery address, carrier, status and tracking number; a shipment has several packages with weight and dimensions.
2. One place to choose the regular carrier and to hold access to the carriers' systems.
3. A printable shipment list for the warehouse.
4. The webshop can see and create shipments.
5. Status updates itself.
6. Posting a delivery creates the shipment automatically.
7. Every customer has a regular carrier.
8. Several carriers today, more later.

## Conventions

- Affix `CRF` on every object name; fields added to standard tables also carry it (`CRF Default Carrier`).
- Ids 50100-50149, allocated per object type. Interfaces have no id.
- Publisher `Cronus`, target Cloud (per-tenant extension), no changes to standard objects.
- The test app (step 30) lives in its own project and uses codeunit id 50140 from the same range.
