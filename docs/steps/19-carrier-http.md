# Step 19: Call the carrier's service

Replaces the placeholder `GetStatus` in `CRF Carrier A` (`app/src/Carrier/CRFCarrierA.Codeunit.al`) with an HTTP call. No new objects, so `object-ids.md` is unchanged except that telemetry event `CRF-0001` is now used here.

Contract (fictional, from the workbook): `GET {API Base URL}/shipments/{Tracking No.}/status` answers `{"trackingNo": "...", "status": "booked|in_transit|delivered"}`.

| Checklist item | Where |
|---|---|
| URL from API Base URL and Tracking No.; clear error when blank | `GetStatus`: `FreightSetup.TestField("API Base URL")`, `ShipmentHeader.TestField("Tracking No.")`, `StatusUrl`. |
| Timeout; Send's Boolean checked before the response is used | `Client.Timeout := 30000`; `SendWithRetry` tests the result of `Client.Send`. |
| Non-2xx raises an error with code and reason; body read only on success | `IsSuccessStatusCode` check with `HttpStatusCode`/`ReasonPhrase` before `Content().ReadAs`. |
| JsonObject.ReadFrom/Get, readable errors, mapping to enum | `Body.ReadFrom`, `Body.Get('status')`, `StatusFromText` (unknown value gives an error). |
| Allow HttpClient Requests on; test shipment changes status | **Not done here**, see below. |

Retry: up to three attempts with a 2 s, then 4 s pause (`Sleep`), a fresh request message per attempt, for a failed `Send` or status 429/502/503/504. If the service is unreachable after the last attempt, telemetry event `CRF-0001` (SystemMetadata, carrier only, no shipment data) is logged before the error.

Not verified, and not runnable here: this code is written against the endpoint in `CRF Freight Setup`."API Base URL" and compiles (`scripts/compile.sh app`, 0 errors), but it has never been executed. No real or mock carrier was called (there is no network access, and the carrier is fictional). Remaining for a person in a sandbox: set API Base URL to a mock (for example `https://carrier-a.example.com/api` pointing at a test service), turn on **Allow HttpClient Requests** for Cronus Fragt under Extension Management, Configure, and press Update Status on a shipment with a tracking number. The retry pauses block the session for up to six seconds per shipment, which is why the job queue codeunit in step 21 is the right place to call this.
