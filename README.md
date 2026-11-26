# Step 17: A query for shipment tracking per shipping agent

Cronus Fragt · MB-820 workbook · Build the solution › Shipment

**[See what this step changed: diff against step 16](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/2ea6b3c6c7685e7c29433caaba4f013df0be4e5d...28f743178b3d46ac7a4cfbf75853ff756389b6a9)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> When I open Business Central in the morning, I'd like to see right away how many shipments are still open,
> and how many of them are going with our regular shipping agent. And I'd like to click straight through to
> the list of shipments from there.

## Your task

Create a query that counts shipment tracking records per shipping agent and use it in a cue on the Role Center that Mette uses (Order Processor Role Center).

**Do this**

1. Create the query CRF Tracking by Shipping Agent (query 50100) on CRF Shipment Tracking Header. It returns one row per shipping agent with the number of records, with a filter on Status that code can set.
2. Create a cue table CRF Freight Cue (table 50104) with a FlowField Open Shipments (caption Open Shipment Tracking) and a normal field Open Default Agent.
3. Fill the normal field from the query, filtered on Status Open and on Default Shipping Agent Code from CRF Freight Setup.
4. Create a CardPart page CRF Freight Activities (page 50108) with a cue group for the two cues and an action tile that opens CRF Shipment Tracking List.
5. Create a page extension CRF Order Processor RC (page extension 50102) that adds the part to the Role Center.
6. Add the new objects to CRF Freight Basic, publish, and check the cues with a few shipment tracking records.

## Checklist

- [ ] Query 50100 has a Shipping Agent Code column, a Status filter and a column with Method = Count and no source field.
- [ ] Table 50104 CRF Freight Cue has a Primary Key field, an Integer FlowField that counts open shipment tracking records and an Integer normal field.
- [ ] Page 50108 CRF Freight Activities is a CardPart with a cuegroup, fills the normal field from the query and has an action tile that opens CRF Shipment Tracking List.
- [ ] The page extension adds the part to Order Processor Role Center, and the cues appear under Activities with the right numbers.
- [ ] The query, cue table, cue page and page extension are in the CRF Freight Basic permission set.

## In this branch

- [Notes for this step](docs/steps/17-tracking-per-shipping-agent-query.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/2ea6b3c6c7685e7c29433caaba4f013df0be4e5d...28f743178b3d46ac7a4cfbf75853ff756389b6a9): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/shipments-per-carrier-query

---

[← Step 16](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/16-shipment/import-shipping-agent-rates-with-an-xmlport/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 18 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/18-carriers-and-the-outbound-api/one-interface-for-every-carrier/README.md)
