# Step 36: Put it in Git and build it in a pipeline

- `.github/workflows/build.yml`: GitHub Actions workflow that compiles `app/` and `test/` with the BC 28 compiler (BcContainerHelper compiler folder) and the analyzers plus the project ruleset, uploads the `.app` files. Triggers: pull request to main and manual. Permissions `contents: read`; no secrets, no deployment.
- `docs/runbooks/pipeline.md`: where the code lives, how a change reaches main, where to read the result, AL-Go as the documented alternative (and its source: the AL-Go repository documentation).

| Checklist item | Status |
|---|---|
| Repository from the AL-Go template, both apps | Not AL-Go; one repository with both projects. The choice of a minimal workflow is stated in the runbook |
| Change on a branch, PR, build passed | Not done: needs a pull request and a runner. (The step branches are pushed to origin; no PR was opened.) |
| Latest run green, both apps compiled, 50140 passed | Not done: workflow never ran. The same compile does run locally via `scripts/compile.sh` (0 errors). Tests are not part of the workflow (needs a container) |
| No secrets or `.alpackages` in the repo | Done: `.gitignore`, no secrets anywhere; the workflow uses none |
| Note says where secrets are kept per the AL-Go docs, names the docs | Runbook, "If you want AL-Go instead" |

The workflow YAML was validated with a YAML parser; GitHub's own schema check (actionlint) was not available here.
