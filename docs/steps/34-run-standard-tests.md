# Step 34: Run your tests and the standard tests

This step cannot be executed here (no Docker host, no BC container, no Test Toolkit). Delivered instead:

- `docs/runbooks/run-tests.md`: where tests may run in Business Central, the procedure, and the checklist with honest status.
- `scripts/run-tests.ps1`: BcContainerHelper script (container with `-includeTestToolkit`, reference run, install, own tests, second run, XUnit output). Not run; asks for the container credential interactively, nothing is stored.
- `test/src/CRFFreightTests.Codeunit.al`: third test, `PostingWithoutShipmentNumberSeriesCreatesNoShipment`, which covers the failure the workbook predicts. The code already prevents it (`CreateShipmentFromSalesShipment` exits when `Shipment Nos.` is empty), so there is nothing to fix in the app.

| Checklist item | Where |
|---|---|
| 50140 SUCCESS | Not run; compiles (0 errors, 0 warnings with analyzers) |
| Container with Test Toolkit | Script and runbook; not created |
| Standard tests with/without the extension | Script; no results |
| Failures with cause and fix for Mette | Runbook, section "What I expect"; the decision for Mette is stated there |
| Where tests may run | Runbook table |

The standard test codeunit ids are not listed because they could not be looked up without a container.
