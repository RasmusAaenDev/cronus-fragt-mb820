# Part 1: the object list and its relations

Every object of the extension. Names carry the `CRF` affix, ids are in 50100-50149 (see [object-ids.md](object-ids.md)). Later steps build exactly this list; a refinement of fields is allowed, a new object is not, without updating both documents.

## Tables

| Type | Id | Name | Purpose |
|---|---|---|---|
| Table | 50100 | CRF Freight Setup | Setup table, one record: default carrier, API base URL, shipment number series. The API key is not stored here (step 20, isolated storage). |
| Table | 50101 | CRF Shipment Header | One record per shipment: No., customer, ship-to name and address, carrier, status, tracking no., posting date, Sales Shipment No., No. Series, FlowField Total Weight. |
| Table | 50102 | CRF Shipment Line | One package of a shipment: Shipment No., Line No., description, weight, length, width, height. |
| Table | 50103 | CRF Carrier Rate | Price per carrier and weight limit, filled by the rate import. |
| Table | 50104 | CRF Freight Cue | Cue table for the Role Center: FlowField Open Shipments and a normal field Open Default Carrier. |
| Table extension | 50100 | CRF Customer | Adds `CRF Default Carrier` to Customer. |

## Enums and interface

| Type | Id | Name | Purpose |
|---|---|---|---|
| Enum | 50100 | CRF Carrier | One value per carrier plus a blank value; implements `CRF ICarrier`; extensible. |
| Enum | 50101 | CRF Shipment Status | Open, Booked, In Transit, Delivered; extensible. |
| Interface | - | CRF ICarrier | The carrier contract: `GetRate`, `GetStatus`. |

## Codeunits

| Type | Id | Name | Purpose |
|---|---|---|---|
| Codeunit | 50100 | CRF Freight Mgt | Public facade: picks the carrier of a shipment through the interface, rates, status update (failing and non-failing), booking, creating a shipment from a posted sales shipment. Publishes the extension events. |
| Codeunit | 50101 | CRF Carrier A | Implements `CRF ICarrier`; calls Carrier A's status service over HTTP. Internal. |
| Codeunit | 50102 | CRF Carrier B | Implements `CRF ICarrier` with its own rate calculation. Internal. |
| Codeunit | 50106 | CRF No Carrier | Implements `CRF ICarrier` for the blank carrier value: a clear error. Internal. |
| Codeunit | 50103 | CRF Update Status | Run by the job queue: updates booked and in-transit shipments, one failure does not stop the round. |
| Codeunit | 50104 | CRF Sales Post Subs | Event subscriber on Sales-Post; creates a shipment from a posted sales shipment. |
| Codeunit | 50105 | CRF Assisted Setup Subs | Registers the setup guide in the Assisted Setup list. |
| Codeunit | 50108 | CRF Install | Install code: creates the setup record, also for new companies. |
| Codeunit | 50109 | CRF Upgrade | Upgrade code: fills `CRF Default Carrier` for existing customers. |
| Codeunit | 50110 | CRF Upgrade Tags | Defines and registers the upgrade tag. |
| Codeunit | 50140 | CRF Freight Tests | Test codeunit, lives in the test app (step 30). |

## Pages

| Type | Id | Name | Purpose |
|---|---|---|---|
| Page (Card) | 50100 | CRF Freight Setup | Setup card; creates the record on open; no insert or delete; searchable. |
| Page (List) | 50101 | CRF Shipment List | Read-only list of shipments; opens the card; searchable. |
| Page (Card) | 50102 | CRF Shipment Card | Shipment header with the lines part; Update Status action. |
| Page (ListPart) | 50103 | CRF Shipment Subform | Lines of the shipment. |
| Page (NavigatePage) | 50104 | CRF Cronus Freight Wizard | Assisted setup guide that writes the setup record on Finish. |
| Page (List) | 50107 | CRF Carrier Rates | Rates list with an Import Rates action. |
| Page (CardPart) | 50108 | CRF Freight Activities | Cues on the Role Center. |
| Page (API) | 50105 | CRF Shipment API | Webshop: shipments, with the lines as a part; bound action `bookShipment`. |
| Page (API) | 50106 | CRF Shipment Line API | Webshop: shipment lines. |
| Page (API) | 50109 | CRF Shipment Status API | Read-only status lookups (`DataAccessIntent = ReadOnly`). |
| Page extension | 50100 | CRF Customer List | Hello action (step 03). |
| Page extension | 50101 | CRF Customer Card | Shows `CRF Default Carrier`. |
| Page extension | 50102 | CRF Order Processor RC | Adds the activities part to the Role Center. |

## Other objects

| Type | Id | Name | Purpose |
|---|---|---|---|
| Report | 50100 | CRF Warehouse Shipment List | Printable warehouse list with a Word or RDLC layout. |
| XMLport | 50100 | CRF Import Carrier Rates | Import-only XMLport for carrier rates. |
| Query | 50100 | CRF Shipments by Carrier | Number of shipments per carrier, status filter settable by code. |
| Permission set | 50100 | CRF Freight Basic | Assignable set for daily work: shipments, lines, cues, report and API pages; setup and carrier rates read-only. |
| Permission set | 50101 | CRF Freight Admin | Assignable set that includes CRF Freight Basic and adds setup, carrier rates, the setup guide, the rate import and install/upgrade code. |

Counts: 5 tables, 1 table extension, 2 enums, 1 interface, 11 codeunits (10 in the app, 1 in the test app), 10 pages, 3 page extensions, 1 report, 1 XMLport, 1 query, 1 permission set.

## Relations

```text
CRF Shipment Line."Shipment No."   -> CRF Shipment Header."No."     many lines per header (document pattern)
CRF Shipment Header."Customer No." -> Customer."No."                 table relation, validated
CRF Shipment Header.Carrier        -> enum CRF Carrier -> codeunit implementing CRF ICarrier
CRF Shipment Header."Sales Shipment No." -> Sales Shipment Header."No."   which posting created it (blank for webshop shipments)
CRF Shipment Header."No. Series"   -> No. Series                     number series chosen in CRF Freight Setup
Customer."CRF Default Carrier"     -> enum CRF Carrier               copied to a new shipment; falls back to CRF Freight Setup
CRF Freight Setup."Default Carrier"-> enum CRF Carrier               used when the customer has none
CRF Carrier Rate.Carrier           -> enum CRF Carrier               key: Carrier + Weight Limit
CRF Freight Cue                    -> counts CRF Shipment Header (FlowField) and the query CRF Shipments by Carrier
```

The customer's default carrier lives on the Customer table (table extension), because it is one value per customer that belongs on the customer card. Everything else about a shipment lives in tables of its own. The reasoning is in part 2.

Interface and enum: `CRF Carrier` implements `CRF ICarrier`, each value names its codeunit. A new carrier is a new enum value plus a new codeunit; nothing existing changes.

## Coverage of Mette's wishes

| Wish | Objects |
|---|---|
| Shipment with address, carrier, status, tracking, packages | 50101, 50102, enums 50100/50101, pages 50101-50103 |
| One place for regular carrier and carrier access | 50100 setup table and page, assisted setup 50104, 50105 |
| Warehouse list | Report 50100 |
| Webshop sees and creates shipments | API pages 50105, 50106, 50109 |
| Status updates itself | 50103 run by a job queue entry, facade 50100, interface and carriers |
| Delivery posting creates the shipment | Subscriber 50104 |
| Every customer has a regular carrier | Table extension 50100, page extensions 50101 |
| More carriers later | Interface, extensible enum |
| Rates, overview, access, setup of the system | 50103/XMLport/50107, query and cue 50104/50108/50102, permission set, install/upgrade |
