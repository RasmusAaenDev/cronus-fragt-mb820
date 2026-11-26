# Step 5: Extend standard or build your own?

Cronus Fragt · MB-820 workbook · Solution design

**[See what this step changed: diff against step 4](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/b03477bb2d0810d172b951c2b5595f30ec417b92...a3563848bf4a07b69e5423f0b85fcbee0d6c68db)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> I talked to someone at another company who said they just put a few extra fields on the sales order for the
> freight. Why can't we do the same? It sounds both faster and cheaper. And as I understand it, you want to
> add to Business Central's own shipping agents but build new tables for the tracking. Why not one or the
> other? I'd like to understand what we gain by doing it your way, so I can explain it to management.

## Your task

**What you hand in:** A decision table in the design document, with a reason for every row, plus two or three plain sentences for Mette. It is written text, not AL code.

Mette asks why the freight data can't simply be extra fields on the sales order, and why you extend one standard table but build tables of your own for the rest. Add a decision table to the design document that answers her, and finish with a short explanation she can repeat to the management team.

**Do this**

1. List each piece of data in Mette's wishes: the shipment tracking itself, its packages, the package tracking number, the carrier settings of each shipping agent (which carrier service, its address and its key), the customer's regular shipping agent and the freight setup.
2. For each one, decide whether standard Business Central already has it, whether it belongs in a table extension on a standard table, or whether it needs a table of your own.
3. Give the reason for each decision.
4. Finish with two or three sentences in plain language that Mette can repeat to the management team.

**Use at least these three angles**

- Upgrade safety: what happens when Microsoft updates Business Central.
- Data volume and performance: how often the standard table is read, and how many shipments one order can have.
- Ownership: who controls the keys, the number series, the permissions and the life cycle of the data.

## Checklist

- [ ] Every piece of data from Mette's wishes has a decision, standard, table extension or own table, with a reason.
- [ ] Your reasons cover upgrade safety, data volume and performance, and ownership of the data.
- [ ] The carrier settings are a table extension on the standard Shipping Agent table, not a Carrier table of your own, and you say why.
- [ ] Customer is not extended, because it already has a Shipping Agent Code, and you say so.
- [ ] Shipment tracking gets tables of your own, and you say why neither the sales order nor the posted sales shipment can hold it.
- [ ] The summary for Mette is free of technical terms.

## In this branch

- [Notes for this step](docs/steps/05-extend-or-build.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/b03477bb2d0810d172b951c2b5595f30ec417b92...a3563848bf4a07b69e5423f0b85fcbee0d6c68db): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/extend-or-build

---

[← Step 4](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/04-solution-design/design-document-part-1-the-object-list/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 6 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/06-solution-design/hook-in-with-events-do-not-change-standard-code/README.md)
