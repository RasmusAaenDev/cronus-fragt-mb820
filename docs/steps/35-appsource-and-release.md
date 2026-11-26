# Step 35: Prepare for AppSource and release

Nothing could be released or submitted from here (no admin center, no Partner Center account). Delivered: `docs/release/appsource-readiness.md`, with every item marked done, open or decision.

| Checklist item | Where |
|---|---|
| App uploaded to production, Operations page shows success | Section 1 (procedure). **Not done.** |
| Readiness note: new app id, unique name/publisher/version, registered ID range and affix, effect on Cronus's data | Section 2 |
| Draft app.json with required fields, target Cloud, idRanges for the assigned range | Section 3 (placeholders only; no registered value is invented) |
| Steps from Partner ID to technical and marketing validation; higher version for each update | Sections 5 and 6 |
| Plain summary for Mette | Section 7 |

Uses the AppSourceCop results of step 33 (section 4). The procedures on the `CRF Shipping Agent` table extension carry the CRF prefix, so the trial build has no AS0079 warnings. The draft says `application` is chosen by the publisher (the workbook's excerpt used 26.0.0.0; this repository compiles against 28 and a marketplace version should name the lowest version it supports, which has not been tested). Compiled with the Business Central 28 compiler and the analyzers, both projects: 0 errors, 0 warnings.
