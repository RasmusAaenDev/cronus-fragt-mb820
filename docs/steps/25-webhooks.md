# Step 25: Tell the webshop when a shipment changes

This step produces documentation only; no AL object was added or changed, and the object list is unchanged (an external business event would need an extra `EventCategory` enum extension, which is not in the object list, and the recommendation is not to build it now). Deliverable: `docs/runbooks/webshop-webhooks.md` (webshop team note, comparison, note for Mette).

| Checklist item | Where |
|---|---|
| Subscription POSTed to `.../cronus/freight/v1.0/subscriptions` with the shipments resource | Runbook, "Create a subscription". |
| Receiver returns `validationToken` with 200; GET shows `expirationDateTime` | Runbook, steps 1-3. |
| Notification with `updated` and the resource; GET returns the new status | Runbook, "Receive a notification". |
| Expires after three days unless PATCH (repeats handshake); DELETE removes | Runbook, "Renew and remove". |
| Comparison names the attribute, payload source, preview status | Runbook table: `[ExternalBusinessEvent]`, payload = procedure parameters, preview. |

The page `CRF Shipment API` already uses `ODataKeyFields = SystemId` (no composite key), so it is webhook-capable without changes.

Could not be done here: the test receiver was not set up, no subscription was created, no status change was made and no notification was received. That needs a sandbox, a public HTTPS endpoint and a REST client. The runbook is written from the workbook text and has not been checked against Learn or a live environment from this machine. `scripts/compile.sh app`: 0 errors (no code change).
