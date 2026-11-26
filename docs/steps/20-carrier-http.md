# Step 20: Call the carrier's service

Replaces the placeholder `GetStatus` in `CRF Carrier A` (`app/src/Carrier/CRFCarrierA.Codeunit.al`) with an HTTP call. No new objects, so `docs/design/object-ids.md` is unchanged except that telemetry event `CRF-0001` is now used here.

Contract (the mock carrier service, from the workbook): `GET {CRF API Base URL of the shipping agent}/shipments/{Package Tracking No.}/status` answers `{"trackingNo": "...", "status": "booked|in_transit|delivered"}`. The base URL is read from the record's shipping agent (field `CRF API Base URL` on the table extension, step 13), not from the freight setup. For the demo, DHL has `https://freight-mock.sekvens.tools/carrier-a`; package tracking numbers for Carrier A start with `CA`.

| Checklist item | Where |
|---|---|
| Reads the record's shipping agent, URL from `CRF API Base URL` and `Package Tracking No.`; clear error when either is blank | `GetStatus`: `ShippingAgent.Get(TrackingHeader."Shipping Agent Code")`, `ShippingAgent.TestField("CRF API Base URL")`, `TrackingHeader.TestField("Package Tracking No.")`, then `StatusUrl`. |
| Timeout; Send's Boolean checked before the response is used | `Client.Timeout := 30000`; `SendWithRetry` tests the result of `Client.Send`. |
| Non-2xx raises an error with code and reason; body read only on success | `IsSuccessStatusCode` check with `HttpStatusCode`/`ReasonPhrase` before `Content().ReadAs`. |
| JsonObject.ReadFrom/Get, readable errors, mapping to enum | `Body.ReadFrom`, `Body.Get('status', StatusToken)`, `StatusFromText` (unknown value gives an error). |
| Allow HttpClient Requests on; Update Status on a DHL record reaches the mock, whose 401 shows until the key is sent | **Not done here**, see below. The key header is added in step 21 (the comment in `SendWithRetry` marks the place), so until then the mock answers 401 and the error details show it. |

Retry: up to three attempts with a 2 s, then 4 s pause (`Sleep`), a fresh request message per attempt, for a failed `Send` or status 429/502/503/504. If the service is unreachable after the last attempt, telemetry event `CRF-0001` (SystemMetadata, dimension `Carrier` only, no shipment tracking data and no shipping agent code) is logged before the error.

Not verified, and not runnable here: this code compiles with the Business Central 28 compiler (`scripts/compile.sh app`, 0 errors), but it has never been executed. No mock or real carrier was called (there is no network access). Remaining for a person in a sandbox: set `CRF API Base URL` on the DHL shipping agent to the mock address, turn on **Allow HttpClient Requests** for Cronus Fragt under Extension Management, Configure, and press Update Status on a DHL shipment tracking record with a package tracking number such as `CA-BOOKED`. Until step 21 the answer will be 401. The retry pauses block the session for up to six seconds per record, which is why the job queue codeunit in step 22 is the right place to call this.
