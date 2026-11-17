# Steps

One branch per workbook step, stacked: each branch starts from the previous one, so its diff against that is exactly what the step adds. `main` points at the last step.

| # | Branch | Step | Workbook phase |
|---|---|---|---|
| 1 | `01-environment-and-tools/create-a-sandbox-environment` | Create a sandbox environment | Environment and tools |
| 2 | `02-environment-and-tools/set-up-the-al-development-environment` | Set up the AL development environment | Environment and tools |
| 3 | `03-environment-and-tools/publish-a-first-extension-and-attach-the-debugger` | Publish a first extension and attach the debugger | Environment and tools |
| 4 | `04-solution-design/design-document-part-1-the-object-list` | Design document, part 1: the object list | Solution design |
| 5 | `05-solution-design/extend-standard-or-build-your-own` | Extend standard or build your own? | Solution design |
| 6 | `06-solution-design/hook-in-with-events-do-not-change-standard-code` | Hook in with events, do not change standard code | Solution design |
| 7 | `07-solution-design/sketch-the-architecture` | Sketch the architecture | Solution design |
| 8 | `08-setup-and-assisted-setup/create-the-freight-setup-table` | Create the freight setup table | Build the solution |
| 9 | `09-setup-and-assisted-setup/create-the-setup-page-and-open-it-from-search` | Create the setup page and open it from search | Build the solution |
| 10 | `10-setup-and-assisted-setup/add-an-assisted-setup-guide` | Add an assisted setup guide | Build the solution |
| 11 | `11-shipment/create-the-shipment-tables` | Create the shipment tables | Build the solution |
| 12 | `12-shipment/enums-and-number-series` | Enums and number series | Build the solution |
| 13 | `13-shipment/card-list-and-subform-pages` | Card, list and subform pages | Build the solution |
| 14 | `14-shipment/permission-sets-and-entitlements` | Permission sets and entitlements | Build the solution |
| 15 | `15-shipment/import-carrier-rates-with-an-xmlport` | Import carrier rates with an XMLport | Build the solution |
| 16 | `16-shipment/a-query-for-shipments-per-carrier` | A query for shipments per carrier | Build the solution |
| 17 | `17-carriers-and-the-outbound-api/one-interface-for-every-carrier` | One interface for every carrier | Build the solution |
| 18 | `18-carriers-and-the-outbound-api/a-facade-codeunit` | A facade codeunit | Build the solution |
| 19 | `19-carriers-and-the-outbound-api/call-the-carrier-s-service` | Call the carrier's service | Build the solution |
| 20 | `20-carriers-and-the-outbound-api/keep-the-api-key-out-of-the-table` | Keep the API key out of the table | Build the solution |
| 21 | `21-carriers-and-the-outbound-api/update-shipment-status-from-the-carrier` | Update shipment status from the carrier | Build the solution |
| 22 | `22-report-and-api-pages/the-shipment-report-for-the-warehouse` | The shipment report for the warehouse | Build the solution |
| 23 | `23-report-and-api-pages/api-pages-for-the-webshop` | API pages for the webshop | Build the solution |
| 24 | `24-report-and-api-pages/an-odata-action-and-read-scale-out` | An OData action and read scale-out | Build the solution |
| 25 | `25-report-and-api-pages/tell-the-webshop-when-a-shipment-changes` | Tell the webshop when a shipment changes | Build the solution |
| 26 | `26-link-to-standard-business-central/give-customers-a-default-carrier` | Give customers a default carrier | Build the solution |
| 27 | `27-link-to-standard-business-central/create-a-shipment-when-a-sales-shipment-is-posted` | Create a shipment when a sales shipment is posted | Build the solution |
| 28 | `28-link-to-standard-business-central/log-what-happens` | Log what happens | Build the solution |
| 29 | `29-link-to-standard-business-central/poll-carriers-with-a-job-queue-entry` | Poll carriers with a job queue entry | Build the solution |
| 30 | `30-link-to-standard-business-central/test-it-with-the-test-framework` | Test it with the test framework | Build the solution |
| 31 | `31-link-to-standard-business-central/install-and-upgrade-code` | Install and upgrade code | Build the solution |
| 32 | `32-link-to-standard-business-central/debug-a-problem-and-add-danish-captions` | Debug a problem and add Danish captions | Build the solution |
| 33 | `33-quality-and-deploy/make-the-code-pass-the-analyzers` | Make the code pass the analyzers | Quality and deploy |
| 34 | `34-quality-and-deploy/run-your-tests-and-the-standard-tests` | Run your tests and the standard tests | Quality and deploy |
| 35 | `35-quality-and-deploy/prepare-for-appsource-and-release` | Prepare for AppSource and release | Quality and deploy |
| 36 | `36-bonus-ci-cd-and-notifications/put-it-in-git-and-build-it-in-a-pipeline` | Put it in Git and build it in a pipeline (bonus) | Bonus: CI/CD and notifications |
| 37 | `37-bonus-ci-cd-and-notifications/version-and-sign-the-app` | Version and sign the app (bonus) | Bonus: CI/CD and notifications |
| 38 | `38-bonus-ci-cd-and-notifications/notify-when-a-shipment-is-late` | Notify when a shipment is late (bonus) | Bonus: CI/CD and notifications |
| 39 | `39-bonus-ci-cd-and-notifications/watch-the-job-queue` | Watch the job queue (bonus) | Bonus: CI/CD and notifications |
