# Cronus Fragt (MB-820 model solution)

A worked solution to the MB-820 workbook in [Sekvens CertPractice](https://learn.sekvens.tools): an AL extension for Business Central that books shipments with freight carriers for the fictional distributor Cronus. It includes the design document the workbook asks for.

- `docs/design/` is the design document (object list, extend-or-build decisions, events, architecture).
- `app/` is the AL extension (object ids 50100-50149, affix `CRF`).
- `STEPS.md` lists the steps and their branches.

## Branches

Each of the 39 workbook steps has its own branch, named `<number>-<topic>/<step name>`, and its `README.md` is the task description for that step (see `STEPS.md` for links). The branches are stacked: a branch starts from the previous step's code, so the compare view between two neighbouring steps shows what the step adds, plus the swapped README. `main` holds the finished solution (the last step's code) and this project README.

## What is verified

The AL code is compiled with the Business Central 28 compiler (`alc`) on Linux. Steps that need a running sandbox (creating the environment, publishing, attaching the debugger, running tests, AppSource, signing, pipelines, Power Automate) cannot be executed from here. Their branches contain the written outcome and what you do in the sandbox, and each says so.
