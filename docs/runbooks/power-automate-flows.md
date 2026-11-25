# Runbook: Power Automate flows for late shipments

Status: **written, not built.** Power Automate flows cannot be created from here (no tenant, no license, no Business Central environment). The flows below are settings to type in, not exported flows; no flow file exists. What *is* real and compiled is the AL side: the external business event `shipmentstatuschanged` (see "What was added to the app").

## What was added to the app

- `app/src/Freight/CRFEventCategory.EnumExt.al`: enum extension 50100 `CRF Event Category` adds the event category `CRF Freight` ("Cronus Freight").
- `CRF Freight Mgt` (codeunit 50100): empty local procedure `ShipmentStatusChanged(shipmentId: Guid; status: Enum "CRF Shipment Status"; trackingNumber: Text[50])` with `[ExternalBusinessEvent('shipmentstatuschanged', ...)]` and `[RequiredPermissions]` read on `CRF Shipment Header`. It is called after the status is saved in `UpdateStatusNoError` (carrier polling, job queue) and in `BookShipment`. Step 25 had only compared it with webhooks; this step builds it because flow 2 needs it.
- The payload carries only the shipment id, status and tracking number: no customer name or address.
- Compiled with 0 errors and 0 warnings; **never raised in a real environment**.

## Prerequisites

- A Power Automate license that includes premium connectors (the Dynamics 365 Business Central connector is premium).
- The connection signs in as a user (the connector does not support service-to-service authentication). That user needs the permission set `CRF Freight Basic` so the API pages can be read, and, for the event, the permission set `Ext. Events - Subscr` and read access to `CRF Shipment Header` (the event's `RequiredPermissions`).
- A Teams team/channel for customer service and an Outlook mailbox for the sender.
- The business event trigger is **preview** and may change. Notifications are sent only after the transaction is committed, never if it is rolled back, and later if the transaction is long. A status change from a polling round therefore reaches the flow after the round's transaction ends, and Power Automate then runs the flow on its own timing: expect minutes, not seconds.
- Each Business Central step needs the environment and company set again.

## Flow 1: late shipments to Teams (settings)

| Step | Setting |
|---|---|
| Trigger: Recurrence | Frequency Week, interval 1, on Monday to Friday, 08:00, time zone Romance Standard Time |
| Find records (V3) | Environment `<production>`, Company `<Cronus>`, API category `cronus/freight/v1.0`, Table name `shipments`, Filter Query `status eq '<In Transit as a GET shows it>' and postingDate lt @{formatDateTime(addDays(utcNow(), -3), 'yyyy-MM-dd')}` |
| Condition | the list of records is not empty |
| Post message in a chat or channel (Teams) | Post as Flow bot, in Channel, team Customer service. One message per run, one line per shipment: `number`, `carrier`, `trackingNumber` (use Select/Join, not a loop that posts per shipment) |

Notes: filter on `In Transit` only. Open and Booked shipments have not been sent, and Delivered ones are fine, so `status ne 'Delivered'` would be wrong. How the status value looks in OData (the enum value has a space) was **not checked**: do a GET on `.../api/cronus/freight/v1.0/companies({id})/shipments` first and copy the value from the response. The field names (`number`, `carrier`, `status`, `trackingNumber`, `postingDate`) are taken from page 50105 (`CRF Shipment API`).

## Flow 2: late shipment delivered, mail to Mette (settings)

| Step | Setting |
|---|---|
| Trigger: When a business event occurs (V3) | Environment `<production>`, Company `<Cronus>`, Event `Shipment status changed` (category Cronus Freight) |
| Get record (V3) | API category `cronus/freight/v1.0`, Table `shipments`, Row id = `shipmentId` from the payload |
| Condition | `status` is Delivered and `postingDate` is more than three days before the event's timestamp (or `utcNow()`) |
| Send an email (V2) (Office 365 Outlook) | To Mette; subject "Late shipment delivered"; body: `number`, `carrier`, `trackingNumber` only |

The event must appear in the connector's event list after the app 1.2.0.0 is installed; if it does not, check the `Ext. Events - Subscr` permission of the connection user.

## Test in the sandbox (to do by a person)

1. Install the app, run the setup guide, create a shipment for a customer, set its posting date 4 days back and status In Transit (directly in the table or via a carrier response).
2. Run flow 1 manually: one Teams message with that shipment. Run it with no late shipments: no message.
3. Change that shipment to Delivered (polling or manually through the carrier status update): flow 2 should mail Mette. Change a young shipment to Delivered: no mail.
4. Check that the messages contain no customer data.

## For Mette

Customer service gets a list of late parcels in Teams every weekday morning, and you get a mail when one of them has arrived. The mail can come a little after the delivery is registered, not to the second.
