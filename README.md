# Step 29: Poll carriers with a job queue entry

Cronus Fragt · MB-820 workbook · Build the solution › Link to standard Business Central

**[See what this step changed: diff against step 28](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/55549a66d0bcfcba0430d20bcd5ed0d024738bc3...c9030446b32e5f683b9fe2a24d58836266eccdf9)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> Now the tracking status should update itself, as we talked about. It can happen a couple of times an hour
> during our opening hours on weekdays, but not at night when nobody is looking. If the carrier's system is
> down for half an hour, it should just try again a bit later instead of stopping completely. And write down
> how it's done, so our administrator can set it up again in the real company.

## Your task

**What you hand in:** A written settings sheet for Cronus's administrator with the job queue entry's settings, and the entry itself scheduled in the sandbox. The settings are not AL code.

Schedule CRF Update Status (codeunit 50103 from module 3c) with a recurring job queue entry in the sandbox, and write the steps down for Cronus's administrator.

**The settings sheet covers**

- Object type and id, and a description.
- Recurrence on weekdays during working hours with an interval agreed with Mette.
- A job queue category so two CRF entries can't run at the same time.
- Maximum No. of Attempts and Rerun Delay (sec.) for errors that stop the whole round.
- Set Status to Ready.

**Do this**

1. Schedule the entry in the sandbox and write the settings down.
2. Decide which user sets the entry to Ready and make sure that user has CRF Freight Basic, which also reads Shipping Agent, where each shipping agent's carrier and API address are.
3. Remove the temporary test action from module 3c.
4. Let the entry run and check the job queue log entries.
5. Check that a shipment tracking record whose carrier fails is reported in telemetry while the entry itself keeps its schedule.

**Keep in mind**

- A carrier that is down doesn't fail the entry: CRF Update Status catches the error of each shipment tracking record, and the next recurring run asks again, which is what answers Mette's wish that it tries again a little later.

## Checklist

- [ ] A job queue entry runs Object Type Codeunit with Object ID 50103 CRF Update Status, is recurring, and runs on weekdays in working hours at the interval agreed with Mette.
- [ ] The entry has a job queue category, a Maximum No. of Attempts and a Rerun Delay (sec.), and your notes say that the last two cover errors that stop the whole round, while a down carrier waits for the next recurring run.
- [ ] The entry was set to Ready by a user who has the CRF Freight Basic permission set, and your notes name that user.
- [ ] After a run the Log Entries show a successful run, and a shipment tracking record whose carrier fails is logged as CRF-0002 instead of putting the entry in Error.
- [ ] The temporary test action from module 3c is removed.

## In this branch

- [Notes for this step](docs/steps/29-job-queue.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/55549a66d0bcfcba0430d20bcd5ed0d024738bc3...c9030446b32e5f683b9fe2a24d58836266eccdf9): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/job-queue

---

[← Step 28](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/28-link-to-standard-business-central/log-what-happens/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 30 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/30-link-to-standard-business-central/test-it-with-the-test-framework/README.md)
