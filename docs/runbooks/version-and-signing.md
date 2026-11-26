# Runbook: versioning and signing

## Version scheme (Cronus Fragt's own convention; Learn does not prescribe meanings)

`version` in `app.json` has four parts: `Major.Minor.Build.Revision`.

| Part | Raise it when | Who sets it |
|---|---|---|
| Major | A change that breaks other extensions (removed or changed public events, procedures, tables) or that Cronus wants to mark as a big release | A developer, in a pull request |
| Minor | New features, also those that ship upgrade code (1.1.0.0 added the setup's default shipping agent and its backfill) | A developer, in a pull request |
| Build | The build number | The pipeline only (it may set this part; the workflow in `.github/workflows/build.yml` does not do it yet) |
| Revision | A hotfix on an already released version | A developer |

Rules: every release has a higher version than the one before and the **same app id** (`d28d7ba0-...`); the version never goes down and a released version is never rebuilt with different content (Business Central rejects a package with an existing app id and version). Name or publisher changes also need a higher version.

## Next release after 1.1.0.0

`app/app.json` is now `1.2.0.0` (minor: the cue page action was moved and the primary key of `CRF Shipment Tracking Line` got a SIFT field, both a feature/quality change without breaking anything; the id is unchanged). Tests: `test/app.json` still depends on Cronus Fragt `1.0.0.0`. A dependency version is a *minimum*, so the tests resolve 1.1.0.0 and 1.2.0.0 as well. Raise it only when a test needs something that was added after 1.0.0.0.

Verified here: `scripts/compile.sh app --codecop` and `scripts/compile.sh test --codecop` give 0 errors with 1.2.0.0.

## Signing

**Not done here**: no Windows machine, no SignTool, no container; no key, certificate or signed file exists in this repository and none must be committed (`*.pfx`, `*.cer` and passwords are never stored in Git). The script `scripts/sign-app.ps1` is the written procedure for a test signature (not run).

Steps on a Windows host or in the container (test certificate only):

1. `scripts/sign-app.ps1 -AppFile '<path>\Cronus_Cronus Fragt_1.2.0.0.app'` makes a self-signed code-signing certificate, exports a pfx (password typed at the prompt), signs a **copy** of the app with SHA256 and a time stamp, and verifies the signature with `signtool verify`.
2. Check the signature in Windows: file properties, Digital Signatures tab.
3. On-premises or in a container, publishing a signed app is checked by `Publish-NAVApp`; an unsigned app needs `-SkipVerification`. A self-signed certificate is only for testing.

## What signing means

- Cronus's own per-tenant extension: Learn's signing article states no signing requirement for uploading a per-tenant extension to Business Central online, so nothing is promised here. Signing still lets Cronus check that a file comes from its own build and was not changed.
- Marketplace version: the app must be signed with a certificate from a certification authority whose root is trusted by Windows (a standard code signing certificate is enough). A self-signed certificate is rejected by the technical validation. Since June 2023 code signing certificates are issued on hardware (HSM or token), so in practice the key lives in Azure Key Vault (Premium SKU for HSM) and signing uses the .NET `sign` tool (`sign code azure-key-vault ...`). A time stamp keeps the signature verifiable after the certificate expires. Open: buying the certificate, Key Vault, and a pipeline step with its secrets (none exist).
