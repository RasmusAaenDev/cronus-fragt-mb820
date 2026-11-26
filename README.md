# Step 34: Run your tests and the standard tests

Cronus Fragt · MB-820 workbook · Quality and deploy

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> When the warehouse posts a delivery, a lot happens in Business Central that we haven't built at all, and it
> just has to work. Now that the freight solution hangs on exactly that posting, I want to be sure that
> everything ordinary still works as before, not just our own things. Can you check that without affecting our
> real company?

## Your task

**What you hand in:** A proposed fix for Mette for every failure that only appears with Cronus Fragt installed, and a written list of where each kind of test may run. The test runs themselves are done in a container.

Run your own tests again, and then run them together with a selection of Microsoft's standard application tests in an environment where Learn allows that many tests.

**Do this**

1. Run CRF Freight Tests (codeunit 50140 from module 3e) again. It has the two tests from step 30.
2. Add two tests to it. PostingWithoutNumberSeriesCreatesNoTracking clears Shipment Tracking Nos. in CRF Freight Setup, hands a posted sales shipment number to CreateTrackingFromSalesShipment, and checks that no error is raised and no shipment tracking record exists for it (the guard from step 27). TrackingWithoutShippingAgentHasNoCarrier asks the facade for the carrier of a shipment tracking record without a shipping agent and checks the error from GetCarrier (module 3c).
3. Create a container-based development environment with the Test Toolkit and publish Cronus Fragt and Cronus Fragt Tests to it.
4. Run 50140 and the standard test codeunits that post sales documents.
5. Run the same standard tests once in the container before you install Cronus Fragt, so that you can tell which failures the extension causes.
6. Investigate every failure that only appears with Cronus Fragt installed and propose a fix to Mette.
7. Write down where each kind of test may run.

## Checklist

- [ ] Codeunit 50140 CRF Freight Tests has four tests, the two from step 30 and the two added in this step, and shows SUCCESS for all four in the sandbox, from the Test Tool page or the Test Explorer in Visual Studio Code.
- [ ] The posting test leaves no shipment tracking record behind and doesn't need a real posted sales shipment, and the shipping agent test uses asserterror and Assert.ExpectedError.
- [ ] A container-based development environment has the Test Toolkit with the test framework, the test libraries and the standard test codeunits.
- [ ] The standard test codeunits that post sales documents were run without and with Cronus Fragt installed, and you have the result of both runs.
- [ ] Every failure that only appears with Cronus Fragt installed has a cause and a fix that you have proposed to Mette.
- [ ] Your notes say where tests may run in Business Central online and why the full standard tests belong in the container.

## In this branch

- [Notes for this step](docs/steps/34-run-standard-tests.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/run-standard-tests

---

[← Step 33](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/33-quality-and-deploy/make-the-code-pass-the-analyzers/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 35 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/35-quality-and-deploy/prepare-for-appsource-and-release/README.md)
