# Runbook: poll carriers with a job queue entry

For Cronus' administrator. Settings, not AL code: Learn documents creating entries on the page, so nothing is created from code. Agreed interval is a proposal for Mette to confirm (Learn advises the largest interval that works).

## Settings

| Field | Value |
|---|---|
| Object Type to Run | Codeunit |
| Object ID to Run | 50103 (CRF Update Status) |
| Description | Cronus Fragt: update shipment status from carriers |
| Recurring | Yes, Monday to Friday, 07:00-17:00, every 30 minutes |
| Job Queue Category Code | CRF (so two CRF entries never run at the same time) |
| Maximum No. of Attempts to Run | 3 |
| Rerun Delay (sec.) | 600 |
| Set to Ready by | The Cronus administrator user, who must have the `CRF Freight` permission set (the background session runs as that user) |

## Steps

1. Give the user `CRF Freight` (it contains codeunit `CRF Update Status` and the shipment tables).
2. Open Job Queue Entries, choose New, fill in the table above.
3. Choose Set Status to Ready. A new entry starts On Hold.
4. For a first test, use Run once (Foreground) and then check Log Entries: one Success entry per run.
5. In Application Insights, a shipment whose carrier failed shows as CRF-0002 and every round as CRF-0004 (see `telemetry.md`). In the workbook text the failure event is called CRF-0001; in this repo CRF-0001 is "carrier service could not be reached" (step 19), CRF-0002 the failed shipment in the round (step 21).

## How errors are handled

- A down carrier does not fail the entry. `CRF Update Status` catches the error of each shipment, logs it and continues. The next recurring run (30 minutes later) asks again. That is the "try again a bit later" Mette asked for.
- Maximum No. of Attempts and Rerun Delay cover errors that stop the whole round (an error outside the per-shipment catch). Then the entry goes to Error and, for a recurring entry whose maximum is not exceeded, is rescheduled after the delay.

## Remember

- A sandbox copied from production does not run scheduled tasks until the entries are set to Ready again.
- The temporary action `Update All Statuses` on the shipment list was removed in this step. The shipment card still has the single-shipment `Update Status` action.

## Not done here

No entry was created or run: it needs a Business Central environment. The settings are from the workbook text and have not been tried.
