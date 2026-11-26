# Step 13: Extend the shipping agent

Delivers the carrier settings on the standard shipping agent, in three files: enum 50100 `CRF Carrier` (`app/src/Setup/CRFCarrier.Enum.al`: `Extensible = true`, values ' ', Carrier A, Carrier B; no `implements` yet), table extension 50100 `CRF Shipping Agent` on Shipping Agent (`app/src/ShippingAgent/CRFShippingAgent.TableExt.al`: field 50100 `CRF Carrier`, enum `CRF Carrier`, and field 50101 `CRF API Base URL`, Text[250], `ExtendedDatatype = URL`) and page extension 50101 `CRF Shipping Agents` on Shipping Agents (`app/src/ShippingAgent/CRFShippingAgents.PageExt.al`: both fields in `addlast(Control1)`, the repeater, each with `ApplicationArea` and a ToolTip). Both fields have `DataClassification = CustomerContent` and a plain caption (Carrier, API Base URL). There is no field for the API key: that is a secret and comes in step 21, per shipping agent, with a masked field on the same page extension. Customer is not extended, because it already has `Shipping Agent Code`.

| Checklist item | Where |
|---|---|
| Enum 50100 `CRF Carrier` extensible, values ' ', Carrier A, Carrier B, without implements | `CRFCarrier.Enum.al`. Step 18 adds `implements "CRF ICarrier"`. |
| Table extension 50100 with `CRF Carrier` and `CRF API Base URL`, Caption and CustomerContent, no key field | `CRFShippingAgent.TableExt.al`, fields 50100 and 50101. |
| Page extension 50101 adds both fields to the repeater, each with ApplicationArea and ToolTip | `CRFShippingAgents.PageExt.al`, `addlast(Control1)`. |
| New fields and controls carry the CRF affix | Field names `CRF Carrier`, `CRF API Base URL`; control names the same. |
| DHL on Carrier A with the mock address, another agent on Carrier B | Not done, needs a sandbox. Values: DHL, Carrier A, `https://freight-mock.sekvens.tools/carrier-a`; FEDEX, Carrier B, no address. |

The control name `Control1` was checked against the BC 28 symbols by the compile: `addlast(Control1)` on "Shipping Agents" compiles with 0 errors. Compile: `scripts/compile.sh app`, BC 28 compiler, 0 errors. The ids are marked built in `docs/design/object-ids.md` (enum 50100, table extension 50100, page extension 50101).

For Mette: the carrier settings go on the shipping agents she already has, because customers, orders and the posted shipments already point to them; a separate list of carriers would be a second list to keep in step with the first. A shipping agent without a web service keeps the blank carrier.

Not verified: that the fields show on the Shipping Agents page and that editing them works (needs a sandbox; editing needs modify access to Shipping Agent, which `CRF Freight Admin` gets in step 15). Setting up DHL and FEDEX in the sandbox was not done; if the Cronus company lacks them, create them on the Shipping Agents page.
