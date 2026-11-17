# Step 06: Hook in with events, do not change standard code

Delivers `docs/design/03-events.md`: the layer model (System Application, Base Application, our extension), the seven extension points we use with publisher object and what we do there, why `OnAfterPostSalesDoc` fits, what Cronus Fragt publishes itself, and which objects are internal. I read the signatures of `OnAfterPostSalesDoc` (codeunit 80), `OnCompanyInitialize` (codeunit 2), `OnGetPerCompanyUpgradeTags` (codeunit 9999) and the existence of pages 21, 22 and 9006 from the BC 28 symbols.

| Checklist item | Where |
|---|---|
| Layers explained, base code is not modified | "The extension model". |
| Sales shipment hook names publisher codeunit and event, says why it fits | Table row 1 and "Why point 1 fits". |
| Default carrier uses a table extension on Customer and a page extension on Customer Card | Rows 2 and 3. |
| At least one own event named, internal objects named | "What we publish ourselves" and "Public surface and internal objects". |

Not verified: that `Access = Internal` carrier codeunits combine with a public enum and an interface; this is confirmed by the compiler in step 17, and the design says so. No AL changed; `scripts/compile.sh app` is still 0 errors.
