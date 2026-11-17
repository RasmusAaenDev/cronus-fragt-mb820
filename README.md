# Step 33: Make the code pass the analyzers

Cronus Fragt · MB-820 workbook · Quality and deploy

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> Before the freight solution goes into our real company, I'd like to know that it's been done properly, also in
> the places I never see myself. If someone else has to look after it one day, they should be able to find their
> way around without starting over. Is there a fixed check that says whether it lives up to Microsoft's own
> rules, and can we have it run every time?

## Your task

Turn on code analysis for both projects in your workspace, Cronus Fragt and Cronus Fragt Tests from module 3e. Cronus Fragt is a per-tenant extension for Cronus, so enable CodeCop, UICop and PerTenantExtensionCop in al.codeAnalyzers, and leave AppSourceCop out. Build each project, list the findings with their rule ids, and fix them; where you decide not to fix a finding, record why. Add a ruleset file that makes one rule that matters to Cronus an error and documents every rule whose severity you lower. Then try the AppSource scenario once: swap PerTenantExtensionCop for AppSourceCop in a trial build, write down what it reports for the next step, and switch back.

## Checklist

- [ ] The settings of both projects have al.enableCodeAnalysis set to true and al.codeAnalyzers with ${CodeCop}, ${UICop} and ${PerTenantExtensionCop}, and not ${AppSourceCop}.
- [ ] A full build of each project shows no errors, and every remaining warning or info diagnostic is either fixed or written down with its rule id and the reason it stays.
- [ ] A ruleset file named <name>.ruleset.json is set in al.ruleSetPath, raises at least one rule (for example AA0218) to Error and has a justification for every rule it lowers.
- [ ] Every
- [ ] Your notes from the trial build with AppSourceCop list its errors, including AS0084 for the ID range, and the settings are back to PerTenantExtensionCop.

## In this branch

- [Notes for this step](docs/steps/33-analyzers.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Changes since the previous step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/32-link-to-standard-business-central/debug-a-problem-and-add-danish-captions...33-quality-and-deploy/make-the-code-pass-the-analyzers)
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/analyzers

---

[← Step 32](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/32-link-to-standard-business-central/debug-a-problem-and-add-danish-captions/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 34 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/34-quality-and-deploy/run-your-tests-and-the-standard-tests/README.md)
