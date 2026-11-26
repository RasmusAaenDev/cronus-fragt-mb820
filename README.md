# Step 13: Extend the shipping agent

Cronus Fragt · MB-820 workbook · Build the solution › Shipment

**[See what this step changed: diff against step 12](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/ba2976ce046edc763582491f9ec8eee724ab4ba5...80140b6ec74c13480c40f6242d23cc4ecb07ceb5)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> We already have our shipping agents in Business Central, DHL, FedEx and the others, and the customers and
> orders point to them. Some of them have a system we can ask where a package is, and some don't. Can we note
> on each shipping agent how we talk to it and where its system is, so we don't have to keep a second list
> somewhere else?

## Your task

**What you hand in:** Two or three plain sentences for Mette on why the carrier settings go on the shipping agents she already has, and not in a new list of carriers. The extension objects themselves are AL code.

Extend the standard Shipping Agent table and the Shipping Agents page so that each shipping agent says which carrier implementation Cronus Fragt uses for it and where that carrier's web service is.

**Do this**

1. Create the enum CRF Carrier (enum 50100) with the values ' ' (blank), Carrier A and Carrier B, and make it extensible. It has no implementation yet; step 18 makes it implement the CRF ICarrier interface.
2. Create the table extension CRF Shipping Agent (tableextension 50100) on Shipping Agent with the fields CRF Carrier (enum CRF Carrier) and CRF API Base URL (Text[250]).
3. Create the page extension CRF Shipping Agents (pageextension 50101) on the Shipping Agents page that shows both fields in the list.
4. Don't add the API key. It is a secret and gets its own storage in step 21, with a masked field on the same page extension.
5. Publish, open Shipping Agents and set one agent (for example DHL) to Carrier A with the API Base URL https://freight-mock.sekvens.tools/carrier-a, and another (for example FEDEX) to Carrier B with no address. If your demo company lacks them, create them on the page first.

**Not this**

- Don't extend Customer. It already has a Shipping Agent Code field on the Customer Card, and step 11 already reads it.

## Checklist

- [ ] Enum 50100 CRF Carrier is extensible and has the values ' ', Carrier A and Carrier B, without implements.
- [ ] tableextension 50100 CRF Shipping Agent extends Shipping Agent with the fields CRF Carrier and CRF API Base URL, both with a Caption and DataClassification = CustomerContent, and no field for the API key.
- [ ] pageextension 50101 CRF Shipping Agents extends Shipping Agents and adds both fields to the repeater, each with ApplicationArea and a ToolTip.
- [ ] The new fields and page controls carry the CRF affix, because Shipping Agent and Shipping Agents belong to Microsoft.
- [ ] On the Shipping Agents page, one agent is set to Carrier A with the mock address and another to Carrier B.

## In this branch

- [Notes for this step](docs/steps/13-shipping-agent.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/ba2976ce046edc763582491f9ec8eee724ab4ba5...80140b6ec74c13480c40f6242d23cc4ecb07ceb5): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/extend-shipping-agent

---

[← Step 12](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/12-shipment/enums-and-number-series/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 14 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/14-shipment/card-list-and-subform-pages/README.md)
