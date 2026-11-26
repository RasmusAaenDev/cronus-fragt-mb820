# Step 29: Poll carriers with a job queue entry

Documentation plus one code removal. Deliverable: `docs/runbooks/job-queue.md` (settings sheet for the administrator, error behaviour, notes).

| Checklist item | Where |
|---|---|
| Entry runs codeunit 50103, recurring, weekdays in working hours | Runbook, Settings (07:00-17:00 every 30 minutes, to be confirmed with Mette) |
| Category, Maximum No. of Attempts, Rerun Delay, and what they cover | Runbook, Settings and "How errors are handled" |
| Set to Ready by a user with CRF Freight Basic, named | Runbook names the role (the Cronus administrator); the actual user must be filled in by the person who sets it up. |
| Log entries show success; failing tracking record logged, not Error | Runbook step 4-5; behaviour comes from `UpdateStatusNoError` and `LogFailure` (steps 22 and 28). Not run here. |
| Temporary test action removed | `actions` block removed from `CRFShipmentTrackingList.Page.al` |

Difference from the workbook text: the workbook says a failing record is logged as CRF-0001. In the code the failing record in a round is logged as CRF-0002 (`LogFailure` in `CRFUpdateStatus.Codeunit.al`, dimensions `TrackingSystemId` and `Carrier`); CRF-0001 is "carrier service could not be reached" in `CRF Carrier A`, and CRF-0004 is the end of the round (see `docs/runbooks/telemetry.md`).

Could not be done here: creating or running the entry (needs a sandbox). Compiled with the Business Central 28 compiler (`scripts/compile.sh app`): 0 errors.
