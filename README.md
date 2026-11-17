# Step 25: Tell the webshop when a shipment changes

Cronus Fragt · MB-820 workbook · Build the solution › Report and API pages

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> The webshop asks us every five minutes whether anything has happened to the shipments, even when nothing has.
> That must be doable in a smarter way. Can't Business Central just notify the webshop when a shipment changes,
> so the customer quickly gets told that the package has been sent?

## Your task

Let the webshop subscribe to changes on CRF Shipment API with an API subscription (a webhook). Set up a test receiver at an HTTPS address of your own that answers Business Central's validation request, create the subscription for the shipments resource from a REST client, change the status of a shipment, and check that the receiver gets a notification and can read the shipment back. Write down for the webshop team how a subscription is created, renewed and removed. Then compare it with an external business event that CRF Freight Mgt could raise when a shipment's status changes, and tell Mette in two sentences which one you recommend for now and why.

## Checklist

- [ ] The subscription is created with a POST to .../api/cronus/freight/v1.0/subscriptions whose resource is the shipments path of the same publisher, group and version.
- [ ] The test receiver returns the validationToken with status 200 during the handshake, and the subscription appears in a GET on subscriptions with its expirationDateTime.
- [ ] After a status change, the receiver gets a notification with changeType updated and the shipment's resource, and a GET on that resource returns the new status.
- [ ] Your note for the webshop team says the subscription expires after three days unless it is renewed with PATCH, which repeats the handshake, and that DELETE removes it.
- [ ] Your comparison names the attribute that publishes an external business event, says where its payload comes from and notes that Learn marks the feature as preview.

## In this branch

- [Notes for this step](docs/steps/25-webhooks.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Changes since the previous step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/24-report-and-api-pages/an-odata-action-and-read-scale-out...25-report-and-api-pages/tell-the-webshop-when-a-shipment-changes)
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/webhooks-and-business-events

---

[← Step 24](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/24-report-and-api-pages/an-odata-action-and-read-scale-out/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 26 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/26-link-to-standard-business-central/give-customers-a-default-carrier/README.md)
