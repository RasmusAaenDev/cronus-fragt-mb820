# Step 6: Hook in with events, do not change standard code

Cronus Fragt · MB-820 workbook · Solution design

**[See what this step changed: diff against step 5](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/bc8fa24db1a7c4995a0a4577bfb16a6349c94c2f...f5c7dbe99fda10fe3ce774c64e7bff8e8157a247)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> Management asked me yesterday whether what we're building breaks when Microsoft updates Business Central. I'd
> like to be able to give a proper answer to that. And it's important to us that the shipment appears by itself
> when the warehouse posts a delivery, and that you can see the customer's regular carrier right on the customer
> card.

## Your task

Add a section on how Cronus Fragt plugs into Business Central. First explain the extension model in a few sentences: the System Application, the Base Application and your extension, and why your extension adds to them instead of changing their code. Then list every extension point the solution will use, with the publisher object, the event or extension object, and what Cronus Fragt does there: at least the posting of a sales shipment (to create a shipment) and the Customer table and Customer Card (for the default carrier). Finally decide which of your own objects other extensions may call, and which events Cronus Fragt itself should publish so that it can be extended later.

## Checklist

- [ ] Your design explains the System Application, the Base Application and your extension, and that base code is not modified.
- [ ] The sales shipment hook names the publisher codeunit and the event, and says why that event fits.
- [ ] The default carrier uses a table extension on Customer and a page extension on the Customer Card.
- [ ] You have named at least one event that Cronus Fragt publishes itself and said which objects stay internal.

## In this branch

- [Notes for this step](docs/steps/06-events-not-modifications.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/bc8fa24db1a7c4995a0a4577bfb16a6349c94c2f...f5c7dbe99fda10fe3ce774c64e7bff8e8157a247): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/events-not-modifications

---

[← Step 5](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/05-solution-design/extend-standard-or-build-your-own/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 7 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/07-solution-design/sketch-the-architecture/README.md)
