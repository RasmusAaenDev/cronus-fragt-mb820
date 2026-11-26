# Step 6: Hook in with events, do not change standard code

Cronus Fragt · MB-820 workbook · Solution design

**[See what this step changed: diff against step 5](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/a3563848bf4a07b69e5423f0b85fcbee0d6c68db...53d8625bb09ad0f030bc9b91c189769b38d7f4a6)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> Management asked me yesterday whether what we're building breaks when Microsoft updates Business Central.
> I'd like to be able to give a proper answer to that. And it's important to us that the shipment tracking
> appears by itself when the warehouse posts a delivery, and that we set up the carrier's system right on the
> shipping agents we already have in Business Central.

## Your task

**What you hand in:** A written section of the design document, not AL code: a short explanation, a list of extension points and a decision on what Cronus Fragt exposes.

Add a section to the design document on how Cronus Fragt plugs into Business Central, and which of its own objects and events other extensions may use.

**Do this**

1. Explain the extension model in a few sentences: the System Application, the Base Application and your extension, and why your extension adds to them instead of changing their code.
2. List every extension point the solution will use, with the publisher object, the event or extension object, and what Cronus Fragt does there.
3. Decide which of your own objects other extensions may call.
4. Decide which events Cronus Fragt itself should publish so that it can be extended later.

**The list must include at least**

- The posting of a sales shipment, to create shipment tracking.
- The Shipping Agent table and the Shipping Agents page, for the carrier settings.

## Checklist

- [ ] Your design explains the System Application, the Base Application and your extension, and that base code is not modified.
- [ ] The sales shipment hook names the publisher codeunit and the event, and says why that event fits.
- [ ] The carrier settings use a table extension on Shipping Agent and a page extension on the Shipping Agents page.
- [ ] You have named at least one event that Cronus Fragt publishes itself and said which objects stay internal.

## In this branch

- [Notes for this step](docs/steps/06-events-not-modifications.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/a3563848bf4a07b69e5423f0b85fcbee0d6c68db...53d8625bb09ad0f030bc9b91c189769b38d7f4a6): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/events-not-modifications

---

[← Step 5](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/05-solution-design/extend-standard-or-build-your-own/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 7 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/07-solution-design/sketch-the-architecture/README.md)
