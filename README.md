# Step 16: A query for shipments per carrier

Cronus Fragt · MB-820 workbook · Build the solution › Shipment

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> When I open Business Central in the morning, I'd like to see right away how many shipments are still open, and
> how many of them are going with our regular carrier. And I'd like to click straight through to the list of
> shipments from there.

## Your task

Create the query CRF Shipments by Carrier (query 50100) on CRF Shipment Header that returns one row per carrier with the number of shipments, with a filter on Status that code can set. Feed it into a cue on the Role Center that Mette uses (Order Processor Role Center): a cue table CRF Freight Cue (table 50104) with a FlowField Open Shipments and a normal field Open Default Carrier, a CardPart page CRF Freight Activities (page 50108) with a cue group for the two cues and an action tile that opens CRF Shipment List, and a page extension CRF Order Processor RC (page extension 50102) that adds the part to the Role Center. The normal field is filled from the query, filtered on Status Open and on the default carrier from CRF Freight Setup. Add the new objects to CRF Freight, publish, and check the cues with a few shipments.

## Checklist

- [ ] Query 50100 has a Carrier column, a Status filter and a column with Method = Count and no source field.
- [ ] Table 50104 CRF Freight Cue has a Primary Key field, an Integer FlowField that counts open shipments and an Integer normal field.
- [ ] Page 50108 CRF Freight Activities is a CardPart with a cuegroup, fills the normal field from the query and has an action tile that opens CRF Shipment List.
- [ ] The page extension adds the part to Order Processor Role Center, and the cues appear under Activities with the right numbers.
- [ ] The query, cue table, cue page and page extension are in the CRF Freight permission set.

## In this branch

- [Notes for this step](docs/steps/16-shipments-per-carrier-query.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Changes since the previous step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/15-shipment/import-carrier-rates-with-an-xmlport...16-shipment/a-query-for-shipments-per-carrier)
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/shipments-per-carrier-query

---

[← Step 15](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/15-shipment/import-carrier-rates-with-an-xmlport/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 17 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/17-carriers-and-the-outbound-api/one-interface-for-every-carrier/README.md)
