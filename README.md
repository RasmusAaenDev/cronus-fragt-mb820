# Step 3: Publish a first extension and attach the debugger

Cronus Fragt · MB-820 workbook · Environment and tools

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> I'd really like to see something running before I report back to management on Friday. It can be dead simple,
> just a button on the customer list that says hello. And show me that you can work out what the code is doing
> if something acts up.

## Your task

Write a page extension for the Customer List with an action that shows a greeting from Cronus Fragt. Publish it to the sandbox and check that the action works. Then add an attach configuration to launch.json, set a breakpoint in the action, attach the debugger to the next web client session, run the action and inspect the variables when the breakpoint is hit.

## Checklist

- [ ] The page extension compiles and is published to the sandbox.
- [ ] The new action appears on the Customer List and shows the greeting.
- [ ] launch.json has an attach configuration that breaks on the next web client session.
- [ ] The debugger stops at your breakpoint and you can read the greeting variable.

## In this branch

- [Notes for this step](docs/steps/03-first-extension.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Changes since the previous step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/02-environment-and-tools/set-up-the-al-development-environment...03-environment-and-tools/publish-a-first-extension-and-attach-the-debugger)
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/first-extension

---

[← Step 2](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/02-environment-and-tools/set-up-the-al-development-environment/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 4 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/04-solution-design/design-document-part-1-the-object-list/README.md)
