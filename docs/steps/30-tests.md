# Step 30: Test it with the test framework

- `test/app.json`: test app "Cronus Fragt Tests" (own id, publisher Cronus, idRanges 50140-50149), depends on Cronus Fragt, Library Assert and Any.
- `test/src/CRFFreightTests.Codeunit.al`: codeunit 50140 with two tests at this step: `CarrierStatusInTransitMapsToInTransit` and `PackageWeightMustBePositive`.
- `app/app.json`: `internalsVisibleTo` lists the test app; `StatusFromText` in `CRF Carrier A` changed from local to internal.
- `scripts/compile.sh test` builds the app first (the test needs its symbols), then the test app.

| Checklist item | Where |
|---|---|
| Separate project, depends on app, Library Assert, test libraries; `internalsVisibleTo` | `test/app.json`, `app/app.json`. The workbook names Tests-TestLibraries; it is not in the local symbol cache and the tests do not need it, so the test app depends on Library Assert and Any (Any is available and ready for later tests with generated data). Add Tests-TestLibraries when a test needs Library - Sales and similar. |
| 50140, `Subtype = Test`, `TestPermissions`, `Library Assert` variable, `[Test]` methods | `CRFFreightTests.Codeunit.al`. `TestPermissions = Disabled`: tests run as SUPER, which is fine for rules that are not about permissions. Permission tests belong in step 34. Two methods here; the workbook's four are complete only in step 34 (see below). |
| SCENARIO, GIVEN, WHEN, THEN; exactly one WHEN | All tests. |
| Weight test: `asserterror` and `GetLastErrorText` compared with the expected message | `PackageWeightMustBePositive` |
| Shipping agent test: `asserterror` and `Assert.ExpectedError` | Arrives in step 34: `TrackingWithoutShippingAgentHasNoCarrier` |
| Posting test leaves no record and needs no real posted sales shipment | Arrives in step 34: `PostingWithoutNumberSeriesCreatesNoTracking` |
| SUCCESS on the Test Tool page; a broken test shows FAILURE | Not run here. |

Difference from the workbook text: the workbook's checklist says four test methods already at this step. The tree for step 30 has two; the third and fourth are added in step 34, where the workbook's fourth-test items are met. Both tests here use `AutoRollback`, and neither needs database data.

The tests were compiled, not run: that needs a sandbox or container with the test framework (Test Tool page 130401). Compiled with the Business Central 28 compiler (`scripts/compile.sh app` and `scripts/compile.sh test`): 0 errors, 0 warnings.
