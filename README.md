# Step 33: Make the code pass the analyzers

Cronus Fragt · MB-820 workbook · Quality and deploy

**[See what this step changed: diff against step 32](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/d849773253cbeb7ac27bda472dd7c9a26fbd0813...7eca96e423be0076373020531ea758cb6e7b3ce3)**

This page is the task description for the step. The code and documents on this branch are the model solution.

## What Mette says

> Before the freight solution goes into our real company, I'd like to know that it's been done properly, also
> in the places I never see myself. If someone else has to look after it one day, they should be able to find
> their way around without starting over. Is there a fixed check that says whether it lives up to Microsoft's
> own rules, and can we have it run every time?

## Your task

**What you hand in:** A list of the analyzer findings with their rule ids and what you decided for each, a ruleset file, and a note on what the AppSourceCop trial build reports for the next step.

Turn on code analysis for both projects in your workspace, Cronus Fragt and Cronus Fragt Tests from module 3e, and make the code pass it.

**Do this**

1. Cronus Fragt is a per-tenant extension for Cronus, so enable CodeCop, UICop and PerTenantExtensionCop in al.codeAnalyzers, and leave AppSourceCop out.
2. Build each project, list the findings with their rule ids, and fix them. Where you decide not to fix a finding, record why.
3. Add a ruleset file that makes one rule that matters to Cronus an error and documents every rule whose severity you lower.
4. Try the AppSource scenario once: swap PerTenantExtensionCop for AppSourceCop in a trial build, write down what it reports for the next step, and switch back.

## Checklist

- [ ] The settings of both projects have al.enableCodeAnalysis set to true and al.codeAnalyzers with ${CodeCop}, ${UICop} and ${PerTenantExtensionCop}, and not ${AppSourceCop}.
- [ ] A full build of each project shows no errors, and every remaining warning or info diagnostic is either fixed or written down with its rule id and the reason it stays.
- [ ] A ruleset file named <name>.ruleset.json is set in al.ruleSetPath, raises at least one rule (for example AA0218) to Error and has a justification for every rule it lowers.
- [ ] Every
- [ ] Your notes from the trial build with AppSourceCop list its errors, including AS0084 for the ID range, and the settings are back to PerTenantExtensionCop.

## In this branch

- [Notes for this step](docs/steps/33-analyzers.md): what it delivers, how each checklist item is met, and what could not be verified without a sandbox.
- [Diff for this step](https://github.com/RasmusAaenDev/cronus-fragt-mb820/compare/d849773253cbeb7ac27bda472dd7c9a26fbd0813...7eca96e423be0076373020531ea758cb6e7b3ce3): exactly the code and documents this step adds, without the README.
- Workbook page: https://learn.sekvens.tools/workbook/mb-820/step/analyzers

---

[← Step 32](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/32-link-to-standard-business-central/debug-a-problem-and-add-danish-captions/README.md) · [Project overview](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/main/README.md) · [Step 34 →](https://github.com/RasmusAaenDev/cronus-fragt-mb820/blob/34-quality-and-deploy/run-your-tests-and-the-standard-tests/README.md)
