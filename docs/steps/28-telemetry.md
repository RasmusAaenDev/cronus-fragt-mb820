# Step 28: Log what happens

- `app/app.json`: `applicationInsightsConnectionString` (placeholder, see below).
- `CRFFreightMgt.Codeunit.al`: `LogShipmentCreated` logs `CRF-0003` after a shipment is created from a sales shipment.
- `CRFUpdateStatus.Codeunit.al`: counts successes and failures and logs `CRF-0004` once at the end of each round.
- `docs/runbooks/telemetry.md`: event table, privacy notes, the KQL query.

| Checklist item | Where |
|---|---|
| `applicationInsightsConnectionString` in app.json | Present, but a placeholder: no Azure resource exists here. Replace it with the real connection string. |
| Events SystemMetadata, ExtensionPublisher, each id in one place | Yes; ids CRF-0001..0004 each appear in exactly one call. CRF-0003/0004 instead of the workbook's CRF-0002/0003, because CRF-0002 was already taken (step 21). |
| PascalCase dimensions, no customer data | `ShipmentSystemId`, `Carrier`, `Succeeded`, `Failed`; counts formatted with format 9 so they are culture independent. |
| KQL query on traces, three (here four) events, carrier from `alCarrier` | Runbook. |
| Events appear in Application Insights after posting and polling | Not done: needs a sandbox and an Application Insights resource. |

`scripts/compile.sh app`: 0 errors, 0 warnings.
