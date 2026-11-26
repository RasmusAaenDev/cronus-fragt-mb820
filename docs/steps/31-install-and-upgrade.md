# Step 31: Install and upgrade code

Version raised to 1.1.0.0 in `app/app.json` (the version that adds the default shipping agent to the setup). Three internal codeunits in `app/src/Install/`:

- `CRFInstall.Codeunit.al` (50108, `Subtype = Install`): `OnInstallAppPerCompany` creates the `CRF Freight Setup` record if missing and sets the upgrade tag; a subscriber on `Company-Initialize` `OnCompanyInitialize` does the same for companies created later.
- `CRFUpgrade.Codeunit.al` (50109, `Subtype = Upgrade`): `OnUpgradePerCompany` exits when the tag exists, fills `Default Shipping Agent Code` in `CRF Freight Setup` from the shipping agent of the latest shipment tracking record, then sets the tag. A value that is already in the setup is kept.
- `CRFUpgradeTags.Codeunit.al` (50110): `GetDefaultShippingAgentTag()` and an `OnGetPerCompanyUpgradeTags` subscriber (codeunit `Upgrade Tag`) that registers the tag for new companies.

| Checklist item | Where |
|---|---|
| 50108 Install, creates setup only if missing | `InitFreightSetup` |
| Subscribes to `OnCompanyInitialize` | `InitFreightSetupOnCompanyInitialize` |
| 50109 Upgrade, tag check, fill the default shipping agent, set tag | `OnUpgradePerCompany`, `FillDefaultShippingAgentFromTracking` |
| Tag from a procedure, registered in `OnGetPerCompanyUpgradeTags`, set by install | `CRFUpgradeTags`, `OnInstallAppPerCompany` |
| After 1.1.0.0, the setup has a default shipping agent; an existing value is kept; a second publish changes nothing | The code does it: the fill is skipped when `Default Shipping Agent Code` is not blank and when the tag exists. Not run here: needs an environment with 1.0.0.0 installed and data. |

Tag name: `CRF-DefaultShippingAgentFromTracking-20261126` (the workbook's `CRF-0001-...` would collide with the telemetry event id numbering). "Latest" means the highest shipment tracking number among the records that have a shipping agent (`SetFilter("Shipping Agent Code", '<>%1', '')`, then `FindLast`). If no record has a shipping agent, the default stays blank. New permissions: the three codeunits were added to `CRF Freight Admin`.

For Mette: the data change is upgrade code because install code does not run when a new version is installed over an old one, and the tag makes sure the one-time job runs once per company.

Compiled only, none of it was run. Compiled with the Business Central 28 compiler (`scripts/compile.sh app` and `test`): 0 errors, 0 warnings. The test app depends on Cronus Fragt 1.0.0.0 or later, so it still resolves.
