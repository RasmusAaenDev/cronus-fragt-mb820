# Step 14: Permission sets and entitlements

Delivers two permission sets in `app/src/Permissions/`:

- 50100 `CRF Freight Basic` (`CRFFreightBasic.PermissionSet.al`), caption "Cronus Freight - Basic": for the warehouse and customer service. Execute on the tables, the shipment pages and the code they run; read, insert, modify and delete on shipments and shipment lines; read-only on the freight setup.
- 50101 `CRF Freight Admin` (`CRFFreightAdmin.PermissionSet.al`), caption "Cronus Freight - Admin": for the person who sets up freight. It includes `CRF Freight Basic` through `IncludedPermissionSets` and adds read, insert, modify and delete on the freight setup, the setup page 50100 and the guide 50104 `CRF Cronus Freight Wizard`, and codeunit 50105 `CRF Assisted Setup Subs`.

Both are `Assignable = true` and have names of 17 characters. Later steps add their objects to the set that fits: daily work (rates read-only, cue, report, API pages, carrier and status code) goes to Basic; maintenance (carrier rates RIMD, the rate import XMLport, install and upgrade codeunits) goes to Admin.

| Checklist item | Where |
|---|---|
| Assignable, caption, name up to 20 characters | Top of both permission set files. |
| Every table has `table X`; the data a role works with has the right `tabledata` rights; every page and codeunit has `X` | Basic: tables 50100-50102 X, setup R, shipment header and lines RIMD, pages 50101-50103. Admin: setup RIMD, pages 50100 and 50104, codeunit 50105. Enums and the Hello page extension need no entry. |
| Admin builds on Basic instead of repeating it | `IncludedPermissionSets = "CRF Freight Basic"` in `CRF Freight Admin`. |
| Assigned to test users, Effective Permissions checked | Not done, needs a sandbox: give one user Basic and one Admin, and check that only Admin can open the setup page and run the guide. |
| Note for Mette on license versus permission set | Below. |

Beyond the model answer: `tabledata Customer = R` (the shipment copies the ship-to address from the customer) and `tabledata "No. Series" = R` (number series lookups) in Basic. Without direct read rights on these, a user holding only the freight sets could not pick a customer or a series. No write rights to standard tables are given.

For Mette: "Your Business Central license decides the outer limit of what a person may use. Inside that limit, we hand out one of two keys: CRF Freight Basic lets the warehouse and customer service work with shipments, and CRF Freight Admin also lets the person responsible change the freight setup and the carrier rates. A user can do only what both the license and the assigned permission sets allow. Because we built the extension ourselves and do not sell it, there is no extra license to buy for it; the people who use it need a license that covers the standard functions they already use, such as customers and sales."

Entitlements: none added, because the app is not sold through Marketplace. `object-ids.md`: permission sets 50100 and 50101 built.
