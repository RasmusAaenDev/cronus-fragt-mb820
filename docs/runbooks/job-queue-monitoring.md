# Runbook: watch the job queue

Status: queries and an alert template are written; **nothing here has been run**. It needs a Business Central environment (guide, forced failure, notification) and Azure (alert rules). The queries were not executed against any Application Insights resource, and the ARM template was only checked as valid JSON.

Two ways the polling can stop, two levels of alert:

| | Level 1: the entry fails | Level 2: carriers fail inside a round |
|---|---|---|
| What happens | An error escapes `OnRun` of `CRF Update Status` (50103); the entry goes to Error, is retried up to Maximum No. of Attempts | `UpdateStatusNoError` catches the error of each shipment tracking record; the entry stays green |
| Who is told | Cronus administrator (job queue notification) and the alert | The Azure alert, to the action group (a person at Cronus; Sekvens if they run the support) |
| Telemetry | Environment's Application Insights: AL0000HE7 (failed, might be retried), AL0000JRG (failed the last time) | Resource in `app.json`: CRF-0004 (round finished) with `alFailed` above 0, in addition CRF-0002 per failed record |
| Query | `docs/monitoring/job-queue-entry-failed.kql` | `docs/monitoring/carriers-failed-in-round.kql` |

Correction against the workbook text: it names the round event CRF-0003. In this repository CRF-0003 is "shipment tracking created from a sales shipment" and the round event is CRF-0004 (see `telemetry.md`), so the level 2 query uses CRF-0004.

## Level 1 in Business Central

1. Assisted Setup, "Set Up Job Queue Notifications": choose who is told (the user who started the entry, job queue administrators, or both), how (in-product notification, or the external business event "Job queue task failed" for a Power Automate flow) and when (at once or after a number of failures).
2. Each notified user: My Notifications, "Job Queue Failed Notification" enabled.
3. The Job Queue Tasks cue shows Tasks Failed; Job Queue Log Entries show the error and Copy details gives the job queue id and timestamp.

Not done: the guide was not run, so no person is configured for notification.

## Test of level 1 (sandbox only, by a person)

1. In a sandbox, add `Error('Test of the job queue notification for Cronus Fragt.');` as the first line of `OnRun` in codeunit 50103. Do **not** commit it; the repository does not contain it.
2. Publish, set the entry (step 29 runbook: Maximum No. of Attempts 3, Rerun Delay 600) with a short Rerun Delay such as 30 seconds, set it to Ready and wait until the attempts are used up. AL0000HE7 appears for each failed attempt, AL0000JRG for the last.
3. Check: Job Queue Log Entries (status Error, the test error text), the notification, the query result (allow minutes for telemetry).
4. Remove the line, publish again, set the entry to Ready.

## Alerts

`docs/monitoring/alert-rules.template.json` is an ARM template for two log search alert rules (scheduled query rules, API 2022-06-15): level 1 on the environment's resource (every 15 minutes), level 2 on the `app.json` resource (every 30 minutes over one hour). Parameters are the two resource ids and the action group id; there are no secrets in it. Deploy with `az deployment group create --template-file docs/monitoring/alert-rules.template.json --parameters ...` after creating the action group. The real `applicationInsightsConnectionString` in `app/app.json` is still a placeholder (all zeros): level 2 sends nothing until it is replaced. Level 1 needs telemetry switched on for the environment in the admin center.

Telemetry is not instant: events arrive within minutes and an alert adds its evaluation interval.

## For Mette

If the automatic status update stops, our administrator gets a message in Business Central, and the alert goes to the action group. If a carrier's system is down for a while, the alert for failing carriers goes to the same group, even though the job itself keeps running. Both queries show only counts and ids, no customer data.
