# Part 2: extend standard or build our own

For each piece of data in Mette's wishes: a table extension on a standard table, or a table of our own. The object ids are in [object-ids.md](object-ids.md).

## What standard Business Central already offers

Checked before deciding what to build (from Microsoft Learn and the standard objects; not tried in a sandbox):

- **Shipping Agents** (table 291) and the `Shipping Agent Code` on the sales header and on the posted sales shipment: a list of carriers on the sales documents. It models "which carrier", not a shipment with packages, status and API calls.
- **Package Tracking No.** on the posted sales shipment header: a single tracking number per posted shipment, entered by hand or by a shipping extension.
- **Posted sales shipments**: they are what the warehouse posts, but one per posting, tied to a sales order, with no packages, no carrier status and no webshop access.
- Warehouse shipments exist for directed warehouse flow and are not a carrier booking either.

Reuse: Shipping Agents are not replaced. The design keeps the carrier as an extensible enum because each carrier needs its own code behind it (an interface implementation), which a code table cannot give. Mapping a shipping agent code to a carrier value is outside the scope; the posted sales shipment's `Package Tracking No.` is a candidate to be filled later with our tracking number, and the shipment stores the number of the posted sales shipment it came from.

## Decisions

| Data | Decision | Reason |
|---|---|---|
| The shipment itself | Own tables (`CRF Shipment Header`, 50101) | See the three angles below. |
| Its packages | Own table (`CRF Shipment Line`, 50102) | A shipment has several packages; fields on a sales line cannot express that. Same document pattern as Sales Header and Sales Line. |
| The tracking number | Field on `CRF Shipment Header` | It belongs to the shipment, not to the order. Standard `Package Tracking No.` on the posted sales shipment stays available if we want to copy it there. |
| Customer's default carrier | Table extension on Customer (`CRF Default Carrier`, tableextension 50100) and page extension on Customer Card | One value per customer; it belongs on the customer card and in customer lists. Extension fields are always loaded with Customer, but one enum field is cheap, and the field is read where customers are read anyway. |
| Freight setup | Own table (`CRF Freight Setup`, 50100) | Setup data has its own table type, one record per company; mixing it into Sales & Receivables Setup would couple our life cycle to Microsoft's. |
| Carrier rates | Own table (`CRF Carrier Rate`, 50103) | New concept, own key (carrier + weight limit), imported from files. |
| Cue data | Own table (`CRF Freight Cue`, 50104) | A cue table is a table of its own by definition. |

## The three angles

**Upgrade safety.** Either choice is an extension, so Microsoft's objects are never edited. The difference is exposure. Fields we add to Sales Header or Sales Line live in an object Microsoft changes every release, and a field name or id could collide with a later standard field (if that happens, the extension is the one that must change). Own tables have no such neighbour. The `CRF` affix protects the one standard table we extend (Customer).

**Data volume and performance.** Sales Header and Sales Line are read by the whole sales process, and extension fields are loaded with the base table unless code uses partial records. Every extra field is paid on each read of each order. Shipments are many and grow (several partial shipments per order, several packages per shipment); in an own table they do not touch the performance of the base table. Customer gets one small field, which is acceptable.

**Ownership.** An own table gives Cronus Fragt its own primary key and number series, its own permissions (the `CRF Freight Basic` and `CRF Freight Admin` permission sets grant it separately), its own API for the webshop and its own life cycle: a sales order disappears from the order list once fully posted, a shipment must stay. The webshop also creates shipments that have no sales order. Standard tables would force us to share keys, number series and permissions with sales.

## Summary for Mette

We keep the freight data in its own drawer next to the sales order instead of stuffing it into the order. That way it survives Microsoft's updates, it does not slow down the order screens, and one order can have as many shipments as it needs. Only the customer's regular carrier sits on the customer, because that is where people look for it.
