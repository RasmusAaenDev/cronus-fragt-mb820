# Step 16: Import shipping agent rates with an XMLport

Cronus Fragt · MB-820 workbook · Build the solution › Shipment

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> The shipping agents send us their prices as a file that says what a package costs up to a certain weight.
> Today we key them in by hand, and a mistake always sneaks in. Can't we just import the file into the system
> when new prices arrive?

## Your task

Cronus needs the rates of each shipping agent in Business Central. Create a table for them, a list page, and an XMLport that imports a rate file.

**Do this**

1. Create the table CRF Shipping Agent Rate (table 50103) with Shipping Agent Code (related to the standard Shipping Agent table), Weight Limit and Price, keyed by Shipping Agent Code and Weight Limit.
2. Create a list page CRF Shipping Agent Rates (page 50107) that can be found in search.
3. Create the XMLport CRF Import Agent Rates (xmlport 50100). It only imports, reads an XML file like the sample below and creates one CRF Shipping Agent Rate per rate element.
4. The shipping agent comes from the attribute on the root element and must be the code of an existing shipping agent, otherwise the import stops with a clear error.
5. Add an Import Rates action to the list page that runs the XMLport without a request page.
6. Add the new objects to the permission sets: the table and page to CRF Freight Basic (the rates read only), and read, insert, modify and delete on the rates plus the XMLport to CRF Freight Admin.
7. Publish, import the sample file and show Mette the rates.

**The sample file**

- <AgentRates shippingAgent="DHL"><Rate><WeightLimit>5</WeightLimit><Price>49</Price></Rate> <Rate><WeightLimit>20</WeightLimit><Price>89</Price></Rate></AgentRates>

## Checklist

- [ ] Table 50103 CRF Shipping Agent Rate has the fields Shipping Agent Code (related to Shipping Agent), Weight Limit and Price and the key Shipping Agent Code, Weight Limit.
- [ ] XMLport 50100 CRF Import Agent Rates sets Direction = Import and Format = Xml, and its root node is a textelement.
- [ ] The shippingAgent attribute is checked against the Shipping Agent table, and an unknown code stops the import with an error.
- [ ] The Import Rates action runs the XMLport without a request page, and importing the sample file creates two rates for DHL.
- [ ] The new table and page are in CRF Freight Basic with read access to the rates, and CRF Freight Admin can maintain the rates and run the XMLport.

## In this branch

- [Notes for this step](docs/steps/16-rates-xmlport.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/rates-xmlport

---

[← Step 15](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/15-shipment/permission-sets-and-entitlements/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 17 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/17-shipment/a-query-for-shipment-tracking-per-shipping-agent/README.md)
