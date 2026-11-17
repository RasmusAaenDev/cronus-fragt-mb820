# Step 19: Call the carrier's service

Cronus Fragt · MB-820 workbook · Build the solution › Carriers and the outbound API

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> The carriers can tell us where the packages are if we ask their system. Today one of our people sits and looks
> it up on their website, package by package. Can't Business Central ask them itself? And if their system has a
> bad day, it must not make ours hang.

## Your task

Replace the placeholder GetStatus in CRF Carrier A with a call to Carrier A's status service. The service is fictional, made up for this exercise: there is no real Carrier A, so point API Base URL in CRF Freight Setup to a test endpoint of your own or a mock (for example https://carrier-a.example.com/api, a reserved example domain) and assume this contract: GET {API Base URL}/shipments/{Tracking No.}/status answers with JSON such as {"trackingNo": "CA123", "status": "in_transit"}, where status is booked, in_transit or delivered. Build the request with HttpRequestMessage, send it with HttpClient.Send, set a timeout, check both the return value of Send and IsSuccessStatusCode, read the body into a JsonObject and map status to CRF Shipment Status. Retry a few times with a pause when the request fails or the service answers 429, 502, 503 or 504. Turn on Allow HttpClient Requests for the extension, then test Update Status on a shipment with a tracking number.

## Checklist

- [ ] GetStatus builds the URL from API Base URL in CRF Freight Setup and the shipment's Tracking No., and fails with a clear error when either is blank.
- [ ] The code sets a timeout on the HttpClient and checks the Boolean returned by Send before it touches the response.
- [ ] A response outside 200-299 raises an error with the status code and reason phrase, and the body is read only for a successful response.
- [ ] The JSON is read with JsonObject.ReadFrom and Get, an unexpected body or status value gives a readable error, and the text is mapped to Booked, In Transit or Delivered.
- [ ] Allow HttpClient Requests is turned on for Cronus Fragt in Extension Settings, and Update Status changes the status of a test shipment.

## In this branch

- [Notes for this step](docs/steps/19-carrier-http.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Changes since the previous step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/18-carriers-and-the-outbound-api/a-facade-codeunit...19-carriers-and-the-outbound-api/call-the-carrier-s-service)
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/http-client

---

[← Step 18](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/18-carriers-and-the-outbound-api/a-facade-codeunit/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 20 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/20-carriers-and-the-outbound-api/keep-the-api-key-out-of-the-table/README.md)
