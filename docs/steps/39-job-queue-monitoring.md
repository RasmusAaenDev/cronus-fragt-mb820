# Step 39: Watch the job queue

Needs a sandbox and an Azure subscription; neither exists here. Delivered:

- `docs/monitoring/job-queue-entry-failed.kql`: level 1 query (AL0000HE7, AL0000JRG, object 50103).
- `docs/monitoring/carriers-failed-in-round.kql`: level 2 query (`CRF-0004`, `alFailed` > 0).
- `docs/monitoring/alert-rules.template.json`: ARM template with the two alert rules (valid JSON; not deployed, not validated against Azure).
- `docs/runbooks/job-queue-monitoring.md`: notification guide, forced-failure test, alerts, note for Mette.

| Checklist item | Status |
|---|---|
| Guide completed, notification enabled on My Notifications | Not done (needs Business Central); steps in the runbook |
| Forced failure: Error log entry and notification | Not done; the test code is not in the repository (it must be removed again anyway) |
| KQL for AL0000HE7 / AL0000JRG, id 50103, and an alert rule | Query and rule template written; not run |
| KQL for the carrier events with failures, and an alert rule | Query and rule template written; uses CRF-0004 because CRF-0003 is a different event here ("tracking created"); the workbook says CRF-0003 (see step 28) |
| Test error removed, entry Ready, note for Mette | Nothing to remove; note in the runbook |

`app.json` still has a placeholder connection string, so level 2 sends nothing until a real resource is configured. The only change to the app in this step is the wording of the ruleset justification; the code is unchanged from step 38.
