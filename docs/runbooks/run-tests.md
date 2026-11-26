# Runbook: run the tests and the standard tests

Status: written, **not run**. It needs a Docker host (Windows or Linux with BcContainerHelper) and a BC container with the Test Toolkit. None of that exists where this repository was built, so no test result in this repository comes from a run; the test codeunit is only compiled (`scripts/compile.sh test --codecop`: 0 errors, 0 warnings).

## Where tests may run

| Environment | Tests | Use it for |
|---|---|---|
| Online production | Not allowed | Nothing |
| Online sandbox | Manually, a few at a time; no more than 15 minutes per test method; Learn advises one or two hours a day at most | Quick run of `CRF Freight Tests` (codeunit 50140) from the Test Tool page (130401) or the VS Code Test Explorer (BC 28) |
| Container-based development environment | Large numbers of tests | The standard test codeunits, before and after installing Cronus Fragt; the pipeline (step 36) |

The standard application tests belong in the container because there are thousands, they take hours, and they change data and settings.

## Steps

1. Build both apps: `scripts/compile.sh app --codecop`, `scripts/compile.sh test --codecop`. The `.app` files come from `/tmp/alc-cronus-fragt/` or from the pipeline artifact.
2. Run `scripts/run-tests.ps1 -AppFile <app> -TestAppFile <test app> -StandardTestCodeunits '<codeunits>'` on the Docker host. It creates the container with `-includeTestToolkit`, runs the standard tests, installs Cronus Fragt and the test app, runs codeunit 50140 and the standard tests again, and writes three XUnit files.
3. Which standard codeunits: open the Test Tool page in the container, use "Get Test Codeunits" and pick the codeunits that post sales documents (names like "SCM Sales ..." / "Sales Posting ..." vary by version). I have not listed ids because they could not be checked here.
4. Diff the two standard runs. A failure only in the "with" run is caused by Cronus Fragt: find the cause, fix it, and tell Mette what changes for users.

## What I expect, and what the code already does

The workbook predicts one failure: in a company where nobody has run the setup guide, `CRF Freight Setup."Shipment Tracking Nos."` is empty, the subscriber on `OnAfterPostSalesDoc` would create shipment tracking and the `OnInsert` trigger of `CRF Shipment Tracking Header` would fail on `TestField("Shipment Tracking Nos.")`, which breaks every standard test that posts a shipment.

This repository does not have that defect: `CRF Freight Mgt.CreateTrackingFromSalesShipment` returns early when the setup record is missing or `Shipment Tracking Nos.` is empty (step 27), and `CRF Install` creates the setup record. Test `PostingWithoutNumberSeriesCreatesNoTracking` in codeunit 50140 now covers it (added in this step; compiled, not run). The decision for Mette: with no number series the freight solution silently skips the shipment tracking, so posting works but no tracking record appears until the setup guide has been run.

Other things the standard run could still reveal, which I cannot rule out here: the validation of `Customer No.` on `CRF Shipment Tracking Header`, which copies the customer's shipping agent and falls back to the setup's default, in a test company where neither has one (step 27), and the telemetry/log calls in a tests-run (no external calls are made by the posting subscriber).

## Checklist from the workbook

| Item | Status |
|---|---|
| Codeunit 50140 SUCCESS for its tests | Not run here. Compiles. Four tests now. |
| Container with Test Toolkit | Script written; no container created here |
| Standard tests with and without Cronus Fragt | Script written; no results exist |
| Failures only with Cronus Fragt: cause and fix | The one predicted failure is already prevented in code and covered by a test; real failures are unknown until the run |
| Notes on where tests may run | Table above |

Tests must not call carriers; the carrier codeunits are not used by the tests. Permission tests (a user without SUPER, Library - Lower Permissions) are still open; 50140 runs with `TestPermissions = Disabled`.
