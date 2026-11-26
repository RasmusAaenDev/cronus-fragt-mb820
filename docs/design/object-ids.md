# Object id allocation

Range 50100-50149 (`app/app.json`, `idRanges`). Ids are unique per object type, so table 50100 and page 50100 can coexist. "Step" is the workbook step that builds the object. Status: `built` means the file exists in `app/`; `planned` means it is only designed. At the last step (39) every row is `built` except the reserved codeunit id 50107 and the free ranges, which are listed as such.

When an object is built, change its status here and nowhere else. An id is never reused for another purpose.

## Tables

| Id | Name | Step | Status |
|---|---|---|---|
| 50100 | CRF Freight Setup | 08 | built |
| 50101 | CRF Shipment Tracking Header | 11 | built |
| 50102 | CRF Shipment Tracking Line | 11 | built |
| 50103 | CRF Shipping Agent Rate | 16 | built |
| 50104 | CRF Freight Cue | 17 | built |

## Table extensions

| Id | Name | Extends | Step | Status |
|---|---|---|---|---|
| 50100 | CRF Shipping Agent | Shipping Agent (adds `CRF Carrier`, `CRF API Base URL` and the API key procedures; the API key itself comes in step 21) | 13 | built |

## Enum extensions

| Id | Name | Extends | Step | Status |
|---|---|---|---|---|
| 50100 | CRF Event Category | EventCategory (adds `CRF Freight`, the category of the external business event) | 38 | planned |

## Enums

| Id | Name | Step | Status |
|---|---|---|---|
| 50100 | CRF Carrier | 13 (made to implement CRF ICarrier in 18) | built |
| 50101 | CRF Tracking Status | 11 (finished in 12) | built |

## Interfaces (no id)

| Name | Step | Status |
|---|---|---|
| CRF ICarrier | 18 | built |

## Codeunits

| Id | Name | Step | Status |
|---|---|---|---|
| 50100 | CRF Freight Mgt | 19 | built |
| 50101 | CRF Carrier A | 18 | built |
| 50102 | CRF Carrier B | 18 | built |
| 50103 | CRF Update Status | 22 | built |
| 50104 | CRF Sales Post Subs | 27 | built |
| 50105 | CRF Assisted Setup Subs | 10 | built |
| 50106 | CRF No Carrier | 18 | built |
| 50107 | (not used: kept free as a reserve between the carrier codeunits and the install codeunits) | - | not built, on purpose |
| 50108 | CRF Install | 31 | built |
| 50109 | CRF Upgrade | 31 | built |
| 50110 | CRF Upgrade Tags | 31 | built |
| 50140 | CRF Freight Tests | 30, in the test app | built |

50111-50139 and 50141-50149 are free.

## Pages

| Id | Name | Type | Step | Status |
|---|---|---|---|---|
| 50100 | CRF Freight Setup | Card | 09 | built |
| 50101 | CRF Shipment Tracking List | List | 14 | built |
| 50102 | CRF Shipment Tracking Card | Document | 14 | built |
| 50103 | CRF Shipment Tracking Subform | ListPart | 14 | built |
| 50104 | CRF Cronus Freight Wizard | NavigatePage | 10 | built |
| 50105 | CRF Shipment Tracking API | API | 24 | built |
| 50106 | CRF Shipment Tracking Line API | API | 24 | built |
| 50107 | CRF Shipping Agent Rates | List | 16 | built |
| 50108 | CRF Freight Activities | CardPart | 17 | built |
| 50109 | CRF Tracking Status API | API, read-only | 25 | built |

## Page extensions

| Id | Name | Extends | Step | Status |
|---|---|---|---|---|
| 50100 | CRF Customer List | Customer List | 03 | built |
| 50101 | CRF Shipping Agents | Shipping Agents (page 428; the masked API Key field comes in step 21) | 13 | built |
| 50102 | CRF Order Processor RC | Order Processor Role Center | 17 | built |

## Reports, XMLports, queries, permission sets

| Type | Id | Name | Step | Status |
|---|---|---|---|---|
| Report | 50100 | CRF Warehouse Freight List | 23 | built |
| XMLport | 50100 | CRF Import Agent Rates | 16 | built |
| Query | 50100 | CRF Tracking by Shipping Agent | 17 | built |
| Permission set | 50100 | CRF Freight Basic | 15 | built |
| Permission set | 50101 | CRF Freight Admin | 15 | built |

## Not objects

- Telemetry events `CRF-0001` (step 20, Carrier A could not be reached), `CRF-0002` (step 22, a shipment tracking record failed in the polling round), `CRF-0003` (step 28, shipment tracking was created from a sales shipment) and `CRF-0004` (step 28, a polling round finished) are event ids in code, not object ids.
- The report layout is a file, not an object (`app/src/Report/CRFWarehouseFreightList.docx`, step 23).
- The test app (`test/`, id range 50140-50149 inside the same 50100-50149 range) holds only codeunit 50140.
- The Danish translation (step 32) is an `.xlf` file.
- Field ids in `CRF Shipping Agent` start at 50100 (field ids of an extension table share the same range).
