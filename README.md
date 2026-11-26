# Step 15: Permission sets and entitlements

Cronus Fragt · MB-820 workbook · Build the solution › Shipment

**[See what this step changed: diff against step 14](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/e49ff9b61fe3afee63e50bcb36a3b62e00229f14...dc5675ac9885a5eed27c141bf1928d2be0dc46ec)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> The warehouse and customer service need to be able to work with the shipments, but I don't want to give them
> access to everything else. Can we make access for the freight part that I can just hand to the right people:
> one for those who work with shipments, and one for whoever sets it up? A colleague also asked whether we
> need to buy a special license to use what we've built ourselves. What do I tell him?

## Your task

**What you hand in:** Three or four plain sentences for Mette on the difference between what a user's license entitles them to and what the permission sets give them. The permission sets themselves are AL code.

Create the permission sets CRF Freight Basic (permissionset 50100) and CRF Freight Admin (permissionset 50101) so that users can work with everything you have built and one person can set it up, and explain to Mette how they differ from a license.

**Do this**

1. Create CRF Freight Basic (permissionset 50100) and CRF Freight Admin (permissionset 50101), both with Assignable = true and a caption.
2. In CRF Freight Basic: execute on CRF Freight Setup, CRF Shipment Tracking Header, CRF Shipment Tracking Line and pages 50101 to 50103; read, insert, modify and delete on shipment tracking and its lines; read only on the freight setup, the customers, the shipping agents and the number series.
3. In CRF Freight Admin: include CRF Freight Basic with IncludedPermissionSets, and add read, insert, modify and delete on the freight setup, read and modify on the shipping agents, pages 50100 and 50104 and codeunit 50105.
4. Publish, assign Basic to one test user and Admin to another, and check the result on the Effective Permissions page.
5. Keep both permission sets up to date as the next steps add objects.
6. Write Mette three or four plain sentences on the difference between what a user's license entitles them to and what the permission sets give them.

## Checklist

- [ ] permissionset 50100 CRF Freight Basic and permissionset 50101 CRF Freight Admin have Assignable = true, a caption and names of no more than 20 characters.
- [ ] Every table of the extension has table X; Basic has RIMD on shipment tracking and its lines and R on the freight setup, the customers and the shipping agents, and every page and codeunit a role uses has X in that role's set.
- [ ] CRF Freight Admin includes CRF Freight Basic and adds RIMD on the freight setup, R and M on the shipping agents, the setup page, the wizard and the assisted setup codeunit.
- [ ] The sets are assigned to two test users, and the Effective Permissions page shows that only the Admin user can change the freight setup.
- [ ] Your note for Mette explains that a user can do only what both the license and the assigned permission sets allow.

## In this branch

- [Notes for this step](docs/steps/15-permissions.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/e49ff9b61fe3afee63e50bcb36a3b62e00229f14...dc5675ac9885a5eed27c141bf1928d2be0dc46ec): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/permissions

---

[← Step 14](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/14-shipment/card-list-and-subform-pages/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 16 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/16-shipment/import-shipping-agent-rates-with-an-xmlport/README.md)
