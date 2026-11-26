# Step 06: Hook in with events, do not change standard code

Delivers `docs/design/03-events.md`: the layer model (System Application, Base Application, our extension), the extension points we use with publisher object and what we do there, why `OnAfterPostSalesDoc` fits, what Cronus Fragt publishes itself, and which objects are internal. I read the signatures of `OnAfterPostSalesDoc` (codeunit 80), `OnCompanyInitialize` (codeunit 2), `OnGetPerCompanyUpgradeTags` (codeunit 9999) and the existence of page 9006 (Order Processor Role Center) from the BC 28 symbols in the v1 work. The page extension on Shipping Agents is compiled in step 13.

| Checklist item | Where |
|---|---|
| Layers explained, base code is not modified | "The extension model". |
| Sales shipment hook names publisher codeunit and event, says why it fits | Table row 1 and "Why point 1 fits". |
| Carrier settings use a table extension on Shipping Agent and a page extension on Shipping Agents | Table rows for table extension 50100 and page extension 50101. |
| At least one own event named, internal objects named | "What we publish ourselves" and "Public surface and internal objects". |

Not verified: that `Access = Internal` carrier codeunits combine with a public enum and an interface; this is confirmed by the compiler in step 18, and the design says so. No AL changed; `scripts/compile.sh app` is still 0 errors. The document itself is rewritten for v2 separately from this note.
