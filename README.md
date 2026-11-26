# Step 28: Log what happens

Cronus Fragt · MB-820 workbook · Build the solution › Link to standard Business Central

**[See what this step changed: diff against step 27](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/0239a52684bc13da616add7499bb2acea687cfd6...55549a66d0bcfcba0430d20bcd5ed0d024738bc3)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> When something goes wrong with the freight, I don't want to hear about it first when a customer calls and
> asks for their package. Can we keep an eye on how many shipment tracking records are being created, and
> whether the status updates from the carriers are failing? But our customers' names and addresses must not be
> sent anywhere, they should stay with us.

## Your task

**What you hand in:** A KQL query, saved as text, that lists the three events of the last day with their carrier and counts. The telemetry calls themselves are AL code.

Make Cronus Fragt send its own telemetry to Application Insights, and write a query that reads it back.

**Do this**

1. Create an Application Insights resource in Azure (or reuse one) and add applicationInsightsConnectionString to app.json, as the phase 2 design says.
2. Next to CRF-0002 from module 3c, log CRF-0003 in CreateTrackingFromSalesShipment when a shipment tracking record is created from a posted sales shipment, with the message 'Shipment tracking created from sales shipment'.
3. Log CRF-0004 at the end of each polling round in CRF Update Status, with the message 'Tracking status round finished' and the number of records that succeeded and failed.
4. Write a KQL query in the Logs of the Application Insights resource that lists the three events of the last day with their carrier and counts.

**Use**

- Session.LogMessage with a unique event id, a message in Learn's "Object ActionInPastTense" pattern, a verbosity, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher and custom dimensions with PascalCase names.
- The dimensions TrackingSystemId and Carrier, as CRF-0002 ('Tracking status update from the carrier failed') uses them. Carrier is the carrier implementation of the record's shipping agent, such as Carrier A, never the shipping agent code: that code is CustomerContent, like the record's number.
- Keep customer data out, as module 3c does.

## Checklist

- [ ] app.json has applicationInsightsConnectionString with the connection string of your Application Insights resource.
- [ ] CRF-0003 and CRF-0004 are logged with DataClassification::SystemMetadata and TelemetryScope::ExtensionPublisher, and each event id is used in one place only.
- [ ] The custom dimensions have PascalCase names without spaces and contain no shipment tracking number, shipping agent code, customer name, address or error text.
- [ ] The KQL query reads the traces table, filters customDimensions.eventId on the three CRF events and shows the carrier from customDimensions.alCarrier.
- [ ] After posting a sales shipment and running the polling, the events appear in Application Insights, allowing a few minutes for them to arrive.

## In this branch

- [Notes for this step](docs/steps/28-telemetry.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/0239a52684bc13da616add7499bb2acea687cfd6...55549a66d0bcfcba0430d20bcd5ed0d024738bc3): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/telemetry

---

[← Step 27](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/27-link-to-standard-business-central/create-shipment-tracking-when-a-sales-shipment-is-posted/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 29 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/29-link-to-standard-business-central/poll-carriers-with-a-job-queue-entry/README.md)
