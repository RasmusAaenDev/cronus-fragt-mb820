# Step 26: Tell the webshop when the tracking status changes

This step produces documentation only; no AL object was added or changed, and the object list is unchanged (an external business event would need an extra `EventCategory` enum extension, which is not in the object list at this point, and the recommendation is not to build it now). Deliverable: `docs/runbooks/webshop-webhooks.md` (webshop team note, comparison, note for Mette).

| Checklist item | Where |
|---|---|
| Subscription POSTed to `.../cronus/freight/v1.0/subscriptions` with the `shipmentTrackings` resource | Runbook, "Create a subscription". |
| Receiver returns `validationToken` with 200; GET shows `expirationDateTime` | Runbook, steps 1-3. |
| Notification with `updated` and the resource; GET returns the new status | Runbook, "Receive a notification". |
| Note for the webshop team: expires after three days unless PATCH (repeats handshake); DELETE removes | Runbook, "Renew and remove". |
| Comparison names the attribute, payload source, preview status | Runbook table: `[ExternalBusinessEvent]`, payload = procedure parameters, preview. |

The page `CRF Shipment Tracking API` already uses `ODataKeyFields = SystemId` (no composite key), so it is webhook-capable without changes. The resource in the subscription is the `shipmentTrackings` path of the same publisher, group and version as the API pages from step 24. A status change made by `UpdateStatusNoError` (step 19), by the job queue (step 22) or by `Book` (step 25) is a modification of the shipment tracking header, so the subscription sees it.

For the comparison: the business event the course builds later is called `trackingstatuschanged` ('Tracking status changed', payload trackingId, status, trackingNumber). It is added to `CRF Freight Mgt` in step 38, where the Power Automate flow needs it, and not in this step. The text of the runbook in this tree may still use the earlier names; it is rewritten separately, so refer to it as the runbook and not by its wording.

Could not be done here: the test receiver was not set up, no subscription was created, no status change was made and no notification was received. That needs a sandbox, a public HTTPS endpoint and a REST client. The runbook is written from the workbook text and has not been checked against Learn or a live environment from this machine. `scripts/compile.sh app`: 0 errors with the Business Central 28 compiler (no code change).
