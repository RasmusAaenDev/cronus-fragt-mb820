# Step 5: Extend standard or build your own?

Cronus Fragt · MB-820 workbook · Solution design

**[See what this step changed: diff against step 4](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/8bba76499ca197f158fc7ab6713cf51a6281fd3a...bc8fa24db1a7c4995a0a4577bfb16a6349c94c2f)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> I talked to someone at another company who said they just put a few extra fields on the sales order for the
> freight. Why can't we do the same? It sounds both faster and cheaper. I'd like to understand what we gain by
> doing it your way, so I can explain it to management.

## Your task

Add a decision table to the design document. For each piece of data in Mette's wishes (the shipment itself, its packages, the tracking number, the customer's default carrier and the freight setup) decide whether it belongs in a table extension on a standard table or in a table of your own, and give the reason. Use at least these three angles: upgrade safety (what happens when Microsoft updates Business Central), data volume and performance (how often the standard table is read, and how many shipments one order can have), and ownership (who controls the keys, the number series, the permissions and the life cycle of the data). Finish with two or three sentences in plain language that Mette can repeat to the management team.

## Checklist

- [ ] Every piece of data from Mette's wishes has a decision, table extension or own table, with a reason.
- [ ] Your reasons cover upgrade safety, data volume and performance, and ownership of the data.
- [ ] The customer's default carrier is solved with a table extension on Customer, and you say why.
- [ ] You have checked what standard Business Central already offers for shipping before deciding to build.
- [ ] The summary for Mette is free of technical terms.

## In this branch

- [Notes for this step](docs/steps/05-extend-or-build.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/8bba76499ca197f158fc7ab6713cf51a6281fd3a...bc8fa24db1a7c4995a0a4577bfb16a6349c94c2f): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/extend-or-build

---

[← Step 4](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/04-solution-design/design-document-part-1-the-object-list/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 6 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/06-solution-design/hook-in-with-events-do-not-change-standard-code/README.md)
