# Step 32: Debug a problem and add Danish captions

Cronus Fragt · MB-820 workbook · Build the solution › Link to standard Business Central

**[See what this step changed: diff against step 31](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/ad3f8b7890550f243380b996de3c38aa3960afd6...d849773253cbeb7ac27bda472dd7c9a26fbd0813)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> The warehouse says the tracking status of one particular shipment never gets updated, even though the
> package arrived long ago. The other shipments update fine. Can you find out what's going on with that one?
> And another thing: our warehouse people work in Danish, but everything new is in English. Can the screens
> for the freight be in Danish too?

## Your task

**What you hand in:** A short written account for Mette of the cause of the problem and the fix you propose, plus a description of how you would record the problem with snapshot debugging. The debugging and the translation work happen in the application and the project.

Find out why the tracking status of one shipment tracking record isn't updated, and then add Danish captions to the extension.

**Debug the problem**

1. Reproduce it in your own session with the Update Status action on CRF Shipment Tracking Card, using the attach configuration from phase 1.
2. Use a breakpoint in UpdateStatusNoError in CRF Freight Mgt and a conditional breakpoint in GetStatus in CRF Carrier A that only stops for that record.
3. Describe how you would record the problem with snapshot debugging if it only happened in another user's session: the launch.json configuration, the permission set, the snappoints and how to finish and open the snapshot.
4. Write down the cause and the fix you propose to Mette.

**Add translation support**

1. Turn on the TranslationFile feature in app.json and build.
2. Copy the generated .xlf file in the Translations folder to a Danish file with target-language da-DK.
3. Translate at least the captions and tooltips of the fields that the CRF Shipping Agents page extension adds, the shipment tracking pages and the freight setup.
4. Check the result after switching your language to Danish.

## Checklist

- [ ] The debugger stops at your breakpoint in UpdateStatusNoError, and the conditional breakpoint in GetStatus only stops for the failing shipment tracking record.
- [ ] Your notes name the cause, such as a status text that StatusFromText doesn't know, and the fix you propose to Mette.
- [ ] Your notes describe a snapshotInitialize configuration, who needs the D365 Snapshot Debug and D365 ATTACH DEBUG permission sets, snappoints and finishing the session with Alt+F7.
- [ ] app.json has "features" with TranslationFile, and the Translations folder has a da-DK .xlf file with a target element for the captions and tooltips you translated.
- [ ] With your language set to Danish, the new fields on the Shipping Agents page and the shipment tracking pages show the Danish captions.

## In this branch

- [Notes for this step](docs/steps/32-debug-and-danish.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/ad3f8b7890550f243380b996de3c38aa3960afd6...d849773253cbeb7ac27bda472dd7c9a26fbd0813): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/debug-and-translate

---

[← Step 31](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/31-link-to-standard-business-central/install-and-upgrade-code/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 33 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/33-quality-and-deploy/make-the-code-pass-the-analyzers/README.md)
