# Step 20: Keep the API key out of the table

Delivers key handling in table 50100 `CRF Freight Setup` (`app/src/Setup/CRFFreightSetup.Table.al`), an API Key field on page 50100 (`CRFFreightSetup.Page.al`) and the key header in `CRF Carrier A`. No new objects, no new permissions (isolated storage needs none).

| Checklist item | Where |
|---|---|
| No key field; `IsolatedStorage.SetEncrypted` with `DataScope::Company`, locked key name | Table: `SetApiKey`, label `ApiKeyStorageKeyTok` (Locked). The table has the same four fields as before. |
| Getter returns SecretText; key reaches the request only through `HttpHeaders.Add(Text, SecretText)` | `GetApiKey() ApiKey: SecretText`; `Headers.Add('X-Api-Key', ApiKey)` in `SendWithRetry`. |
| Page field bound to a page variable, Masked, stored key never loaded | `field(ApiKey; ApiKeyText)` with `ExtendedDatatype = Masked`; `ShowApiKeyPlaceholder` shows only `********`. |
| New key replaces, cleared field deletes, page shows whether a key is stored | `SaveApiKey` (ignores the placeholder, otherwise `SetApiKey`); an empty SecretText deletes; `HasApiKey` drives the placeholder. |
| Note for Mette | Below. |

Choices: the typed Text is converted to SecretText inside a `[NonDebuggable]` procedure, as Learn recommends. Carrier A refuses to call the service when no key is stored (clear error pointing to the setup page); that is my reading of the contract, which the workbook does not state.

Note for Mette: The password is not kept in the setup table, because anyone who can read that table could read it, and hiding it on screen only changes how it is displayed, not where it sits. It is stored encrypted in a separate place that only Cronus Fragt can open, and the screen only shows dots.

Compile: `scripts/compile.sh app` 0 errors, 0 warnings. Not verified: that isolated storage round-trips and that the masked field behaves as described in the web client (needs a sandbox). The header is not sent anywhere, since the carrier call itself has not been run (see step 19).
