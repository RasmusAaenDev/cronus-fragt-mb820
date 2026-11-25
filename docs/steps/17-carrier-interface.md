# Step 17: One interface for every carrier

Delivers the interface `CRF ICarrier` (`app/src/Carrier/CRFICarrier.Interface.al`), codeunits 50101 `CRF Carrier A`, 50102 `CRF Carrier B` and 50106 `CRF No Carrier` (same folder), and changes the existing enum 50100 `CRF Carrier` (`app/src/Setup/CRFCarrier.Enum.al`) to implement the interface. Values and ordinals are unchanged. The three codeunits are in the `CRF Freight Basic` permission set.

| Checklist item | Where |
|---|---|
| Interface with GetRate and GetStatus; both carriers implement it | `CRFICarrier.Interface.al`; `implements "CRF ICarrier"` in Carrier A and B. |
| Enum implements the interface, Implementation on A and B, ordinals unchanged | Enum file: `Implementation = "CRF ICarrier" = "CRF Carrier A"` on value 1, `... B` on value 2. |
| Blank value has an implementation, clear error | Enum property `DefaultImplementation` points to `CRF No Carrier`, whose procedures raise "Shipment %1 has no carrier...". |
| Interface variable instead of a case statement | Not used yet; the facade in step 18 does `Carrier := ShipmentHeader.Carrier`. |
| Compiles | `scripts/compile.sh app`: 0 errors, 0 warnings. |

Choices: Carrier A prices the shipment by total weight, Carrier B prices every package on its own (both from `CRF Carrier Rate`, whose key makes `FindFirst` return the lowest weight limit that fits). `GetStatus` is a placeholder that returns the stored status; step 19 replaces Carrier A's. `UnknownValueImplementation` is deliberately not set: pointing it at `CRF No Carrier` would give a misleading message for a carrier whose extension was uninstalled, and a dedicated codeunit would be an object outside the object list (id 50107 stays reserved).

Compile finding: `Access = Internal` codeunits behind a public, extensible enum compile without complaint (design part 3 left this to the compiler).

Not verified: runtime behaviour (rates, the error from the blank carrier) needs a sandbox with rate data.
