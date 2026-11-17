# Part 3: hooking in with events, not modifications

## The extension model

Business Central is built in layers. The **System Application** is a set of open-source modules with technical, ERP-agnostic functionality (for example number series handling, guided experience, upgrade tags, isolated storage helpers). The **Base Application** is the business logic: sales, purchasing, posting, customers. **Cronus Fragt** depends on both and adds to them. In Business Central online only extensions run, so we never edit Microsoft's code. We use extension objects (table extension, page extension, enum and permission set extensions) to add to standard objects, and events to react to what standard code does.

Why this answers "does it break when Microsoft updates Business Central": events separate our logic from the business logic, so Microsoft can change Sales-Post while our subscriber keeps working, as long as the event is still published. Microsoft keeps published events stable for that reason. We still own our extension: it has to compile against the next version before the environment is updated, and the update checks that and warns the administrators in advance. Our own tests (step 30) are the early warning on our side.

## Extension points we use

Signatures below were read from the BC 28 symbol package, not from memory.

| # | Publisher object | Event or extension object | What Cronus Fragt does there |
|---|---|---|---|
| 1 | Codeunit 80 `Sales-Post` | `OnAfterPostSalesDoc` (integration event). Parameters: `var SalesHeader`, `var GenJnlPostLine`, `SalesShptHdrNo`, `RetRcpHdrNo`, `SalesInvHdrNo`, `SalesCrMemoHdrNo`, `CommitIsSuppressed`, `InvtPickPutaway`, `var CustLedgerEntry`, `WhseShip`, `WhseReceiv`, `PreviewMode` | Subscriber in `CRF Sales Post Subs` (50104). Exit if `PreviewMode` or `SalesShptHdrNo` is blank; otherwise call `CRF Freight Mgt` to create a shipment. |
| 2 | Table `Customer` | Table extension `CRF Customer` (50100) | Adds `CRF Default Carrier`. |
| 3 | Page `Customer Card` (21) | Page extension `CRF Customer Card` (50101) | Shows `CRF Default Carrier` at the end of the General FastTab. |
| 4 | Page `Customer List` (22) | Page extension `CRF Customer List` (50100) | The hello action from step 03. |
| 5 | Page `Order Processor Role Center` (9006) | Page extension `CRF Order Processor RC` (50102) | Adds the `CRF Freight Activities` part. |
| 6 | Codeunit 2 `Company-Initialize` | `OnCompanyInitialize` | Subscriber in `CRF Install` (50108): create the setup record in companies created later. |
| 7 | Codeunit 9999 `Upgrade Tag` | `OnGetPerCompanyUpgradeTags` | Subscriber in `CRF Upgrade Tags` (50110): registers our tag for new companies. |

Also standard objects we use through their public API and not through events: Guided Experience (assisted setup registration, in `CRF Assisted Setup Subs`), No. Series, Isolated Storage, Session telemetry.

### Why point 1 fits

`OnAfterPostSalesDoc` is raised after the whole posting is done and carries the number of the posted sales shipment. An after-the-operation event is the kind of event that is stable and high value: we do not interfere with posting, we only read the result. Our work happens after the posting is complete, so an error in our code cannot leave posting half done (a subscriber error would still roll back the posting transaction, which is why the subscriber must stay small and the shipment creation must be defensive). We avoid before-events and per-line hook events, which are tied to implementation details.

## What we publish ourselves

| Event | Publisher | Raised when | For whom |
|---|---|---|---|
| `OnAfterCreateShipmentFromSalesShipment` (integration event, parameters: `var CRFShipmentHeader`, `SalesShipmentHeader` number) | `CRF Freight Mgt` (50100) | After a shipment was created from a posted sales shipment | Another extension that wants to add data to the shipment without changing Cronus Fragt |
| External business event "Shipment status changed" | `CRF Freight Mgt` | Status of a shipment changes (compared with API webhooks in step 25) | Power Automate and similar (step 38) |

## Public surface and internal objects

| Object | Access | Why |
|---|---|---|
| `CRF Freight Mgt` (50100) | Public | The one entry point other extensions may call. |
| Enum `CRF Carrier`, enum `CRF Shipment Status` | Public, extensible | Other extensions add carriers and statuses. |
| Interface `CRF ICarrier` | Public | Contract for a new carrier. |
| `CRF Carrier A`, `CRF Carrier B`, `CRF No Carrier` | `Access = Internal` | Implementation details; callers go through the interface. The compiler must confirm that this works with the public enum (Learn does not spell it out), and the interface procedures must be public. |
| `CRF Sales Post Subs`, `CRF Assisted Setup Subs`, `CRF Install`, `CRF Upgrade`, `CRF Upgrade Tags`, `CRF Update Status` | Internal | Subscribers and runners nobody else should call. |
| Tables and pages | Public by default | The webshop and users need them; the permission set is the security boundary. |

Access modifiers shape our API at compile time and are not a security boundary. Security is the `CRF Freight` permission set.
