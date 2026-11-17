# Release to production and AppSource readiness

Status legend: **done** (exists in this repository), **open** (needs a person, an account or a registration that does not exist here), **decision** (needs Mette).

## 1. Release to Cronus production (per-tenant)

Nothing was uploaded: there is no admin center access here, so the checklist item "Operations page shows success" is **open**. Procedure for a person with admin rights:

1. Build `Cronus Fragt` 1.2.0.0 (the version at step 37; 1.1.0.0 was the version of module 3e) and take the `.app` of the app only. Not the test app (tests are not allowed in online production).
2. Admin center, Environments, Production, Apps, Manage Apps, Install Extension; select the `.app`. Business Central decides itself whether it is a new extension or an update.
3. Choose the schedule agreed with Mette (new extension: immediately or the next update window; update: also possible with the next minor/major update) and the sync mode.
4. Follow the Operations page until it says Succeeded. For an update from 1.0.0.0 the upgrade code (`CRF Upgrade`, step 31) runs; check that the default-carrier backfill tag was set.
5. After installation: run the setup guide (assisted setup) in each company so `Shipment Nos.` is set; until then posting works but creates no shipments.

Before this, the sandbox runs from steps 30-34 must have been done (they have not).

## 2. What must change for an AppSource version

| Area | Per-tenant Cronus Fragt now | AppSource version | Status |
|---|---|---|---|
| App id | `d28d7ba0-b08e-4f0a-bec1-e06bb9f39ced` | A new GUID; a marketplace app and a per-tenant extension cannot share an id | open |
| Name / publisher / version | Cronus Fragt / Cronus / 1.2.0.0 | The combination must not exist as a per-tenant extension in the same service | decision |
| ID range | 50100-50149 (per-tenant range; AS0084 in the trial build) | A range assigned by Microsoft to the publisher (for a new publisher 70000000-74999999); every object id changes | open |
| Affix | `CRF` used on all 37 objects | Must be registered for the publisher with Microsoft; if it cannot be, objects are renamed | open |
| Cronus's own data | Lives in the per-tenant tables | Not available to the new app (different id, different tables). Options: run both side by side without shared object names/ids, and a third per-tenant extension that depends on both and moves the data | decision |
| Namespaces | Not used (AA0247 hidden in the ruleset) | Recommended; do it together with the id change | open |
| Signing | none | The `.app` must be signed (step 37) | open |

Registered values (affix, ID range, Partner ID, new GUID) **do not exist** and none is invented in this repository.

## 3. Draft `app.json` for the marketplace version

Illustrative; every `<...>` must be replaced with a real value. The current `app/app.json` deliberately keeps empty strings, so a per-tenant build does not point to fake pages.

```json
{
  "id": "<new GUID, not d28d7ba0-...>",
  "name": "Cronus Fragt",
  "publisher": "Cronus",
  "version": "2.0.0.0",
  "brief": "Book shipments with your carriers and track their status in Business Central.",
  "description": "Cronus Fragt creates shipments from posted sales shipments, books them with your carriers and keeps their status up to date.",
  "privacyStatement": "<https url>",
  "EULA": "<https url>",
  "help": "<https url>",
  "url": "<https url>",
  "contextSensitiveHelpUrl": "<https url, ends with />",
  "logo": "<path to a png in the project, e.g. Images/CronusFragtLogo.png>",
  "application": "<lowest BC version supported, e.g. 27.0.0.0>",
  "platform": "<matching platform>",
  "runtime": "<matching runtime>",
  "idRanges": [ { "from": "<assigned>", "to": "<assigned>" } ],
  "target": "Cloud",
  "features": [ "TranslationFile" ],
  "applicationInsightsConnectionString": "<real connection string>"
}
```

`AppSourceCop.json` (exists in `app/`): `mandatoryAffixes: ["CRF"]`, `supportedCountries: ["DK"]`. After a first release, add the previous package as baseline (`name`, `publisher`, `version`) so breaking changes are reported.

## 4. AppSourceCop findings from step 33 (trial build)

AS0084 (id range), AS0051 x5 (`privacyStatement`, `EULA`, `help`, `logo`, `contextSensitiveHelpUrl`), AS0052 (`url`), AS0081 warning (`internalsVisibleTo`), test app also AS0015 (TranslationFile) and AS0092 (Application Insights). All come from `app.json` and the id range; the AL code itself raised no AppSourceCop error.

## 5. Checklist against the technical validation

| Requirement | State |
|---|---|
| app.json fields (brief, description, privacyStatement, EULA, help, url, logo, contextSensitiveHelpUrl) | open: no real urls or logo exist |
| `applicationInsightsConnectionString` | `app/app.json` holds an all-zero placeholder InstrumentationKey; **open**: needs a real resource, otherwise telemetry goes nowhere |
| Affix on all objects | done in code (`CRF`); registration open |
| Registered ID range | open |
| Translations | done for da-DK (`app/Translations`, my translation, needs a Danish review); en-US is the source language |
| Permission sets, none requiring SUPER | done: `CRF Freight` (all tables, pages, code); not tested with a non-SUPER user (needs a sandbox) |
| DataClassification not ToBeClassified | done: no `ToBeClassified` in `app/src` |
| Upgrade code | done (`CRF Install`, `CRF Upgrade`, `CRF Upgrade Tags`, step 31); not run |
| Automated tests | the test app exists (3 tests); not run; the test package is not part of the submission |
| Signed `.app` | open (step 37) |
| No runtime packages | done: `resourceExposurePolicy` allows download of source; check against the offer before submitting |
| Same name/publisher/version as the offer in Partner Center | open |

## 6. Path to the marketplace (all open, all require accounts)

1. Join the Microsoft AI Cloud Partner Program; get a Partner ID.
2. Create a Partner Center account, register as a publisher, register for Business Central apps.
3. Request the ID range and register the affix.
4. Build the marketplace version (new id, ids, namespaces, fields above), sign it.
5. Create the offer in Partner Center, upload the package, fill in the storefront content, Review and publish. Go Live only enters the validation queue.
6. Technical validation (automatic: manifest, affixes, signature, name/publisher/version match, no runtime packages, compile per country and release, AppSourceCop against baselines).
7. Marketing validation (offer name, summary, description, logo, screenshots, help, support, privacy and license links). Required for new offers and content changes.
8. After publishing: customers install from AppSource or the admin center.

Versioning: every update needs a higher version number; the app id never changes; a DEV version published from VS Code must differ from the marketplace version; the first submission becomes the baseline, so do not submit while breaking changes are still expected.

## 7. For Mette

Our version runs only in our own Business Central, so we cannot just hand it to the partners. To sell it, we register as a publisher with Microsoft, give the product a new identity and new numbers, and Microsoft checks it automatically before anyone can install it. Our own data stays in our version; moving it to the sellable one is a separate job we would plan together. Before that, the freight solution should have run in production for a while.
