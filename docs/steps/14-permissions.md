# Step 14: Permission sets and entitlements

Delivers permission set 50100 `CRF Freight` (`app/src/Permissions/CRFFreight.PermissionSet.al`): `Assignable = true`, caption "Cronus Freight", name of 11 characters. It grants execute on every table, page and codeunit built so far and read, insert, modify and delete on the data of the three tables (setup, shipment header, shipment line). Steps 15 and 16 add their objects to it.

| Checklist item | Where |
|---|---|
| Assignable, caption, name up to 20 characters | Top of the permission set file. |
| Every table has `table X` and `tabledata RIMD`, every page and codeunit has `X` | Tables 50100-50102, pages 50100-50104 (the guide included), codeunit 50105. Enums and the Hello page extension need no entry. |
| Assigned to a test user, Effective Permissions checked | Not done, needs a sandbox. |
| Note for Mette on license versus permission set | Below. |

Beyond the model answer: `tabledata Customer = R` (the shipment copies the ship-to address from the customer) and `tabledata "No. Series" = R` (the setup page and guide look up number series). Without direct read rights on these, a user holding only CRF Freight could not pick a customer or a series. No write rights to standard tables are given. The model answer also leaves the setup writable for everyone with the set (RIMD); as the workbook does, this solution keeps that, and a separate administrator set would be the next step in a real rollout.

For Mette: "Your Business Central license decides the outer limit of what a person may use. Inside that limit, the CRF Freight permission set is the key we hand out: whoever has it can work with shipments, and nobody else can. A user can do only what both the license and the assigned permission sets allow. Because we built the extension ourselves and do not sell it, there is no extra license to buy for it; the people who use it need a license that covers the standard functions they already use, such as customers and sales."

Entitlements: none added, because the app is not sold through Marketplace. Compile: `scripts/compile.sh app` 0 errors. The assignment to a test user and the Effective Permissions page were not checked (no sandbox). `object-ids.md`: permission set 50100 built.
