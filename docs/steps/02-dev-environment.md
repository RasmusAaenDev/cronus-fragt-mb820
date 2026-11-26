# Step 02: Set up the AL development environment

Delivers the project skeleton in `app/`: `app.json` (name Cronus Fragt, publisher Cronus, fresh app id, idRanges 50100-50149, target Cloud) and `.vscode/launch.json` (a launch configuration for the sandbox `CRONUS-DEV`). `scripts/compile.sh app` reports 0 errors and 0 warnings against the BC 28 symbols.

Versions: the workbook excerpt shows `application` 26.0.0.0 and `runtime` 15.0. This project targets BC 28, so `app.json` uses `platform` and `application` 28.0.0.0 and `runtime` 17.0, which the BC 28 compiler accepts. Those are the numbers that compiled here; the sandbox from step 01 must run a matching version.

| Checklist item | How it is met |
|---|---|
| VS Code has the AL Language extension | Not applicable here. The compiler comes from the AL Language extension package (`.vsix`), used through `scripts/compile.sh`. Installing VS Code was not done or verified. |
| app.json has name, publisher and ID range | `app/app.json`: `name`, `publisher`, `idRanges` 50100-50149. |
| launch.json points to the sandbox by type and name | `app/.vscode/launch.json`: `environmentType` Sandbox, `environmentName` CRONUS-DEV. |
| Symbols downloaded, project builds without errors | Symbols come from the local BC 28 package cache, not from a sandbox (`AL: Download Symbols` was not run). Build: 0 errors. The project has no objects yet. |

Not done or not verified: signing in to a sandbox, `AL: Download Symbols` against it, and publishing. These need the environment from step 01.
