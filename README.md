# Step 20: Call the carrier's service

Cronus Fragt · MB-820 workbook · Build the solution › Carriers and the outbound API

**[See what this step changed: diff against step 19](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/4a06cc171b5c1f811f6f5a59d8f6bb6a16194151...3c807bedc3fed6fb672f94f9bf68eb603d3a46a4)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> The shipping agents can tell us where the packages are if we ask their system. Today one of our people sits
> and looks it up on their website, package by package. Can't Business Central ask them itself? And if their
> system has a bad day, it must not make ours hang.

## Your task

Replace the placeholder GetStatus in CRF Carrier A with a real call to the carrier's status service, at the address set on the shipping agent, built with care for failures.

**The service is fictional**

- There is no real Carrier A. On the Shipping Agents page, set API Base URL on the DHL shipping agent (Carrier A since step 13) to the mock service at https://freight-mock.sekvens.tools/carrier-a, or to a test endpoint of your own (for example https://carrier-a.example.com/api, a reserved example domain).
- Assume this contract: GET {API Base URL}/shipments/{Package Tracking No.}/status answers with JSON such as {"trackingNo": "CA123", "status": "in_transit"}, where status is booked, in_transit or delivered. The path is the carrier's own API, so it keeps the carrier's word "shipments".

**The mock service**

- The API key is cronus-demo-key. A missing or wrong key answers 401; the next step sends the key.
- A package tracking number that starts with CA moves from booked to in_transit after a minute and to delivered after three, counted from the first call. Any other tracking number answers 404.
- Test the failure paths with these tracking numbers: CA-FAIL-429 (429 twice, then in_transit), CA-FAIL-503 (always 503), CA-SLOW (answers after 35 seconds, longer than the timeout), CA-BADJSON, CA-NOSTATUS, CA-UNKNOWNSTATUS and CA-NOTFOUND (404).
- The home page of the mock lists all of it.

**Do this**

1. In GetStatus, read the record's shipping agent and build the URL from its CRF API Base URL and the record's Package Tracking No.
2. Build the request with HttpRequestMessage and send it with HttpClient.Send.
3. Set a timeout.
4. Check both the return value of Send and IsSuccessStatusCode.
5. Read the body into a JsonObject and map status to CRF Tracking Status.
6. Retry a few times with a pause when the request fails or the service answers 429, 502, 503 or 504.
7. Turn on Allow HttpClient Requests for the extension, then run Update Status on a DHL shipment tracking record with a package tracking number such as CA-BOOKED. Until the next step sends the key, the mock answers 401, and the error details show it.

## Checklist

- [ ] GetStatus reads the Shipping Agent of the record, builds the URL from its CRF API Base URL and the record's Package Tracking No., and fails with a clear error when either is blank.
- [ ] The code sets a timeout on the HttpClient and checks the Boolean returned by Send before it touches the response.
- [ ] A response outside 200-299 raises an error with the status code and reason phrase, and the body is read only for a successful response.
- [ ] The JSON is read with JsonObject.ReadFrom and Get, an unexpected body or status value gives a readable error, and the text is mapped to Booked, In Transit or Delivered.
- [ ] Allow HttpClient Requests is turned on for Cronus Fragt in Extension Settings, and Update Status on a DHL record reaches the mock, whose 401 answer shows in the error details until the key is sent.

## In this branch

- [Notes for this step](docs/steps/20-carrier-http.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/4a06cc171b5c1f811f6f5a59d8f6bb6a16194151...3c807bedc3fed6fb672f94f9bf68eb603d3a46a4): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/http-client

---

[← Step 19](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/19-carriers-and-the-outbound-api/a-facade-codeunit/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 21 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/21-carriers-and-the-outbound-api/keep-the-api-key-out-of-the-table/README.md)
