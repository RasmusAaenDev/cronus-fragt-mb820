# Part 2: extend standard or build our own

For each piece of data in Mette's wishes: a table extension on a standard table, or a table of our own. The object ids are in [object-ids.md](object-ids.md). The decision goes both ways: we extend the shipping agent and we build the shipment tracking.

## What standard Business Central already offers

Checked before deciding what to build (from Microsoft Learn and the standard objects; not tried in a sandbox):

- **Shipping Agents** (table 291): the master data of the companies that carry the goods, with code, name, internet address, account number and services. The `Shipping Agent Code` is on Customer, on the sales header and on the posted sales shipment, so the choice of carrier already flows from the customer into the documents. It models "which carrier", not a shipment with packages, status and API calls.
- **Package Tracking No.** on the posted sales shipment header: a single tracking number per posted shipment, entered by hand or by a shipping extension.
- **Posted sales shipments**: they are what the warehouse posts, but one per posting, tied to a sales order, closed once posted, with no packages, no carrier status and no webshop access.
- Warehouse shipments exist for directed warehouse flow and are not a carrier booking either.

Reuse: Shipping Agents are the carriers, so we do not build a carrier table next to them and we do not add a default carrier to Customer. What they lack is what our code needs to talk to a carrier's system: which implementation to use and where it is. That is added to the shipping agent. The posted sales shipment's `Package Tracking No.` is a candidate to be filled later with our number, and the tracking record stores the number of the posted sales shipment it came from.

## Decisions

| Data | Decision | Reason |
|---|---|---|
| The shipment tracking itself | Own tables (`CRF Shipment Tracking Header`, 50101) | See the three angles below. |
| Its packages | Own table (`CRF Shipment Tracking Line`, 50102) | A shipment has several packages; fields on a sales line cannot express that. Same document pattern as Sales Header and Sales Line. |
| The package tracking number | Field on `CRF Shipment Tracking Header` | It belongs to the shipment, not to the order. Standard `Package Tracking No.` on the posted sales shipment stays available if we want to copy it there. |
| The carrier settings (which carrier implementation, the address of its web service) | Table extension on Shipping Agent (`CRF Carrier`, `CRF API Base URL`, tableextension 50100) and page extension on Shipping Agents (50101) | One value per shipping agent; the shipping agent already is the carrier master data, and the standard pages, lookups, relations and reports keep working. A copy of it would be two lists to keep in step. Shipping Agent is a small table that is read now and then, so two extension fields cost nothing worth measuring. |
| The carrier's API key | Not a field: isolated storage, one key per shipping agent (procedures on the table extension, step 21) | A secret must not sit in a table that is shown, exported and read by many. |
| The customer's regular shipping agent | Nothing: standard `Shipping Agent Code` on Customer | It already exists, also on the sales documents. A default carrier of our own on Customer would be a second value that can disagree with the first. Customer is not touched. |
| Freight setup | Own table (`CRF Freight Setup`, 50100) | Setup data has its own table type, one record per company; mixing it into Sales & Receivables Setup would couple our life cycle to Microsoft's. It holds the default shipping agent and the number series. |
| Shipping agent rates | Own table (`CRF Shipping Agent Rate`, 50103) | New concept, own key (shipping agent + weight limit), imported from files. |
| Cue data | Own table (`CRF Freight Cue`, 50104) | A cue table is a table of its own by definition. |

## The three angles

**Upgrade safety.** Either choice is an extension, so Microsoft's objects are never edited. The difference is exposure. Fields we add to Sales Header or Sales Line live in an object Microsoft changes every release, and a field name or id could collide with a later standard field (if that happens, the extension is the one that must change). Own tables have no such neighbour. The `CRF` affix protects the one standard table we extend (Shipping Agent): `CRF Carrier` and `CRF API Base URL` cannot collide with a later Microsoft field.

**Data volume and performance.** Sales Header and Sales Line are read by the whole sales process, and extension fields are loaded with the base table unless code uses partial records. Every extra field is paid on each read of each order. Shipment tracking is many records and grows (several partial shipments per order, several packages per shipment); in an own table it does not touch the performance of the base table. Shipping Agent is small, so two fields on it are acceptable.

**Ownership.** An own table gives Cronus Fragt its own primary key and number series, its own permissions and its own API for the webshop. Changing the carrier settings needs modify permission on Shipping Agent, which only `CRF Freight Admin` grants; `CRF Freight Basic` only reads it. Own tables also give the tracking its own life cycle: a sales order disappears from the order list once fully posted, and a posted sales shipment is a closed document that cannot hold a status that keeps changing or packages of our own. The tracking must stay, and the webshop also creates tracking records that have no sales order. Standard tables would force us to share keys, number series and permissions with sales.

## Summary for Mette

We use the shipping agents that are already in Business Central and only add the settings we need to talk to their systems. The tracking itself goes in its own drawer next to the sales order instead of being stuffed into it. That way it survives Microsoft's updates, it does not slow down the order screens, and one order can have as many shipments as it needs. The customer's regular shipping agent is already there, so we do not add a second one.
