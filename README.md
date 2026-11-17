# Step 36: Put it in Git and build it in a pipeline

Cronus Fragt · MB-820 workbook · Bonus: CI/CD and notifications · bonus

**[See what this step changed: diff against step 35](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/02cb39ae607166dafe4eb7ef8fdd05242e8fcd76...4916bfb49d632925ec0e9151b205376894475303)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> I understand the whole freight solution is sitting on your own computer right now. What happens if it breaks,
> or if a new colleague joins one day? I'd like there to always be a safe copy in a shared place, and for
> everything to be checked automatically every time someone has made a change, before it gets anywhere near our
> books.

## Your task

Move Cronus Fragt and Cronus Fragt Tests (module 3e) into one GitHub repository and let a pipeline compile both apps and run CRF Freight Tests (codeunit 50140) on every change. Learn points to AL-Go for GitHub for this: create the repository from the template for per-tenant extensions, and follow the AL-Go documentation in its GitHub repository to add your two projects and run the CI/CD workflow. Work on a branch and merge to main through a pull request that the build must pass. Keep secrets and generated files out of the repository. Write a short note for Mette and for the next developer: where the code lives, how a change reaches main, and where the build result can be read.

## Checklist

- [ ] The repository was created from the AL-Go template for per-tenant extensions and holds both Cronus Fragt and Cronus Fragt Tests.
- [ ] A change was made on a branch and reached main through a pull request after the build had passed.
- [ ] The latest workflow run on main is green, and its output shows that both apps compiled and that the tests in codeunit 50140 passed.
- [ ] The repository contains no passwords, API keys or downloaded symbol packages (.alpackages), and your note says where the pipeline's secrets are kept according to the AL-Go documentation.
- [ ] Your note names the AL-Go repository documentation as the source for its settings and workflows.

## In this branch

- [Notes for this step](docs/steps/36-git-and-pipeline.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/02cb39ae607166dafe4eb7ef8fdd05242e8fcd76...4916bfb49d632925ec0e9151b205376894475303): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/git-and-pipeline

---

[← Step 35](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/35-quality-and-deploy/prepare-for-appsource-and-release/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 37 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/37-bonus-ci-cd-and-notifications/version-and-sign-the-app/README.md)
