# Step 26: Tell the webshop when the tracking status changes

Cronus Fragt · MB-820 workbook · Build the solution › Report and API pages

**[See what this step changed: diff against step 25](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/bf19057565fa848aad1aa01059e0e0824b26d254...6c16001e6aee8c6547ae461e2eca7116933b7f90)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> The webshop asks us every five minutes whether anything has happened to the shipments, even when nothing
> has. That must be doable in a smarter way. Can't Business Central just notify the webshop when the status of
> a shipment changes, so the customer quickly gets told that the package has been sent?

## Your task

**What you hand in:** Notes for the webshop team on how a subscription is created, renewed and removed, and two sentences for Mette recommending a webhook or an external business event for now. The subscription and the test receiver are things you set up.

Let the webshop subscribe to changes on CRF Shipment Tracking API with an API subscription (a webhook), and compare that with an external business event.

**Do this**

1. Set up a test receiver at an HTTPS address of your own that answers Business Central's validation request, or use the mock receiver at https://freight-mock.sekvens.tools/webhook/{your-inbox} with an inbox name of your own (letters, digits and dashes).
2. Create the subscription for the shipmentTrackings resource from a REST client.
3. Change the status of a shipment tracking record, and check that the receiver gets a notification and can read the record back. On the mock, open https://freight-mock.sekvens.tools/webhook/{your-inbox}/received in a browser to see what arrived.
4. Write down for the webshop team how a subscription is created, renewed and removed.
5. Compare it with an external business event, trackingstatuschanged, that CRF Freight Mgt could raise when the tracking status changes.
6. Tell Mette in two sentences which one you recommend for now and why.

## Checklist

- [ ] The subscription is created with a POST to .../api/cronus/freight/v1.0/subscriptions whose resource is the shipmentTrackings path of the same publisher, group and version.
- [ ] The test receiver returns the validationToken with status 200 during the handshake, and the subscription appears in a GET on subscriptions with its expirationDateTime.
- [ ] After a status change, the receiver gets a notification with changeType updated and the record's resource, and a GET on that resource returns the new status.
- [ ] Your note for the webshop team says the subscription expires after three days unless it is renewed with PATCH, which repeats the handshake, and that DELETE removes it.
- [ ] Your comparison names the attribute that publishes an external business event, says where its payload comes from and notes that Learn marks the feature as preview.

## In this branch

- [Notes for this step](docs/steps/26-webhooks.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/bf19057565fa848aad1aa01059e0e0824b26d254...6c16001e6aee8c6547ae461e2eca7116933b7f90): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/webhooks-and-business-events

---

[← Step 25](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/25-report-and-api-pages/an-odata-action-and-read-scale-out/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 27 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/27-link-to-standard-business-central/create-shipment-tracking-when-a-sales-shipment-is-posted/README.md)
