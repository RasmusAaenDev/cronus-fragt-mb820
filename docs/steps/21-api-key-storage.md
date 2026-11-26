# Step 21: Keep the API key out of the table

Delivers key handling per shipping agent in table extension 50100 `CRF Shipping Agent` (`app/src/ShippingAgent/CRFShippingAgent.TableExt.al`), an API Key field on page extension 50101 `CRF Shipping Agents` (`CRFShippingAgents.PageExt.al`) and the key header in `CRF Carrier A`. No new objects, no new permissions (isolated storage needs none).

There is one key per shipping agent: the isolated storage key is the locked prefix `CRF-CarrierApiKey-` followed by the shipping agent's Code. Neither the standard Shipping Agent table nor `CRF Freight Setup` gets an API key field.

| Checklist item | Where |
|---|---|
| No key field; `IsolatedStorage.SetEncrypted` with `DataScope::Company`, locked prefix plus the agent's Code | Table extension: `CRFSetApiKey`, label `ApiKeyStoragePrefixTok` (Locked) and `ApiKeyStorageKey()` which appends `Rec.Code`. The extension has only the fields `CRF Carrier` and `CRF API Base URL`; the setup table has no key at all. |
| Getter returns SecretText; key reaches the request only through `HttpHeaders.Add(Text, SecretText)` | `CRFGetApiKey() ApiKey: SecretText` on the table extension; `Headers.Add('X-Api-Key', ApiKey)` in `SendWithRetry` in `CRFCarrierA.Codeunit.al`. |
| Page field bound to a page variable, Masked, stored key never loaded | `field(CRFApiKey; ApiKeyText)` with `ExtendedDatatype = Masked` on the Shipping Agents page extension; `ShowApiKeyPlaceholder` shows only `********`. |
| New key replaces, cleared field deletes, page shows whether a key is stored, two agents keep separate keys | `SaveApiKey` (ignores the placeholder, otherwise `Rec.CRFSetApiKey`); an empty SecretText deletes; `CRFHasApiKey` drives the placeholder in `OnAfterGetRecord`; the storage key contains the agent code. |
| `cronus-demo-key` on DHL, Update Status on a DHL record with a CA package tracking number changes its status | Not done, needs a sandbox and network access to the mock. |
| Note for Mette | Below. |

Choices: the typed Text is converted to SecretText inside a `[NonDebuggable]` procedure, as Learn recommends. Carrier A refuses to call the service when the shipping agent has no key stored (`CRFHasApiKey`, error "No API key for the carrier service is stored. Enter it on the Shipping Agents page."); that is my reading of the contract, which the workbook does not state. The procedures live on the table extension, so any code that has a shipping agent record can use them, and the page extension only calls them.

Note for Mette: "The password is not kept in the shipping agent table, because anyone who can read that table could read it, and hiding it on screen only changes how it is displayed, not where it sits. It is stored encrypted in a separate place that only Cronus Fragt can open, one key per shipping agent, and the screen only shows dots."

Compile: with the Business Central 28 compiler, 0 errors (`scripts/compile.sh app`). Not verified: that isolated storage round-trips, that the masked field behaves as described in the web client, and that the mock accepts the key (all need a sandbox). The header is not sent anywhere yet, since the carrier call itself has not been run (see step 20).
