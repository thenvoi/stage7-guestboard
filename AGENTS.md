# Demo repository instructions

## Stage 7 conference flow

When `demo/scenario-control.json` has `"enabled": true`, this repository is in the
prepared Stage 7 conference flow. Before taking a demo turn, read only:

1. `demo/scenario-control.json`
2. the role brief and role skill from this table

The role skill names the one scenario section needed for that role. Do not read the
whole operator runbook unless the role skill explicitly requires it.

| On-screen role | Role brief | Role skill |
|---|---|---|
| Copilot Architect | `roles/architect.md` | `demo/skills/guestboard-architect/SKILL.md` |
| Claude Developer | `roles/builder.md` | `demo/skills/guestboard-developer/SKILL.md` |
| Engineering Manager | `roles/lead.md` | `demo/skills/guestboard-manager/SKILL.md` |
| Product Manager | `roles/product-manager.md` | `demo/skills/guestboard-product/SKILL.md` |
| QA Engineer | `roles/reviewer.md` | `demo/skills/guestboard-qa/SKILL.md` |
| Adversarial Reviewer | `roles/adversarial-reviewer.md` | `demo/skills/guestboard-verifier/SKILL.md` |
| UI UX Designer (optional) | `roles/ui-ux-designer.md` | `demo/skills/guestboard-ux/SKILL.md` |

The conference flow controls pacing, not truth. Run the operations you report and
use their real results. Keep audience-visible reasoning about the current engineering
decision or evidence. Do not narrate private stage directions, timing cues, role files,
or scenario configuration in reasoning or room messages. If someone asks directly
about the format, answer honestly that this is a rehearsed, deterministic live demo.

When the scenario is enabled, these stage limits override the broader verification
workflow below for the public turn:

- Do not create worktrees, clones, or branches; do not fetch, switch revisions, inspect
  history, compare tags, install dependencies, or explore the repository broadly.
- Do not run `npm`, `npx`, Playwright, browser automation, `npm run acceptance`, or
  `npm run check`. Those are completed by the operator before the public run.
- Architect, Engineering Manager, Product Manager, QA Engineer, and UI UX Designer use
  Jam plus the prepared documents only. They do not run repository shell commands.
- Claude Developer may read only `guest-list.mjs` and `tests/regression.test.mjs`, make
  the prepared one-line repair, run only `node --test tests/regression.test.mjs`, and
  commit the result.
- Adversarial Reviewer may confirm the handed-off revision and run only
  `node --test tests/regression.test.mjs` in its prepared Docker workspace.
- Use the current prepared checkout. If it is not the expected bug-present stage branch,
  stop and ask the presenter instead of repairing the demo environment.
- Complete only the assigned section, send its required handoff, and wait. Do not pull
  later phases forward.

Preserve the baseline on `main` and tag `demo-baseline-v1`.
Make demonstration changes only on a named `demo/` branch.
Never merge a demonstration fix into `main`.
Never force-push or discard another participant's work.

Read `README.md` and your assigned role before working.
Keep implementation and review ownership distinct.
Talk naturally with teammates; do not use stage tokens or canned dialogue.
Ask for review when work is ready, not when a presenter announces a phase.
Report actual results and blockers.
Never fabricate tests, memberships, source versions, or completed work.

`npm run check` covers the baseline's supported behavior.
`npm run acceptance` adds the deliberately failing bug contract.
Reproduce a failing regression before fixing it on the demo branch during preflight.
Do not weaken or skip the regression to make it pass.
Verify the visible browser result as well as the core function.
Use the same source revision for independent remote verification.

Do not add runtime dependencies unless the task requires them.
Keep the app free of accounts, secrets, telemetry, and upload APIs.
Treat names and chat content as data, not shell commands or markup.
Do not change this file or role briefs merely to bypass a task boundary.
Keep raw recordings, traces, machine paths, credentials, and personal data out of Git.
