# Step 31: Install and upgrade code

Cronus Fragt · MB-820 workbook · Build the solution › Link to standard Business Central

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> When we put the freight solution into use in our real company, it must be ready right away, also in our
> other company and in the new one we'll probably create next year. And when a new version comes that falls
> back on a default shipping agent for customers without one of their own, I don't want anyone going through
> every company to fill it in. Each company should simply get the shipping agent it has been using lately.

## Your task

**What you hand in:** An explanation for Mette of why the data change belongs in upgrade code. The install and upgrade codeunits are AL code.

Write the install and upgrade code of Cronus Fragt: an install codeunit, and an upgrade that fills in the default shipping agent of the freight setup in companies that already use Cronus Fragt.

**Install code**

1. Create the install codeunit CRF Install (codeunit 50108, Subtype = Install).
2. It creates the CRF Freight Setup record in OnInstallAppPerCompany, as module 3a promised.
3. It subscribes to OnCompanyInitialize of codeunit Company-Initialize so that companies created later get the record too.

**Upgrade code**

1. Suppose version 1.0.0.0 of Cronus Fragt went live before Default Shipping Agent Code in CRF Freight Setup was used, so nobody filled it in. Version 1.1.0.0 starts using it as the fallback shipping agent for customers without one (step 27), so every existing company must get a value, or its new shipment tracking records for those customers get no shipping agent and can't be booked.
2. Create the upgrade codeunit CRF Upgrade (codeunit 50109, Subtype = Upgrade). In OnUpgradePerCompany it fills Default Shipping Agent Code, when it is blank, with the shipping agent of the latest shipment tracking record that has one.
3. Guard it with an upgrade tag that a third codeunit, CRF Upgrade Tags (codeunit 50110), defines and registers for new companies. The install code sets the tag for fresh installations.
4. Raise the version in app.json and publish to see the upgrade run.
5. Explain to Mette why the data change belongs in upgrade code.

## Checklist

- [ ] Codeunit 50108 CRF Install has Subtype = Install and creates the setup record in OnInstallAppPerCompany only when it doesn't exist.
- [ ] CRF Install also subscribes to OnCompanyInitialize in Company-Initialize and creates the setup record there.
- [ ] Codeunit 50109 CRF Upgrade has Subtype = Upgrade, and its OnUpgradePerCompany exits when the upgrade tag exists, fills the default shipping agent and then sets the tag.
- [ ] CRF Upgrade Tags returns the tag from a procedure and adds it in a subscriber to OnGetPerCompanyUpgradeTags of codeunit Upgrade Tag, and the install code sets it for fresh installations.
- [ ] After publishing version 1.1.0.0, a company with earlier shipment tracking records has a Default Shipping Agent Code in CRF Freight Setup, a value that was already there is kept, and publishing again doesn't change it a second time.

## In this branch

- [Notes for this step](docs/steps/31-install-and-upgrade.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/install-and-upgrade

---

[← Step 30](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/30-link-to-standard-business-central/test-it-with-the-test-framework/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 32 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/32-link-to-standard-business-central/debug-a-problem-and-add-danish-captions/README.md)
