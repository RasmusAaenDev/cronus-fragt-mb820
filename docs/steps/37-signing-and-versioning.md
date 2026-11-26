# Step 37: Version and sign the app

- `app/app.json`: version 1.1.0.0 to 1.2.0.0, same app id. Both projects compile with the Business Central 28 compiler and the analyzers (0 errors, 0 warnings).
- `docs/runbooks/version-and-signing.md`: version scheme (four parts, what raises which, which part the pipeline may set), why the test app's dependency stays at 1.0.0.0 (a dependency version is a minimum), signing procedure, what signing means for a per-tenant and for a marketplace app.
- `scripts/sign-app.ps1`: self-signed test certificate, SHA256, time stamp, verify; signs a copy only; asks for the pfx password at the prompt.

| Checklist item | Status |
|---|---|
| Scheme names the four parts, higher version, same id | Runbook |
| Next release higher than 1.1.0.0; why the dependency need not change | `app/app.json` (1.2.0.0); `test/app.json` still says 1.0.0.0 for Cronus Fragt; runbook |
| Copy signed with time stamp, Digital Signatures tab | **Not done**: no Windows/SignTool here. No signed file and no certificate exist. Script written, not run |
| Marketplace needs CA certificate, self-signed rejected; what Learn says on per-tenant | Runbook, "What signing means" |

Docs that named 1.1.0.0 as the current version were updated (`docs/release/appsource-readiness.md`, `scripts/run-tests.ps1`).
