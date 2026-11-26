# Step 38: Notify when a shipment is late

Cronus Fragt · MB-820 workbook · Bonus: CI/CD and notifications · bonus

**[See what this step changed: diff against step 37](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/04ac4d324b2c17ce478d97fcd4140b6f7aff78e7...2063e9928a916ecb03505cf8bbdce99589332fe8)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> Customer service often only hears about a delayed package when the customer calls. Can we get a message in
> the customer service channel in Teams every morning with the shipments that still haven't been delivered
> three days after they were sent? And I'd like an email when such a delayed package finally arrives, so I can
> call the customer and say sorry.

## Your task

**What you hand in:** Two working flows tested in the sandbox, and written notes on the prerequisites and the delays to expect.

Build two Power Automate flows on Cronus Fragt's API from module 3d, so that customer service and Mette are told about late shipments.

**Flow 1: scheduled**

- It runs on weekday mornings.
- It finds the shipment tracking records in the shipmentTrackings entity set of cronus/freight/v1.0 that are still In Transit three days after their posting date.
- It posts them in customer service's Teams channel.

**Flow 2: triggered**

- It is triggered by the external business event Tracking status changed (trackingstatuschanged from module 3d; add it as that step shows if you only compared it there).
- It reads the shipment tracking record.
- It e-mails Mette when a late shipment has been delivered.

**Do this**

1. Build both flows.
2. Put only the number of the shipment tracking record, its shipping agent code and the package tracking number in the messages (number, shippingAgentCode and trackingNumber in the API).
3. Test both in the sandbox.
4. Write down the prerequisites and the delays to expect.

## Checklist

- [ ] The scheduled flow uses the Recurrence trigger and Find records (V3) on the shipmentTrackings table of the API category cronus/freight/v1.0 with a filter on status and postingDate, and posts one message per run that lists the late shipments.
- [ ] The second flow uses When a business event occurs (V3) on the Tracking status changed event, reads the shipment tracking record with Get record (V3) by the trackingId from the payload, and sends the e-mail only when the status is Delivered and the posting date is more than three days back.
- [ ] The messages contain the number, shipping agent code and package tracking number, and no customer name or address.
- [ ] Your notes list the prerequisites (a Power Automate license with premium connectors, a user with CRF Freight Basic, and for the event the Ext. Events – Subscr permission set) and say that the business event trigger is preview and that notifications are sent only after the transaction commits.

## In this branch

- [Notes for this step](docs/steps/38-power-automate-flow.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/04ac4d324b2c17ce478d97fcd4140b6f7aff78e7...2063e9928a916ecb03505cf8bbdce99589332fe8): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/power-automate-flow

---

[← Step 37](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/37-bonus-ci-cd-and-notifications/version-and-sign-the-app/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 39 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/39-bonus-ci-cd-and-notifications/watch-the-job-queue/README.md)
