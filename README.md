# Step 30: Test it with the test framework

Cronus Fragt · MB-820 workbook · Build the solution › Link to standard Business Central

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> Every time you change something, I'm a bit nervous that something else breaks without anyone noticing. Can we
> get a fixed check that runs every time and verifies that the most important things still work before it
> reaches us? For example that a package can't weigh zero, and that what the carrier replies about a package is
> understood correctly.

## Your task

Create a separate test project, Cronus Fragt Tests, in your workspace. Its app.json depends on Cronus Fragt and on the test libraries that Learn's walkthrough uses, Library Assert and Tests-TestLibraries, and Cronus Fragt's app.json lists the test app in internalsVisibleTo. In CRF Carrier A, change StatusFromText from module 3c from local to internal so the test app can call it. Write the test codeunit CRF Freight Tests (codeunit 50140, in the last ids of the 50100-50149 range, so the test app's own app.json needs an idRanges entry that covers it) with Subtype = Test, a TestPermissions value you can explain, and two test methods with [FEATURE], [SCENARIO] and GIVEN-WHEN-THEN comments: one that checks that the status text in_transit maps to In Transit, and one that checks that a package weight of 0 is rejected with the error from module 3b. Publish both apps and run the tests from the Test Tool page (130401).

## Checklist

- [ ] The test project is separate from Cronus Fragt, depends on it, Library Assert and Tests-TestLibraries, and Cronus Fragt lists it in internalsVisibleTo.
- [ ] Codeunit 50140 CRF Freight Tests has Subtype = Test, TestPermissions set, an Assert variable of type Codeunit "Library Assert" and two methods with the [Test] attribute.
- [ ] Each test has [SCENARIO], GIVEN, WHEN and THEN comments and exactly one WHEN.
- [ ] The validation test uses asserterror and compares GetLastErrorText with the expected message.
- [ ] Both tests show SUCCESS on the Test Tool page, and a test that you break on purpose shows FAILURE.

## In this branch

- [Notes for this step](docs/steps/30-tests.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Changes since the previous step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/29-link-to-standard-business-central/poll-carriers-with-a-job-queue-entry...30-link-to-standard-business-central/test-it-with-the-test-framework)
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/tests

---

[← Step 29](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/29-link-to-standard-business-central/poll-carriers-with-a-job-queue-entry/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 31 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/31-link-to-standard-business-central/install-and-upgrade-code/README.md)
