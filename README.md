# Step 9: Create the setup page and open it from search

Cronus Fragt · MB-820 workbook · Build the solution › Setup and assisted setup

**[See what this step changed: diff against step 8](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/c79fed0bbb91939ac6a78bc8459ca3ced07e4c2f...d6be7661a289b3bdba2c39380e9273d80f767ce1)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> When I need to change our regular carrier, I can't be bothered to hunt around the menus. Can't I just search
> for the freight setup, like I do with everything else? And nobody must be able to delete the setup or create a
> second one by accident.

## Your task

Create the card page CRF Freight Setup (page 50100) on the CRF Freight Setup table. Group the fields sensibly (general settings and numbering), leave out the Primary Key field, and make sure users can't insert or delete records on the page. When the page opens and no setup record exists, it must create one. Make the page available in search under Administration, publish, and show Mette that she finds it by searching for "Cronus Freight Setup" (or another search term you add).

## Checklist

- [ ] Page 50100 CRF Freight Setup is a Card page on the CRF Freight Setup table and doesn't show the Primary Key field.
- [ ] The page sets InsertAllowed and DeleteAllowed to false.
- [ ] OnOpenPage inserts the setup record when it doesn't exist, so the page never opens empty.
- [ ] The page sets ApplicationArea and UsageCategory = Administration, and searching for its caption in the web client finds it.

## In this branch

- [Notes for this step](docs/steps/09-setup-page.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/c79fed0bbb91939ac6a78bc8459ca3ced07e4c2f...d6be7661a289b3bdba2c39380e9273d80f767ce1): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/setup-page

---

[← Step 8](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/08-setup-and-assisted-setup/create-the-freight-setup-table/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 10 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/10-setup-and-assisted-setup/add-an-assisted-setup-guide/README.md)
