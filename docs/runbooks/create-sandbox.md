# Runbook: create the Cronus Fragt sandbox

Status: **not executed.** Creating an environment needs a person with Business Central admin rights in a real tenant. Nothing here was run, and no value below was observed. Fields in `<angle brackets>` are for the person who runs it to fill in.

## Steps

1. Open the Business Central admin center (`https://businesscentral.dynamics.com/<tenant>/admin`) and sign in as a Business Central administrator.
2. Environments, **New**.
3. Enter the name `CRONUS-DEV`. The launch configurations in `app/.vscode/launch.json` use this exact name, so if you pick another name, change it there too.
4. Type: **Sandbox** (a sandbox can be deleted and recreated; production cannot).
5. Country/region: the one Cronus works in. This also decides the localization and the Azure region and cannot be changed later. Choose the version offered as current.
6. Choose **Create** and wait until the state is **Active**.
7. Open the environment in the web client and sign in.
8. In the environment details, open **Update settings** and read the update window.
9. In **Extension Management**, once the first extension is published (step 3), turn on **Allow HttpClient Requests** when the carrier calls arrive (step 20).

## What to note down

| Item | Value |
|---|---|
| Environment name | `CRONUS-DEV` (planned) |
| Environment type | `<Sandbox: confirm in the admin center>` |
| Country/region | `<fill in>` |
| State | `<Active, date and time>` |
| Application version | `<fill in from the admin center>` |
| Platform version | `<fill in>` |
| Update window (start, end, time zone) | `<fill in from Update settings>` |
| Created by / date | `<fill in>` |

## Message to Mette (fill in after the values exist)

> The test environment CRONUS-DEV is ready and separate from our real books. Microsoft may update it between `<start>` and `<end>` (`<time zone>`). Please avoid demos in that window, or tell me and I will move it.

## Checklist mapping

See `docs/steps/01-sandbox-environment.md`.
