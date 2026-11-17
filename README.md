# Step 7: Sketch the architecture

Cronus Fragt · MB-820 workbook · Solution design

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> Before we spend more money, management would like to see how it all fits together: who talks to whom, what
> happens automatically, and who is allowed to do what. A drawing would be nice. As long as I can explain it
> onwards without having to call you every time.

## Your task

Draw or describe the architecture of Cronus Fragt on one page. Show the users in the web client, the Business Central service, the webshop and the carriers' services, and place these parts on it: the freight setup and the assisted setup guide that fills it in, the carrier implementations behind the CRF ICarrier interface, the facade codeunit that makes the outbound HTTP calls to the carriers, the API pages the webshop uses, the job queue entry that polls carriers for status, the telemetry your extension sends, and the permission set. For each arrow say who starts the call and whether a user waits for it.

## Checklist

- [ ] The sketch shows users, the Business Central service, the webshop and the carriers, with the direction of every call.
- [ ] Carrier calls go from a codeunit behind the CRF ICarrier interface, not from a page.
- [ ] Status polling runs from the job queue in the background, and the webshop uses API pages.
- [ ] Setup, assisted setup, telemetry and the permission set each have a place on the sketch.
- [ ] You have noted that outbound HTTP calls must be allowed for the extension in the Extension Settings.

## In this branch

- [Notes for this step](docs/steps/07-architecture-sketch.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Changes since the previous step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/06-solution-design/hook-in-with-events-do-not-change-standard-code...07-solution-design/sketch-the-architecture)
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/architecture-sketch

---

[← Step 6](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/06-solution-design/hook-in-with-events-do-not-change-standard-code/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 8 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/08-setup-and-assisted-setup/create-the-freight-setup-table/README.md)
