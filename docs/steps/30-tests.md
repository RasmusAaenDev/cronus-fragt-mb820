# Step 30: Test it with the test framework

- `test/app.json`: test app "Cronus Fragt Tests" (own id, publisher Cronus, idRanges 50140-50149), depends on Cronus Fragt, Library Assert and Any.
- `test/src/CRFFreightTests.Codeunit.al`: codeunit 50140 with two tests.
- `app/app.json`: `internalsVisibleTo` lists the test app; `StatusFromText` in `CRF Carrier A` changed from local to internal.
- `scripts/compile.sh test` builds the app first (the test needs its symbols), then the test app.

| Checklist item | Where |
|---|---|
| Separate project, depends on app, Library Assert, test libraries; `internalsVisibleTo` | `test/app.json`, `app/app.json`. The workbook names Tests-TestLibraries; it is not in the local symbol cache and the two tests do not need it, so the test app depends on Library Assert and Any (Any is available and ready for later tests with generated data). Add Tests-TestLibraries when a test needs Library - Sales and similar. |
| 50140, `Subtype = Test`, `TestPermissions`, `Library Assert` variable, two `[Test]` methods | `CRFFreightTests.Codeunit.al`. `TestPermissions = Disabled`: tests run as SUPER, which is fine for rules that are not about permissions. Permission tests belong in step 34. |
| SCENARIO, GIVEN, WHEN, THEN; exactly one WHEN | Both tests. |
| `asserterror` and `GetLastErrorText` compared with the expected message | `PackageWeightMustBePositive` |
| SUCCESS on the Test Tool page; a broken test shows FAILURE | Not run here. |

The tests were compiled, not run: that needs a sandbox or container with the test framework (Test Tool page 130401). `scripts/compile.sh app` and `scripts/compile.sh test`: 0 errors, 0 warnings. Both tests use `AutoRollback`, and neither needs database data.
