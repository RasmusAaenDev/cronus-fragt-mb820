# Step 35: Prepare for AppSource and release

Cronus Fragt · MB-820 workbook · Quality and deploy

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> This is it! The freight solution has to go into our real company, and it should happen without the warehouse
> noticing anything in the middle of the day. And one more thing: two of our partners have asked whether they
> can buy the solution from us. What does it take before we can sell it to others? Can we just give them the one
> we use ourselves?

## Your task

First release Cronus Fragt to Cronus's production environment: upload the .app of Cronus Fragt (version 1.1.0.0 from module 3e, or higher), but not the test app, on the Manage Apps page of the admin center, and schedule the installation with Mette. Then write a readiness note for an AppSource version of Cronus Fragt: what must change in its identity, ID range and affixes compared with the per-tenant extension and what that means for Cronus's own data; a draft app.json with the fields a marketplace submission requires; what the technical validation checks and what the marketing validation is about; how the app gets from Partner Center to customers; and the versioning rules for later updates. Use the AppSourceCop findings from the analyzer step. End with a few plain sentences for Mette.

## Checklist

- [ ] The Cronus Fragt .app, without Cronus Fragt Tests, was uploaded with Install Extension on Manage Apps, scheduled as agreed with Mette, and the Operations page shows that the installation succeeded.
- [ ] Your readiness note says that the marketplace version needs a new app id, a name, publisher and version combination that no per-tenant extension uses, a registered ID range and a registered affix, and what that means for Cronus's own data.
- [ ] The draft app.json has brief, description, privacyStatement, EULA, help, url, logo, contextSensitiveHelpUrl and application, target Cloud and an idRanges entry for the range Microsoft assigns.
- [ ] Your note lists the steps from a Partner ID and a Partner Center account to the automated technical validation and the marketing validation, and says that each update needs a higher version number.
- [ ] The summary for Mette explains in plain words why Cronus can't simply give its partners the version it uses itself.

## In this branch

- [Notes for this step](docs/steps/35-appsource-and-release.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Changes since the previous step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/34-quality-and-deploy/run-your-tests-and-the-standard-tests...35-quality-and-deploy/prepare-for-appsource-and-release)
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/appsource-and-release

---

[← Step 34](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/34-quality-and-deploy/run-your-tests-and-the-standard-tests/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 36 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/36-bonus-ci-cd-and-notifications/put-it-in-git-and-build-it-in-a-pipeline/README.md)
