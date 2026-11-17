# Step 32: Debug a problem and add Danish captions

Cronus Fragt · MB-820 workbook · Build the solution › Link to standard Business Central

**[See what this step changed: diff against step 31](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/45c9278af27571933733335ccd136ce0b6e7583f...a15a22cceefed35be0079287a126fd808e81700d)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> The warehouse says the status on one particular shipment never gets updated, even though the package arrived
> long ago. The other shipments update fine. Can you find out what's going on with that one? And another thing:
> our warehouse people work in Danish, but everything new is in English. Can the screens for the freight be in
> Danish too?

## Your task

Find out why the status of one shipment isn't updated. Reproduce it in your own session with the Update Status action on CRF Shipment Card, using the attach configuration from phase 1, a breakpoint in UpdateStatusNoError in CRF Freight Mgt and a conditional breakpoint in GetStatus in CRF Carrier A that only stops for that shipment. Then describe how you would record the problem with snapshot debugging if it only happened in another user's session: the launch.json configuration, the permission set, the snappoints and how to finish and open the snapshot. Write down the cause and the fix you propose to Mette. Then add translation support: turn on the TranslationFile feature in app.json, build, copy the generated .xlf file in the Translations folder to a Danish file with target-language da-DK, translate at least the captions and tooltips of the Customer Card field, the shipment pages and the freight setup, and check the result after switching your language to Danish.

## Checklist

- [ ] The debugger stops at your breakpoint in UpdateStatusNoError, and the conditional breakpoint in GetStatus only stops for the failing shipment.
- [ ] Your notes name the cause, such as a status text that StatusFromText doesn't know, and the fix you propose to Mette.
- [ ] Your notes describe a snapshotInitialize configuration, who needs the D365 Snapshot Debug and D365 ATTACH DEBUG permission sets, snappoints and finishing the session with Alt+F7.
- [ ] app.json has "features" with TranslationFile, and the Translations folder has a da-DK .xlf file with a target element for the captions and tooltips you translated.
- [ ] With your language set to Danish, the Customer Card field and the shipment pages show the Danish captions.

## In this branch

- [Notes for this step](docs/steps/32-debug-and-danish.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/45c9278af27571933733335ccd136ce0b6e7583f...a15a22cceefed35be0079287a126fd808e81700d): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/debug-and-translate

---

[← Step 31](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/31-link-to-standard-business-central/install-and-upgrade-code/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 33 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/33-quality-and-deploy/make-the-code-pass-the-analyzers/README.md)
