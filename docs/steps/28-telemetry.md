# Step 28: Log what happens

- `app/app.json`: `applicationInsightsConnectionString` (placeholder, see below).
- `CRFFreightMgt.Codeunit.al`: `LogTrackingCreated` logs `CRF-0003` after a shipment tracking record is created from a sales shipment.
- `CRFUpdateStatus.Codeunit.al`: counts successes and failures and logs `CRF-0004` once at the end of each round.
- `docs/runbooks/telemetry.md`: event table, privacy notes, the KQL query.

| Checklist item | Where |
|---|---|
| `applicationInsightsConnectionString` in app.json | Present, but a placeholder: no Azure resource exists here. Replace it with the real connection string. |
| Events SystemMetadata, ExtensionPublisher, each id in one place | Yes; ids CRF-0001..0004 each appear in exactly one call. CRF-0003/0004 instead of the workbook's CRF-0002/0003, because CRF-0002 was already taken (step 22). |
| PascalCase dimensions, no tracking number, shipping agent code or customer data | `TrackingSystemId` and `Carrier` on CRF-0003 (the same two on CRF-0002); `Succeeded` and `Failed` on CRF-0004, formatted with format 9 so they are culture independent. The tracking number and the shipping agent code are CustomerContent, so the record's SystemId and the carrier (`CarrierOf`, from the `CRF Carrier` field of the shipping agent) are logged instead. |
| KQL query on traces, three (here four) events, carrier from `alCarrier` | Runbook. |
| Events appear in Application Insights after posting and polling | Not done: needs a sandbox and an Application Insights resource. |

Difference from the workbook text: the workbook calls the two new events CRF-0002 and CRF-0003; in this repository they are CRF-0003 (tracking created) and CRF-0004 (round finished). The query lists CRF-0001 to CRF-0004.

Compiled with the Business Central 28 compiler (`scripts/compile.sh app`): 0 errors, 0 warnings. Nothing was run, so no event has been seen in Application Insights.
