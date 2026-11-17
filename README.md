# Step 34: Run your tests and the standard tests

Cronus Fragt · MB-820 workbook · Quality and deploy

**[See what this step changed: diff against step 33](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/205ebad9d42c0fd0105d150f3c48dc06482fc387...28f983ae2eb8f45a13a5f45027ecd28b02052096)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> When the warehouse posts a delivery, a lot happens in Business Central that we haven't built at all, and it
> just has to work. Now that the freight solution hangs on exactly that posting, I want to be sure that
> everything ordinary still works as before, not just our own things. Can you check that without affecting our
> real company?

## Your task

Run CRF Freight Tests (codeunit 50140 from module 3e) again, and then run it together with a selection of Microsoft's standard application tests in an environment where Learn allows that many tests. Create a container-based development environment with the Test Toolkit, publish Cronus Fragt and Cronus Fragt Tests to it, and run 50140 and the standard test codeunits that post sales documents. Run the same standard tests once in the container before you install Cronus Fragt, so that you can tell which failures the extension causes. Investigate every failure that only appears with Cronus Fragt installed, propose a fix to Mette, and write down where each kind of test may run.

## Checklist

- [ ] Codeunit 50140 CRF Freight Tests shows SUCCESS for both tests in the sandbox, from the Test Tool page or the Test Explorer in Visual Studio Code.
- [ ] A container-based development environment has the Test Toolkit with the test framework, the test libraries and the standard test codeunits.
- [ ] The standard test codeunits that post sales documents were run without and with Cronus Fragt installed, and you have the result of both runs.
- [ ] Every failure that only appears with Cronus Fragt installed has a cause and a fix that you have proposed to Mette.
- [ ] Your notes say where tests may run in Business Central online and why the full standard tests belong in the container.

## In this branch

- [Notes for this step](docs/steps/34-run-standard-tests.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/205ebad9d42c0fd0105d150f3c48dc06482fc387...28f983ae2eb8f45a13a5f45027ecd28b02052096): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/run-standard-tests

---

[← Step 33](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/33-quality-and-deploy/make-the-code-pass-the-analyzers/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 35 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/35-quality-and-deploy/prepare-for-appsource-and-release/README.md)
