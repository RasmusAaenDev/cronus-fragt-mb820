# Telemetry runbook

Cronus Fragt sends its own events with `Session.LogMessage`, classified `SystemMetadata`, scope `ExtensionPublisher`, so they go only to the Application Insights resource named in `app/app.json` (`applicationInsightsConnectionString`).

## Events

| Event id | Where | Verbosity | Custom dimensions |
|---|---|---|---|
| CRF-0001 | `CRF Carrier A`, carrier service could not be reached | Warning | (as built in step 19) |
| CRF-0002 | `CRF Update Status`, one shipment failed in the round | Warning | `ShipmentSystemId`, `Carrier` |
| CRF-0003 | `CRF Freight Mgt`, shipment created from a sales shipment | Normal | `ShipmentSystemId`, `Carrier` |
| CRF-0004 | `CRF Update Status`, end of a polling round | Normal, Warning if any failed | `Succeeded`, `Failed` |

The workbook names the shipment-created event CRF-0002 and the round event CRF-0003. This repo already used CRF-0002 for the per-shipment failure (step 21), and an event id must be used in one place only, so the new events are CRF-0003 and CRF-0004.

Privacy: no shipment number, customer name, address or error text. The shipment number is CustomerContent, so the record's SystemId is logged. Whether SystemId is acceptable is a judgement call for a privacy review.

## Before it works

`app.json` contains a placeholder (`InstrumentationKey=00000000-...`). Create an Application Insights resource and replace it with its connection string. Connection strings are not committed for real resources. Without a real one, nothing arrives.

## KQL (Logs of the Application Insights resource)

```kusto
traces
| where timestamp > ago(1d)
| where customDimensions.eventId in ('CRF-0001', 'CRF-0002', 'CRF-0003', 'CRF-0004')
| project timestamp, message, severityLevel,
    eventId = customDimensions.eventId,
    carrier = customDimensions.alCarrier,
    succeeded = customDimensions.alSucceeded,
    failed = customDimensions.alFailed,
    companyName = customDimensions.companyName
| order by timestamp desc
```

Allow a few minutes for events to arrive.
