# Step 31: Install and upgrade code

Cronus Fragt · MB-820 workbook · Build the solution › Link to standard Business Central

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> When we put the freight solution into use in our real company, it must be ready right away, also in our other
> company and in the new one we'll probably create next year. And when a new version comes where the customers
> have been given a regular carrier, I don't want anyone sitting and keying that in for a hundred customers. The
> customers we've already shipped to should simply get the carrier we usually use for them.

## Your task

Write the install and upgrade code of Cronus Fragt. The install codeunit CRF Install (codeunit 50108, Subtype = Install) creates the CRF Freight Setup record in OnInstallAppPerCompany, as module 3a promised, and subscribes to OnCompanyInitialize of codeunit Company-Initialize so that companies created later get the record too. Then suppose version 1.0.0.0 of Cronus Fragt went live before customers had a default carrier, and version 1.1.0.0 adds it. The upgrade codeunit CRF Upgrade (codeunit 50109, Subtype = Upgrade) fills CRF Default Carrier in OnUpgradePerCompany for every customer that has none, from the carrier of the customer's latest shipment, guarded by an upgrade tag that a third codeunit, CRF Upgrade Tags (codeunit 50110), defines and registers for new companies; the install code sets the tag for fresh installations. Raise the version in app.json and publish to see the upgrade run. Explain to Mette why the data change belongs in upgrade code.

## Checklist

- [ ] Codeunit 50108 CRF Install has Subtype = Install and creates the setup record in OnInstallAppPerCompany only when it doesn't exist.
- [ ] CRF Install also subscribes to OnCompanyInitialize in Company-Initialize and creates the setup record there.
- [ ] Codeunit 50109 CRF Upgrade has Subtype = Upgrade, and its OnUpgradePerCompany exits when the upgrade tag exists, fills the default carrier and then sets the tag.
- [ ] CRF Upgrade Tags returns the tag from a procedure and adds it in a subscriber to OnGetPerCompanyUpgradeTags of codeunit Upgrade Tag, and the install code sets it for fresh installations.
- [ ] After publishing version 1.1.0.0, customers with earlier shipments have a default carrier, and publishing again doesn't change them a second time.

## In this branch

- [Notes for this step](docs/steps/31-install-and-upgrade.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Changes since the previous step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/30-link-to-standard-business-central/test-it-with-the-test-framework...31-link-to-standard-business-central/install-and-upgrade-code)
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/install-and-upgrade

---

[← Step 30](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/30-link-to-standard-business-central/test-it-with-the-test-framework/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 32 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/32-link-to-standard-business-central/debug-a-problem-and-add-danish-captions/README.md)
