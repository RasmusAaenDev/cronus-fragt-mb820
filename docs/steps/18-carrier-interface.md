# Step 18: One interface for every carrier

Delivers the interface `CRF ICarrier` (`app/src/Carrier/CRFICarrier.Interface.al`), codeunits 50101 `CRF Carrier A`, 50102 `CRF Carrier B` and 50106 `CRF No Carrier` (same folder), and changes the existing enum 50100 `CRF Carrier` (`app/src/Setup/CRFCarrier.Enum.al`, created in step 13) to implement the interface. Values and ordinals are unchanged. The three codeunits are in the `CRF Freight Basic` permission set.

The enum is the value of the field `CRF Carrier` on the shipping agent (table extension 50100 `CRF Shipping Agent`). The interface takes the shipment tracking record as its parameter, because both carriers need its shipping agent to find the right rates.

| Checklist item | Where |
|---|---|
| Interface with GetRate and GetStatus taking a `CRF Shipment Tracking Header`; both carriers implement it | `CRFICarrier.Interface.al`; `implements "CRF ICarrier"` in Carrier A and B. |
| Enum implements the interface, Implementation on A and B, ordinals unchanged | Enum file: `Implementation = "CRF ICarrier" = "CRF Carrier A"` on value 1, `... B` on value 2; values 0, 1, 2 as in step 13. |
| Both carriers filter the rates on the record's Shipping Agent Code | `GetRate` in both codeunits: `CarrierRate.SetRange("Shipping Agent Code", TrackingHeader."Shipping Agent Code")` on `CRF Shipping Agent Rate`. |
| Blank value has an implementation, clear error | Enum property `DefaultImplementation` points to `CRF No Carrier`, whose procedures raise "Shipping agent %1 on shipment tracking %2 has no carrier. Choose a carrier on the shipping agent first." |
| Interface variable instead of a case statement | Not used yet; the facade in step 19 gets the agent's `CRF Carrier` value and assigns it to an `Interface "CRF ICarrier"` variable. |
| Compiles | `scripts/compile.sh app`: 0 errors with the Business Central 28 compiler. |

Choices: Carrier A prices the shipment by total weight, Carrier B prices every package on its own (both from `CRF Shipping Agent Rate`, whose key makes `FindFirst` return the lowest weight limit that fits). Two shipping agents that use the same carrier implementation therefore keep their own prices. `GetStatus` is a placeholder that returns the stored status; step 20 replaces Carrier A's. `UnknownValueImplementation` is deliberately not set: pointing it at `CRF No Carrier` would give a misleading message for a carrier whose extension was uninstalled, and a dedicated codeunit would be an object outside the object list (id 50107 stays reserved).

Compile finding: `Access = Internal` codeunits behind a public, extensible enum compile without complaint (design part 3 left this to the compiler).

Not verified: runtime behaviour (rates, the error from the blank carrier) needs a sandbox with rate data.
