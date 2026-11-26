# Step 37: Version and sign the app

Cronus Fragt · MB-820 workbook · Bonus: CI/CD and notifications · bonus

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> When you come with a new release of the freight solution, I'd like to be able to see which version we're
> running and what's new in it. And if we sell it to our partners one day, they need to be able to trust that
> it comes from us and that nobody has tampered with it along the way.

## Your task

**What you hand in:** A written version scheme, the next release version, and a note on what signing means for Cronus's own per-tenant extension and what a marketplace version would need. The signing itself is done on a copy of the .app.

Write down a version scheme for Cronus Fragt, apply it to the next release, and then sign a copy of the .app.

**Versioning**

1. Write down which of the four numbers in the version of app.json you raise for which kind of change, and which numbers the pipeline from the previous step may set.
2. Apply the scheme to the next release after 1.1.0.0 from module 3e and keep the app id unchanged.
3. Explain why Cronus Fragt Tests still finds its dependency.

**Signing**

1. In the container from phase 4, create a self-signed code signing certificate for testing.
2. Sign a copy of the .app with a time stamp and check the signature.
3. Finish with a note on what signing means for Cronus's own per-tenant extension and what a marketplace version would need.

## Checklist

- [ ] Your version scheme names the four parts of the version, says which change raises which part, and says that every release gets a higher version with the same app id.
- [ ] The next release has a higher version than 1.1.0.0 in app.json, and you can explain why the dependency version in Cronus Fragt Tests doesn't have to change with it.
- [ ] A copy of the .app was signed with a time stamp using a self-signed code signing certificate, and its Digital Signatures tab in Windows shows the signature.
- [ ] Your note says that a marketplace app must be signed with a certificate from a certification authority, that a self-signed certificate isn't accepted there, and what Learn does and doesn't say about signing a per-tenant extension.

## In this branch

- [Notes for this step](docs/steps/37-signing-and-versioning.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/signing-and-versioning

---

[← Step 36](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/36-bonus-ci-cd-and-notifications/put-it-in-git-and-build-it-in-a-pipeline/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 38 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/38-bonus-ci-cd-and-notifications/notify-when-a-shipment-is-late/README.md)
