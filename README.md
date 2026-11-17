# Step 28: Log what happens

Cronus Fragt · MB-820 workbook · Build the solution › Link to standard Business Central

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> When something goes wrong with the freight, I don't want to hear about it first when a customer calls and asks
> for their package. Can we keep an eye on how many shipments are being created, and whether the updates from
> the carriers are failing? But our customers' names and addresses must not be sent anywhere, they should stay
> with us.

## Your task

Make Cronus Fragt send its own telemetry to Application Insights. Create an Application Insights resource in Azure (or reuse one) and add applicationInsightsConnectionString to app.json, as the phase 2 design says. Next to CRF-0001 from module 3c, log CRF-0002 in CreateShipmentFromSalesShipment when a shipment is created from a posted sales shipment, and CRF-0003 at the end of each polling round in CRF Update Status with the number of shipments that succeeded and failed. Use Session.LogMessage with a unique event id, a message in Learn's "Object ActionInPastTense" pattern, a verbosity, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher and custom dimensions with PascalCase names, and keep customer data out as module 3c does. Then write a KQL query in the Logs of the Application Insights resource that lists the three events of the last day with their carrier and counts.

## Checklist

- [ ] app.json has applicationInsightsConnectionString with the connection string of your Application Insights resource.
- [ ] CRF-0002 and CRF-0003 are logged with DataClassification::SystemMetadata and TelemetryScope::ExtensionPublisher, and each event id is used in one place only.
- [ ] The custom dimensions have PascalCase names without spaces and contain no shipment number, customer name, address or error text.
- [ ] The KQL query reads the traces table, filters customDimensions.eventId on the three CRF events and shows the carrier from customDimensions.alCarrier.
- [ ] After posting a sales shipment and running the polling, the events appear in Application Insights, allowing a few minutes for them to arrive.

## In this branch

- [Notes for this step](docs/steps/28-telemetry.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Changes since the previous step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/27-link-to-standard-business-central/create-a-shipment-when-a-sales-shipment-is-posted...28-link-to-standard-business-central/log-what-happens)
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/telemetry

---

[← Step 27](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/27-link-to-standard-business-central/create-a-shipment-when-a-sales-shipment-is-posted/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 29 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/29-link-to-standard-business-central/poll-carriers-with-a-job-queue-entry/README.md)
