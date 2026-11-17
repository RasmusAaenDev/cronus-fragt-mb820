# Step 29: Poll carriers with a job queue entry

Documentation plus one code removal. Deliverable: `docs/runbooks/job-queue.md` (settings sheet for the administrator, error behaviour, notes).

| Checklist item | Where |
|---|---|
| Entry runs codeunit 50103, recurring, weekdays in working hours | Runbook, Settings (07:00-17:00 every 30 minutes, to be confirmed with Mette) |
| Category, Maximum No. of Attempts, Rerun Delay, and what they cover | Runbook, Settings and "How errors are handled" |
| Set to Ready by a user with CRF Freight, named | Runbook names the role (the Cronus administrator); the actual user must be filled in by the person who sets it up. |
| Log entries show success; failing shipment logged, not Error | Runbook step 4-5; behaviour comes from `UpdateStatusNoError` and `LogFailure` (steps 21, 28). Not run here. |
| Temporary test action removed | `actions` block removed from `CRFShipmentList.Page.al` |

Could not be done here: creating or running the entry (needs a sandbox). Note the event numbering difference from the workbook (see `docs/runbooks/telemetry.md`). `scripts/compile.sh app`: 0 errors.
