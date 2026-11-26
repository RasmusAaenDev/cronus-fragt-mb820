# Step 39: Watch the job queue

Cronus Fragt · MB-820 workbook · Bonus: CI/CD and notifications · bonus

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> It's really good that the status now updates itself. But how do we find out if it quietly stops working one
> day? I don't want to find out only when all the shipments have stood still for a week. Someone needs to be
> notified, and preferably before the warehouse notices.

## Your task

**What you hand in:** Two KQL queries with alerts, and a short note to Mette on who is told about what. The test is done in the sandbox.

Make sure someone hears about it when the status polling from module 3e goes wrong, on two levels.

**Level 1: the job queue entry for CRF Update Status (codeunit 50103) fails**

- Run the Set Up Job Queue Notifications guide so that the Cronus administrator is told.
- Write a KQL query and an alert on the job queue telemetry of the environment for that entry.

**Level 2: carriers fail inside a round, which doesn't fail the entry**

- Write an alert on Cronus Fragt's own telemetry from module 3e (CRF-0004 with failures).

**Test and tell**

1. Test the first level in the sandbox by making OnRun fail on purpose and letting the retries run out (AL0000JRG is only emitted when the entry fails for the last time).
2. Check the Job Queue Log Entries and the notification.
3. Remove the test code and set the entry to Ready again.
4. Tell Mette who is told about what.

## Checklist

- [ ] The Set Up Job Queue Notifications guide is completed with the people to notify and the way to notify them, and Job Queue Failed Notification is enabled on My Notifications for those users.
- [ ] After the forced failure, the Job Queue Log Entries show an entry with status Error and the error message for CRF Update Status, and the chosen notification arrived.
- [ ] A KQL query on the environment's Application Insights resource finds AL0000HE7 and AL0000JRG for alJobQueueObjectId 50103, and an alert rule uses it.
- [ ] A second KQL query on the extension's resource finds CRF-0004 events with alFailed above 0, and an alert rule uses it.
- [ ] The test error is removed, the entry is back to Ready, and your note for Mette says who is told about a stopped job and who about failing carriers.

## In this branch

- [Notes for this step](docs/steps/39-job-queue-monitoring.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/job-queue-monitoring

---

[← Step 38](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/38-bonus-ci-cd-and-notifications/notify-when-a-shipment-is-late/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md)
