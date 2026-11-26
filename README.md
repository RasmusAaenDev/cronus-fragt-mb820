# Step 7: Sketch the architecture

Cronus Fragt · MB-820 workbook · Solution design

**[See what this step changed: diff against step 6](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/53d8625bb09ad0f030bc9b91c189769b38d7f4a6...fa02e23f551d928b484e9d7635e7734df0a94fae)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> Before we spend more money, management would like to see how it all fits together: who talks to whom, what
> happens automatically, and who is allowed to do what. A drawing would be nice. As long as I can explain it
> onwards without having to call you every time.

## Your task

**What you hand in:** A one-page architecture drawing or description, not AL code: the parts of Cronus Fragt placed on it, with every arrow labelled.

Draw or describe the architecture of Cronus Fragt on one page, so that Mette can explain it to the management team.

**Show on the page**

- The users in the web client, the Business Central service, the webshop and the carriers' services.
- The freight setup and the assisted setup guide that fills it in.
- The shipping agents, with the carrier settings your extension adds to them.
- The carrier implementations behind the CRF ICarrier interface.
- The facade codeunit that makes the outbound HTTP calls to the carriers.
- The API pages the webshop uses.
- The job queue entry that polls carriers for status.
- The telemetry your extension sends.
- The permission sets.

**For each arrow say**

- Who starts the call.
- Whether a user waits for it.

## Checklist

- [ ] The sketch shows users, the Business Central service, the webshop and the carriers, with the direction of every call.
- [ ] Carrier calls go from a codeunit behind the CRF ICarrier interface, not from a page, and the shipping agent decides which carrier is called.
- [ ] Status polling runs from the job queue in the background, and the webshop uses API pages.
- [ ] Setup, assisted setup, the Shipping Agent extension, telemetry and the permission sets each have a place on the sketch.
- [ ] You have noted that outbound HTTP calls must be allowed for the extension in the Extension Settings.

## In this branch

- [Notes for this step](docs/steps/07-architecture-sketch.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/53d8625bb09ad0f030bc9b91c189769b38d7f4a6...fa02e23f551d928b484e9d7635e7734df0a94fae): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/architecture-sketch

---

[← Step 6](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/06-solution-design/hook-in-with-events-do-not-change-standard-code/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 8 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/08-setup-and-assisted-setup/create-the-freight-setup-table/README.md)
