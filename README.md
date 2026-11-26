# Step 2: Set up the AL development environment

Cronus Fragt · MB-820 workbook · Environment and tools

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> We start tomorrow morning, and I'd like you to be able to start coding right away instead of spending the
> morning installing things. Can you get the development environment ready today, pointing at our new test
> environment?

## Your task

Set up the AL development environment for Cronus Fragt, so that you have a project that compiles against your sandbox.

**Do this**

1. Install Visual Studio Code and the AL Language extension.
2. Create a new AL project for Cronus Fragt.
3. Configure app.json: name, publisher, the object ID range, and the platform, application and runtime versions.
4. Configure launch.json so that it publishes to the sandbox you created in the previous step.
5. Download the symbols.

**You are done when**

- The project compiles without errors.

## Checklist

- [ ] Visual Studio Code has the AL Language extension installed.
- [ ] The project's app.json has the Cronus Fragt name and publisher and an object ID range for the extension.
- [ ] The project's launch.json points to the sandbox environment by type and name.
- [ ] Symbols are downloaded and the project builds without errors.

## In this branch

- [Notes for this step](docs/steps/02-dev-environment.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/dev-environment

---

[← Step 1](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/01-environment-and-tools/create-a-sandbox-environment/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 3 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/03-environment-and-tools/publish-a-first-extension-and-attach-the-debugger/README.md)
