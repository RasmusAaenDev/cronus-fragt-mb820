# Webshop: subscribing to shipment changes (webhook)

For the webshop team. Applies to the API `cronus/freight/v1.0`, resource `shipments` (page 50105). Written from the workbook and Learn; **not tried against a real environment**.

## Create a subscription

```http
POST https://api.businesscentral.dynamics.com/v2.0/{environment name}/api/cronus/freight/v1.0/subscriptions
Content-Type: application/json

{
    "notificationUrl": "https://{your receiver}/shipments",
    "resource": "/api/cronus/freight/v1.0/companies({company id})/shipments",
    "clientState": "a shared secret"
}
```

1. Business Central calls `notificationUrl` with `?validationToken=...` on the query string.
2. Your receiver must answer `200 OK` with the token as the body, within a few seconds. Only then is the subscription registered.
3. `GET .../subscriptions` lists it with its `expirationDateTime`.

## Receive a notification

A notification lists, per change, `subscriptionId`, `clientState`, `expirationDateTime`, `resource`, `changeType` (`created`, `updated`, `deleted`, or `collection` when more than 1,000 records change within the delay) and `lastModifiedDateTime`. Check `clientState` against your secret, then `GET` the `resource` to read the shipment (it contains the new status and tracking number). The notification does not contain the data.

- Business Central waits about 30 seconds after the first change, so several quick changes give one notification.
- If the receiver cannot be reached, Business Central retries for 36 hours when it answers 408, 429 or a 5xx code; any other error deletes the subscription.
- Changes made by users who cannot schedule job queues are only notified when a user who can makes another change to the same table. Test with the webshop's real user.
- A change to a package (`shipmentLines`) is not assumed to notify the shipment. Subscribe to `shipmentLines` too if the webshop needs package changes.

## Renew and remove

- A subscription **expires after three days** unless it is renewed. Renew with `PATCH .../subscriptions({id})` before `expirationDateTime`; the PATCH repeats the validation handshake, so the receiver must be up.
- `DELETE .../subscriptions({id})` removes it.

## Limits

Webhooks do not work for tables with composite keys (the shipment pages use `ODataKeyFields = SystemId`, so they are fine), temporary or system source tables, API queries and Job Queue Entry.

## Webhook or external business event?

| | API subscription (webhook) | External business event (`[ExternalBusinessEvent]`, preview) |
|---|---|---|
| Built in Cronus Fragt | Nothing: API pages are webhook-enabled | An empty procedure with the attribute in `CRF Freight Mgt`, a category value from an extended `EventCategory` enum, called after every status change (`UpdateStatusNoError`, `BookShipment`) |
| Payload | None, the receiver reads the resource | The procedure's parameters (for example shipment id, status, tracking number) |
| Subscribing | POST to `subscriptions`, renew every three days | `api/microsoft/runtime/v1.0/externaleventsubscriptions` or Power Automate; needs the Ext. Events - Subscr permission set |
| Status | Generally available | Marked as preview on Learn |
| Sent | After a delay, once per batch of changes | After commit, never on rollback |

`[BusinessEvent]` is a different thing: it publishes an AL event for other extensions and reaches no external system.

## Note for Mette

Business Central can now tell the webshop shortly after a shipment changes, so the webshop no longer has to ask every five minutes; the webshop only has to confirm every few days that it still wants the messages. I recommend this webhook for now because it needs no new code and is not preview, and a business event becomes interesting when the webshop wants a named "shipment sent" message with the data inside it.
