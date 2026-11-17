# Step 14: Permission sets and entitlements

Cronus Fragt · MB-820 workbook · Build the solution › Shipment

**[See what this step changed: diff against step 13](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/c581d425cb5638f4f0c40be2027b96a6ecd5cf58...09a55ed63a3737ac6bd878413510726043d1a025)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> The warehouse and customer service need to be able to work with the shipments, but I don't want to give them
> access to everything else. Can we make one combined access for the freight part that I can just hand to the
> right people? A colleague also asked whether we need to buy a special license to use what we've built
> ourselves. What do I tell him?

## Your task

Create the permission set CRF Freight (permissionset 50100) with Assignable = true and a caption. Grant execute permission on every table, page and codeunit you have built so far (CRF Freight Setup, CRF Shipment Header, CRF Shipment Line, pages 50100 to 50104 and codeunit 50105) and read, insert, modify and delete permission on the data in the three tables. Publish, assign the permission set to a test user in the sandbox and check the result on the Effective Permissions page. Keep the permission set up to date as the next steps add objects. Then write Mette three or four plain sentences on the difference between what a user's license entitles them to and what the permission set gives them.

## Checklist

- [ ] permissionset 50100 CRF Freight has Assignable = true, a caption and a name of no more than 20 characters.
- [ ] Every table of the extension has table X and tabledata RIMD in the permission set, and every page and codeunit has X.
- [ ] The permission set is assigned to a test user, and the Effective Permissions page shows access to the CRF tables.
- [ ] Your note for Mette explains that a user can do only what both the license and the assigned permission sets allow.

## In this branch

- [Notes for this step](docs/steps/14-permissions.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/c581d425cb5638f4f0c40be2027b96a6ecd5cf58...09a55ed63a3737ac6bd878413510726043d1a025): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/permissions

---

[← Step 13](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/13-shipment/card-list-and-subform-pages/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 15 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/15-shipment/import-carrier-rates-with-an-xmlport/README.md)
