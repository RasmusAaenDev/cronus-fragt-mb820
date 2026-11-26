# Step 9: Create the setup page and open it from search

Cronus Fragt · MB-820 workbook · Build the solution › Setup and assisted setup

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> When I need to change our regular shipping agent, I can't be bothered to hunt around the menus. Can't I just
> search for the freight setup, like I do with everything else? And from there I'd like to get straight to our
> shipping agents. Nobody must be able to delete the setup or create a second one by accident.

## Your task

Create the card page CRF Freight Setup (page 50100) on the CRF Freight Setup table and make it easy to find, so that Mette can open it by searching and go on to the shipping agents from it.

**Do this**

1. Create the card page CRF Freight Setup (page 50100) on the CRF Freight Setup table.
2. Group the fields sensibly (Default Shipping Agent Code under General, Shipment Tracking Nos. under Numbering) and leave out the Primary Key field.
3. Add a navigation action Shipping Agents that opens the standard Shipping Agents page, where step 13 lets Mette choose the carrier and the API address of each shipping agent.
4. Make sure users can't insert or delete records on the page.
5. When the page opens and no setup record exists, make it create one.
6. Make the page available in search under Administration and publish.
7. Show Mette that she finds it by searching for "Cronus Freight Setup" (or another search term you add) and that the action opens the shipping agents.

## Checklist

- [ ] Page 50100 CRF Freight Setup is a Card page on the CRF Freight Setup table, shows Default Shipping Agent Code and Shipment Tracking Nos., and doesn't show the Primary Key field.
- [ ] The page sets InsertAllowed and DeleteAllowed to false.
- [ ] OnOpenPage inserts the setup record when it doesn't exist, so the page never opens empty.
- [ ] The page sets ApplicationArea and UsageCategory = Administration, and searching for its caption in the web client finds it.
- [ ] An action in the Navigation area opens the standard Shipping Agents page.

## In this branch

- [Notes for this step](docs/steps/09-setup-page.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/setup-page

---

[← Step 8](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/08-setup-and-assisted-setup/create-the-freight-setup-table/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 10 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/10-setup-and-assisted-setup/add-an-assisted-setup-guide/README.md)
