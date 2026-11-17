# Step 15: Import carrier rates with an XMLport

Cronus Fragt · MB-820 workbook · Build the solution › Shipment

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> The carriers send us their prices as a file that says what a package costs up to a certain weight. Today we
> key them in by hand, and a mistake always sneaks in. Can't we just import the file into the system when new
> prices arrive?

## Your task

Create the table CRF Carrier Rate (table 50103) with Carrier (enum CRF Carrier), Weight Limit and Price, keyed by Carrier and Weight Limit, and a list page CRF Carrier Rates (page 50107) that can be found in search. Create the XMLport CRF Import Carrier Rates (xmlport 50100) that only imports, reads an XML file like the sample below and creates one CRF Carrier Rate per rate element; the carrier comes from the attribute on the root element and must match a value name of CRF Carrier, otherwise the import stops with a clear error. Add an Import Rates action to the list page that runs the XMLport without a request page. Add the new objects to CRF Freight. Publish, import the sample file and show Mette the rates. The sample file is <CarrierRates carrier="Carrier A"><Rate><WeightLimit>5</WeightLimit><Price>49</Price></Rate> <Rate><WeightLimit>20</WeightLimit><Price>89</Price></Rate></CarrierRates>.

## Checklist

- [ ] Table 50103 CRF Carrier Rate has the fields Carrier, Weight Limit and Price and the key Carrier, Weight Limit.
- [ ] XMLport 50100 CRF Import Carrier Rates sets Direction = Import and Format = Xml, and its root node is a textelement.
- [ ] The carrier attribute is turned into a CRF Carrier value, and an unknown carrier name stops the import with an error.
- [ ] The Import Rates action runs the XMLport without a request page, and importing the sample file creates two rates for Carrier A.
- [ ] The new table, page and XMLport are in the CRF Freight permission set.

## In this branch

- [Notes for this step](docs/steps/15-rates-xmlport.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Changes since the previous step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/14-shipment/permission-sets-and-entitlements...15-shipment/import-carrier-rates-with-an-xmlport)
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/rates-xmlport

---

[← Step 14](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/14-shipment/permission-sets-and-entitlements/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 16 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/16-shipment/a-query-for-shipments-per-carrier/README.md)
