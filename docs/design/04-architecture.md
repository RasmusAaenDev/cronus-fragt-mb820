# Part 4: architecture sketch

Business Central has three core parts: the web server that serves the web client, the Business Central server where AL code and scheduled tasks run, and the SQL database. Every Cronus Fragt component is an object in the extension and runs on the server. Everything else is drawn around it.

```mermaid
flowchart LR
    subgraph Users["Users (web client)"]
        U[Warehouse and sales users]
        A[Administrator]
    end
    WS[Webshop]
    CAR[Carriers' web services<br/>Carrier A, Carrier B]
    AI[(Application Insights)]

    subgraph BC["Business Central server (AL runs here)"]
        direction TB
        PG["Pages: CRF Shipment Tracking List/Card/Subform,<br/>Role Center cues"]
        SETUP[("CRF Freight Setup")]
        GUIDE["CRF Cronus Freight Wizard<br/>(Assisted Setup list)"]
        SA[("Shipping Agent + CRF Shipping Agent extension:<br/>CRF Carrier, CRF API Base URL, API key (isolated storage)")]
        SAPG["Shipping Agents page + CRF Shipping Agents extension"]
        API["API pages: CRF Shipment Tracking API,<br/>CRF Shipment Tracking Line API, CRF Tracking Status API"]
        SP["Sales-Post<br/>(standard)"]
        SUBS["CRF Sales Post Subs"]
        JQ["Job queue entry"]
        UPD["CRF Update Status"]
        MGT["CRF Freight Mgt (facade)"]
        ICAR{{"CRF ICarrier"}}
        CA["CRF Carrier A"]
        CB["CRF Carrier B"]
        NC["CRF No Carrier"]
        PS["Permission sets CRF Freight Basic and CRF Freight Admin"]
        DB[("SQL database:<br/>CRF tables and standard tables")]
    end

    U -->|"1 opens pages, user waits"| PG
    A -->|"2 runs guide, user waits"| GUIDE
    GUIDE -->|"3 writes on Finish"| SETUP
    A -->|"4 chooses carrier, address and key per shipping agent"| SAPG
    SAPG -->|"5 reads and writes"| SA
    PG -->|"6 Update Status action, user waits"| MGT
    WS -->|"7 REST/OData, webshop waits"| API
    API -->|"8 bound action book"| MGT
    U -->|"9 posts a sales shipment, user waits"| SP
    SP -->|"10 OnAfterPostSalesDoc event"| SUBS
    SUBS -->|"11 create shipment tracking"| MGT
    JQ -->|"12 starts on schedule, background session, nobody waits"| UPD
    UPD -->|"13 per shipment tracking record, failures caught"| MGT
    MGT -->|"14 looks up the record's shipping agent and reads its CRF Carrier"| SA
    MGT -->|"15 gets implementation from the Carrier enum value"| ICAR
    ICAR --> CA
    ICAR --> CB
    ICAR --> NC
    CA -->|"16 HTTPS GET status at the agent's API Base URL, caller waits for the answer"| CAR
    CB -->|"16 HTTPS"| CAR
    CA -.->|"17 reads URL and key of the agent"| SA
    MGT -->|"18 reads defaults"| SETUP
    MGT -->|"19 reads and writes"| DB
    API -->|"19 reads and writes"| DB
    MGT -.->|"20 Session.LogMessage, fire and forget"| AI
    UPD -.->|"20 Session.LogMessage"| AI
    PS -.->|"grants access to all CRF objects"| PG
```

## Arrows: who starts it and who waits

| # | From to | Started by | Does a user wait? |
|---|---|---|---|
| 1 | Users to pages | The user | Yes. |
| 2-3 | Administrator to guide to setup | The administrator; nothing is saved until Finish | Yes. |
| 4-5 | Administrator to the Shipping Agents page and the Shipping Agent extension | The administrator, per shipping agent | Yes. The API key goes to isolated storage, not to the table. |
| 6 | Shipment Tracking Card action to facade | The user (Update Status) | Yes, and the user also waits for the carrier call behind it. |
| 7-8 | Webshop to API pages, bound action | The webshop | The webshop waits. No carrier call is made from the API in this design (booking changes status only). |
| 9-11 | Posting to subscriber to facade | The user posting a sales shipment | Yes, but only for the creation of a local record. No carrier call happens during posting. |
| 12-13 | Job queue to Update Status to facade | The job queue scheduler, in a background session without user interface | No. A failing carrier is logged, and the next run asks again. |
| 14-15 | Facade to shipping agent, then to interface | The facade, from the tracking record's Shipping Agent Code and the `CRF Carrier` on that shipping agent | Same as the caller. |
| 16-17 | Carrier codeunit to carrier service | The carrier codeunit behind `CRF ICarrier` (not a page), with the API Base URL and key of that shipping agent | The calling session waits until the carrier answers, with a timeout and retries. |
| 18-19 | Facade and API pages to setup and database | The caller | Same as the caller. |
| 20 | Extension to Application Insights | The extension code | No. |

## Where the parts are

| Part | Place on the sketch |
|---|---|
| Setup | `CRF Freight Setup` table (default shipping agent, number series), filled by the setup page or by the assisted setup guide |
| Assisted setup | `CRF Cronus Freight Wizard`, registered by `CRF Assisted Setup Subs` |
| Shipping Agent extension | Table extension `CRF Shipping Agent` and page extension `CRF Shipping Agents` on the standard Shipping Agent table and page: carrier, API base URL and the API key (isolated storage) of each shipping agent |
| Carrier implementations | `CRF Carrier A`, `CRF Carrier B`, `CRF No Carrier` behind `CRF ICarrier`; the enum `CRF Carrier` on the shipping agent selects one |
| Facade | `CRF Freight Mgt`: the only public entry point; it finds the carrier through the record's shipping agent, and all callers (pages, API, subscriber, job) go through it |
| API pages | The webshop's door: shipment tracking, lines, read-only status |
| Status polling | A job queue entry running `CRF Update Status` in the background |
| Telemetry | `Session.LogMessage` events `CRF-0001` to `CRF-0004` (see `docs/runbooks/telemetry.md`) to the Application Insights resource named in `applicationInsightsConnectionString` in `app.json` |
| Permissions | Permission sets `CRF Freight Basic` (daily work, reads Shipping Agent) and `CRF Freight Admin` (includes Basic; setup, shipping agent rates and modify permission on Shipping Agent); the license decides what a user may do at most, the permission set what they may do |

## Things to remember

- **Outbound HTTP must be allowed.** Calls from the extension are blocked until **Allow HttpClient Requests** is turned on for Cronus Fragt in Extension Management (Configure). Without it the carrier call fails.
- Nothing about a carrier's service is in the setup table: the address is on the shipping agent, and the API key is stored in isolated storage (step 21), one per shipping agent, and sent as a header.
- A job queue entry must not show dialogs, and it fails only when the whole round fails.
- Telemetry carries no customer data: classify events as `SystemMetadata` and send only counts, the carrier and event ids (not the shipping agent code).
