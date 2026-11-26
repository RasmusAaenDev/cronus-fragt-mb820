# Part 1: the object list and its relations

Every object of the extension. Names carry the `CRF` affix, ids are in 50100-50149 (see [object-ids.md](object-ids.md)). Later steps build exactly this list; a refinement of fields is allowed, a new object is not, without updating both documents.

## Tables

| Type | Id | Name | Purpose |
|---|---|---|---|
| Table | 50100 | CRF Freight Setup | Setup table, one record: default shipping agent and the number series for shipment tracking. Nothing about a carrier's web service is stored here: the address is on the shipping agent and the API key is in isolated storage (step 21). |
| Table | 50101 | CRF Shipment Tracking Header | One record per shipment: No., customer, ship-to name and address, shipping agent, status, package tracking no., posting date, Sales Shipment No., No. Series, FlowField Total Weight. |
| Table | 50102 | CRF Shipment Tracking Line | One package of a shipment: Document No., Line No., description, weight, length, width, height. |
| Table | 50103 | CRF Shipping Agent Rate | Price per shipping agent and weight limit, filled by the rate import. |
| Table | 50104 | CRF Freight Cue | Cue table for the Role Center: FlowField Open Shipments (caption Open Shipment Tracking) and a normal field Open Default Agent. |
| Table extension | 50100 | CRF Shipping Agent | Extends the standard Shipping Agent table with `CRF Carrier` and `CRF API Base URL`, and procedures for the API key (kept in isolated storage, one key per shipping agent). |

## Enums and interface

| Type | Id | Name | Purpose |
|---|---|---|---|
| Enum | 50100 | CRF Carrier | One value per carrier implementation plus a blank value; implements `CRF ICarrier`; extensible. Chosen on the shipping agent. |
| Enum | 50101 | CRF Tracking Status | Open, Booked, In Transit, Delivered; extensible. |
| Enum extension | 50100 | CRF Event Category | Extends the standard `EventCategory` enum with `CRF Freight`, the category of the external business event (step 38). |
| Interface | - | CRF ICarrier | The carrier contract: `GetRate`, `GetStatus`. |

## Codeunits

| Type | Id | Name | Purpose |
|---|---|---|---|
| Codeunit | 50100 | CRF Freight Mgt | Public facade: finds the carrier through the record's shipping agent, rates, status update (failing and non-failing), booking, creating shipment tracking from a posted sales shipment. Publishes the extension events. |
| Codeunit | 50101 | CRF Carrier A | Implements `CRF ICarrier`; rate by total weight, status from Carrier A's web service over HTTP. Internal. |
| Codeunit | 50102 | CRF Carrier B | Implements `CRF ICarrier` with its own rate calculation (per package) and no web service. Internal. |
| Codeunit | 50106 | CRF No Carrier | Implements `CRF ICarrier` for the blank carrier value: a clear error. Internal. |
| Codeunit | 50103 | CRF Update Status | Run by the job queue: updates booked and in-transit shipment tracking, one failure does not stop the round. |
| Codeunit | 50104 | CRF Sales Post Subs | Event subscriber on Sales-Post; creates shipment tracking from a posted sales shipment. |
| Codeunit | 50105 | CRF Assisted Setup Subs | Registers the setup guide in the Assisted Setup list. |
| Codeunit | 50108 | CRF Install | Install code: creates the setup record, also for new companies. |
| Codeunit | 50109 | CRF Upgrade | Upgrade code: fills the setup's default shipping agent from the latest shipment tracking record. |
| Codeunit | 50110 | CRF Upgrade Tags | Defines and registers the upgrade tag. |
| Codeunit | 50140 | CRF Freight Tests | Test codeunit, lives in the test app (step 30). |

## Pages

| Type | Id | Name | Purpose |
|---|---|---|---|
| Page (Card) | 50100 | CRF Freight Setup | Setup card; creates the record on open; no insert or delete; searchable; an action opens the Shipping Agents. |
| Page (List) | 50101 | CRF Shipment Tracking List | Read-only list of shipment tracking; opens the card; searchable. |
| Page (Document) | 50102 | CRF Shipment Tracking Card | Shipment tracking header with the lines part; Update Status action (added with the facade, step 19). |
| Page (ListPart) | 50103 | CRF Shipment Tracking Subform | Lines of the shipment tracking. |
| Page (NavigatePage) | 50104 | CRF Cronus Freight Wizard | Assisted setup guide that writes the setup record on Finish. |
| Page (List) | 50107 | CRF Shipping Agent Rates | Rates list with an Import Rates action. |
| Page (CardPart) | 50108 | CRF Freight Activities | Cues on the Role Center. |
| Page (API) | 50105 | CRF Shipment Tracking API | Webshop: shipment tracking (`shipmentTrackings`), with the lines as a part; bound action `book`. |
| Page (API) | 50106 | CRF Shipment Tracking Line API | Webshop: shipment tracking lines (`shipmentTrackingLines`). |
| Page (API) | 50109 | CRF Tracking Status API | Read-only status lookups (`DataAccessIntent = ReadOnly`). |
| Page extension | 50100 | CRF Customer List | Hello action (step 03). |
| Page extension | 50101 | CRF Shipping Agents | Shows `CRF Carrier` and `CRF API Base URL` on the Shipping Agents page, and a masked API Key field. |
| Page extension | 50102 | CRF Order Processor RC | Adds the activities part to the Role Center. |

## Other objects

| Type | Id | Name | Purpose |
|---|---|---|---|
| Report | 50100 | CRF Warehouse Freight List | Printable freight list for the warehouse with a Word or RDLC layout. |
| XMLport | 50100 | CRF Import Agent Rates | Import-only XMLport for shipping agent rates. |
| Query | 50100 | CRF Tracking by Shipping Agent | Number of shipment tracking records per shipping agent, status filter settable by code. |
| Permission set | 50100 | CRF Freight Basic | Assignable set for daily work: shipment tracking, lines, cues, report and API pages; setup and shipping agent rates read-only; reads Shipping Agent. |
| Permission set | 50101 | CRF Freight Admin | Assignable set that includes CRF Freight Basic and adds setup, shipping agent rates, modify permission on Shipping Agent (the carrier settings), the setup guide, the rate import and install/upgrade code. |

Counts: 5 tables, 1 table extension, 2 enums, 1 interface, 11 codeunits (10 in the app, 1 in the test app), 10 pages, 3 page extensions, 1 report, 1 XMLport, 1 query, 2 permission sets.

## Relations

```text
CRF Shipment Tracking Line."Document No."          -> CRF Shipment Tracking Header."No."   many lines per header (document pattern)
CRF Shipment Tracking Header."Customer No."        -> Customer."No."                        table relation, validated
CRF Shipment Tracking Header."Shipping Agent Code" -> Shipping Agent.Code                   table relation to the standard table
Shipping Agent."CRF Carrier"                       -> enum CRF Carrier -> codeunit implementing CRF ICarrier
Shipping Agent."CRF API Base URL"                  -> the address of that shipping agent's carrier service
CRF Shipment Tracking Header."Sales Shipment No."  -> Sales Shipment Header."No."           which posting created it (blank for webshop records)
CRF Shipment Tracking Header."No. Series"          -> No. Series                            number series chosen in CRF Freight Setup
Customer."Shipping Agent Code" (standard)          -> Shipping Agent.Code                   copied to new shipment tracking; falls back to CRF Freight Setup
CRF Freight Setup."Default Shipping Agent Code"    -> Shipping Agent.Code                   used when the customer has none
CRF Shipping Agent Rate."Shipping Agent Code"      -> Shipping Agent.Code                   key: Shipping Agent Code + Weight Limit
CRF Freight Cue                                    -> counts CRF Shipment Tracking Header (FlowField) and, for the default shipping agent, by code
```

The carrier is found through the shipping agent: the facade reads the shipping agent of the tracking record and its `CRF Carrier`. The customer's regular shipping agent is the standard `Shipping Agent Code` on Customer, so Customer is not extended. Everything about the tracking itself lives in tables of its own. The reasoning is in part 2.

Interface and enum: `CRF Carrier` implements `CRF ICarrier`, each value names its codeunit. A new kind of carrier service is a new enum value plus a new codeunit; nothing existing changes. A new shipping agent that uses an existing service is only data.

## Coverage of Mette's wishes

| Wish | Objects |
|---|---|
| Shipment tracking with address, shipping agent, status, package tracking number, packages | 50101, 50102, enums 50100/50101, pages 50101-50103 |
| One place for the regular shipping agent, and address and access for each shipping agent's system | 50100 setup table and page, assisted setup 50104, 50105; table extension 50100 and page extension 50101 on Shipping Agent |
| Freight list for the warehouse | Report 50100 |
| Webshop sees and creates shipment tracking | API pages 50105, 50106, 50109 |
| Status updates itself | 50103 run by a job queue entry, facade 50100, interface and carriers |
| Delivery posting creates the tracking | Subscriber 50104 |
| Every customer has a regular shipping agent | Standard `Shipping Agent Code` on Customer, nothing to build |
| More shipping agents later | Shipping agent is data; a new carrier service is interface, extensible enum |
| Rates, overview, access, setup of the system | 50103/XMLport/50107, query and cue 50104/50108/50102, permission sets, install/upgrade |
