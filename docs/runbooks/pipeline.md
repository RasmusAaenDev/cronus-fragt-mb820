# Runbook: Git and the pipeline

Source for AL-Go settings and workflows: the AL-Go documentation in its GitHub repository (github.com/microsoft/AL-Go, template `AL-Go-PTE` for per-tenant extensions). This repository does **not** use AL-Go; it has a minimal workflow of its own. Using AL-Go instead is a legitimate alternative (below).

## Where the code lives

`github.com/RasmusAaenDev/cronus-fragt-mb820` (private). One repository, two projects: `app/` (Cronus Fragt) and `test/` (Cronus Fragt Tests). The design document is in `docs/design/`, runbooks in `docs/runbooks/`. `.gitignore` keeps `.alpackages/` and `*.app` out. No secrets are in the repository, and the workflow uses none.

## How a change reaches main

1. `git switch -c feature/<what>` from `main`, commit, `git push -u origin feature/<what>`.
2. Open a pull request into `main`. The workflow `.github/workflows/build.yml` runs on the pull request.
3. Merge only when the `compile` job is green. Making that a rule is a GitHub setting that needs repository admin rights and **has not been set up here**: Settings, Branches, branch protection rule for `main`, "Require status checks to pass" and choose `compile`. (Branch protection on a private repository needs a paid GitHub plan.)

## What the workflow does

On pull requests to main (and manually): installs BcContainerHelper, creates a compiler folder for BC 28 (compiler and symbols, no Docker), compiles `app/` and `test/` with CodeCop, UICop, PerTenantExtensionCop and the project's ruleset (`-failOn error`), and uploads the two `.app` files as a build artifact for 14 days. The result is read in the repository under Actions, run "Build"; the compile output is in the job log.

## What it does NOT do

- It was **not run**: I cannot start a GitHub runner from here. The YAML is syntactically valid (parsed with a YAML parser); the BcContainerHelper parameter names (`Compile-AppWithBcCompilerFolder`, `New-BcCompilerFolder`, `-failOn`, `-rulesetFile`) come from my knowledge of the module, not from a run, so check the first log.
- It does **not run the tests** (codeunit 50140): that needs a Business Central container or a server (see `run-tests.md`). The checklist item "tests passed in the pipeline" is therefore open. Library Assert and Any come from the test toolkit; the compiler folder may not contain them, in which case the test compile fails until they are added to the symbols folder.
- No publishing, no deployment, no secrets, and no `push` trigger, so branch pushes (including the step branches here) start nothing.
- No pull request flow was exercised ("a change reached main through a PR after the build passed" is open).

## If you want AL-Go instead

Create a repository from the AL-Go-PTE template, add both projects as AL-Go projects, and follow the AL-Go documentation (workshop linked from Learn's "Overview of AL-Go") for the CI/CD workflow. AL-Go keeps its secrets in GitHub repository or organization secrets as documented there; none is needed for a CI-only setup. AL-Go also runs the tests in a container on the runner, which is what this minimal workflow lacks. Note from Learn: Microsoft phases out BcContainerHelper in AL-Go, with support ending October 1, 2027.

## For Mette and the next developer

The code is in one shared place on GitHub with full history. Every change is made on its own branch and is compiled automatically, with the same quality rules every time, before it is merged. Whether the merge is blocked by a failed build is a setting the GitHub owner still has to switch on.
