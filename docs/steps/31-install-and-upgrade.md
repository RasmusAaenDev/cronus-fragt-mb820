# Step 31: Install and upgrade code

Version raised to 1.1.0.0 in `app/app.json` (the version that adds the default carrier). Three internal codeunits in `app/src/Install/`:

- `CRFInstall.Codeunit.al` (50108, `Subtype = Install`): `OnInstallAppPerCompany` creates the `CRF Freight Setup` record if missing and sets the upgrade tag; a subscriber on `Company-Initialize` `OnCompanyInitialize` does the same for companies created later.
- `CRFUpgrade.Codeunit.al` (50109, `Subtype = Upgrade`): `OnUpgradePerCompany` exits when the tag exists, fills `CRF Default Carrier` from the carrier of the customer's latest shipment, then sets the tag.
- `CRFUpgradeTags.Codeunit.al` (50110): `GetDefaultCarrierTag()` and an `OnGetPerCompanyUpgradeTags` subscriber (codeunit `Upgrade Tag`) that registers the tag for new companies.

| Checklist item | Where |
|---|---|
| 50108 Install, creates setup only if missing | `InitFreightSetup` |
| Subscribes to `OnCompanyInitialize` | `InitFreightSetupOnCompanyInitialize` |
| 50109 Upgrade, tag check, fill, set tag | `OnUpgradePerCompany` |
| Tag from a procedure, registered in `OnGetPerCompanyUpgradeTags`, set by install | `CRFUpgradeTags`, `OnInstallAppPerCompany` |
| After 1.1.0.0, customers have a carrier; a second publish changes nothing | Not run here: needs an environment with 1.0.0.0 installed and data. |

Tag name: `CRF-DefaultCarrierFromShipments-20261117` (the workbook's `CRF-0001-...` would collide with the telemetry event id numbering). "Latest" shipment means the highest shipment number. New permissions: the three codeunits were added to `CRF Freight`.

For Mette: the data change is upgrade code because install code does not run when a new version is installed over an old one, and the tag makes sure the one-time job runs once per company.

Compiled only, none of it was run. `scripts/compile.sh app` and `test`: 0 errors, 0 warnings. The test app depends on Cronus Fragt 1.0.0.0 or later, so it still resolves.
