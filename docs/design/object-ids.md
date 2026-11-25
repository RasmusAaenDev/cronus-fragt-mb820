# Object id allocation

Range 50100-50149 (`app/app.json`, `idRanges`). Ids are unique per object type, so table 50100 and page 50100 can coexist. "Step" is the workbook step that builds the object. Status: `built` means the file exists in `app/`; `planned` means it is only designed.

When an object is built, change its status here and nowhere else. An id is never reused for another purpose.

## Tables

| Id | Name | Step | Status |
|---|---|---|---|
| 50100 | CRF Freight Setup | 08 | built |
| 50101 | CRF Shipment Header | 11 | built |
| 50102 | CRF Shipment Line | 11 | built |
| 50103 | CRF Carrier Rate | 15 | built |
| 50104 | CRF Freight Cue | 16 | built |

## Table extensions

| Id | Name | Extends | Step | Status |
|---|---|---|---|---|
| 50100 | CRF Customer | Customer | 26 | planned |

## Enums

| Id | Name | Step | Status |
|---|---|---|---|
| 50100 | CRF Carrier | 08 (made to implement CRF ICarrier in 17) | built |
| 50101 | CRF Shipment Status | 11 (finished in 12) | built |

## Interfaces (no id)

| Name | Step | Status |
|---|---|---|
| CRF ICarrier | 17 | built |

## Codeunits

| Id | Name | Step | Status |
|---|---|---|---|
| 50100 | CRF Freight Mgt | 18 | built |
| 50101 | CRF Carrier A | 17 | built |
| 50102 | CRF Carrier B | 17 | built |
| 50103 | CRF Update Status | 21 | built |
| 50104 | CRF Sales Post Subs | 27 | planned |
| 50105 | CRF Assisted Setup Subs | 10 | built |
| 50106 | CRF No Carrier | 17 | built |
| 50107 | (free, reserve) | - | free |
| 50108 | CRF Install | 31 | planned |
| 50109 | CRF Upgrade | 31 | planned |
| 50110 | CRF Upgrade Tags | 31 | planned |
| 50140 | CRF Freight Tests | 30, in the test app | planned |

50111-50139 and 50141-50149 are free.

## Pages

| Id | Name | Type | Step | Status |
|---|---|---|---|---|
| 50100 | CRF Freight Setup | Card | 09 | built |
| 50101 | CRF Shipment List | List | 13 | built |
| 50102 | CRF Shipment Card | Card | 13 | built |
| 50103 | CRF Shipment Subform | ListPart | 13 | built |
| 50104 | CRF Cronus Freight Wizard | NavigatePage | 10 | built |
| 50105 | CRF Shipment API | API | 23 | planned |
| 50106 | CRF Shipment Line API | API | 23 | planned |
| 50107 | CRF Carrier Rates | List | 15 | built |
| 50108 | CRF Freight Activities | CardPart | 16 | built |
| 50109 | CRF Shipment Status API | API, read-only | 24 | planned |

## Page extensions

| Id | Name | Extends | Step | Status |
|---|---|---|---|---|
| 50100 | CRF Customer List | Customer List | 03 | built |
| 50101 | CRF Customer Card | Customer Card | 26 | planned |
| 50102 | CRF Order Processor RC | Order Processor Role Center | 16 | built |

## Reports, XMLports, queries, permission sets

| Type | Id | Name | Step | Status |
|---|---|---|---|---|
| Report | 50100 | CRF Warehouse Shipment List | 22 | planned |
| XMLport | 50100 | CRF Import Carrier Rates | 15 | built |
| Query | 50100 | CRF Shipments by Carrier | 16 | built |
| Permission set | 50100 | CRF Freight Basic | 14 | built |
| Permission set | 50101 | CRF Freight Admin | 14 | built |

## Not objects

- Telemetry events `CRF-0001` (step 19, Carrier A could not be reached), `CRF-0002` (step 21, a shipment failed in the polling round) and `CRF-0003` (step 28) are event ids in code, not object ids.
- The report layout is a file, not an object.
- The Danish translation (step 32) is an `.xlf` file.
- Field ids in `CRF Customer` start at 50100 (field ids of an extension table share the same range).
