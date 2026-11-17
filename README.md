# Step 26: Give customers a default carrier

Cronus Fragt · MB-820 workbook · Build the solution › Link to standard Business Central

**[See what this step changed: diff against step 25](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/cc71bd0efe2fdd5d44df2523c098bb929724ab57...2807552a1a279764f38d26a2c60e4594c9a5ea78)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> Hi! We almost always ship with the same carrier to the same customer. When I'm on the customer card, I'd like
> to be able to pick the customer's regular carrier right there, along with name and address. And when we create
> a new shipment for the customer, the carrier should simply already be there. If the customer has no regular
> carrier, we should get the one we chose in the freight setup.

## Your task

Add the field CRF Default Carrier (enum CRF Carrier from module 3a) to the standard Customer table with the table extension CRF Customer (tableextension 50100), and show it on the Customer Card with the page extension CRF Customer Card (pageextension 50101), both from the phase 2 design. Give the field an id from the project range, a caption and a data classification, and place it at the end of the General FastTab. Then make a new shipment take the customer's default carrier when Customer No. is validated on CRF Shipment Header, and fall back to Default Carrier in CRF Freight Setup when the customer has none. Publish, choose a default carrier on a customer and create a shipment for that customer.

## Checklist

- [ ] tableextension 50100 CRF Customer extends Customer with field 50100 CRF Default Carrier of type Enum "CRF Carrier", with a Caption and DataClassification = CustomerContent.
- [ ] pageextension 50101 CRF Customer Card extends Customer Card and adds the field with addlast(General), with ApplicationArea and a ToolTip set on the field.
- [ ] The new field and the new page control carry the CRF affix, because Customer and Customer Card belong to another publisher.
- [ ] Validating Customer No. on a shipment fills Carrier from the customer's default carrier, or from CRF Freight Setup when the customer has none.
- [ ] The field appears on the General FastTab of the Customer Card, and a new shipment for that customer gets its carrier.

## In this branch

- [Notes for this step](docs/steps/26-customer-extension.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/cc71bd0efe2fdd5d44df2523c098bb929724ab57...2807552a1a279764f38d26a2c60e4594c9a5ea78): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/customer-extension

---

[← Step 25](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/25-report-and-api-pages/tell-the-webshop-when-a-shipment-changes/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 27 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/27-link-to-standard-business-central/create-a-shipment-when-a-sales-shipment-is-posted/README.md)
