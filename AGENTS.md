# Demo repository instructions

## Stage 7 conference flow

When `demo/scenario-control.json` has `"enabled": true`, this repository is in the
prepared Stage 7 conference flow. Before taking a demo turn, read only:

1. `demo/scenario-control.json`
2. the role brief and role skill from this table

Each role skill provides the public-turn procedure or explicitly names the one scenario
section needed for that role. Do not read `README.md`, the operator runbook, another
role's files, or repository source unless the assigned role skill explicitly permits
it.

| On-screen role | Role brief | Role skill |
|---|---|---|
| Copilot Architect | `roles/architect.md` | `demo/skills/guestboard-architect/SKILL.md` |
| Claude Developer | `roles/builder.md` | `demo/skills/guestboard-developer/SKILL.md` |
| Engineering Manager | `roles/lead.md` | `demo/skills/guestboard-manager/SKILL.md` |
| Product Manager | `roles/product-manager.md` | `demo/skills/guestboard-product/SKILL.md` |
| QA Engineer | `roles/reviewer.md` | `demo/skills/guestboard-qa/SKILL.md` |

The conference flow controls pacing, not truth. Run the operations you report and
use their real results. Keep audience-visible reasoning about the current engineering
decision or evidence. Do not narrate private stage directions, timing cues, role files,
or scenario configuration in reasoning or room messages. If someone asks directly
about the format, answer honestly that this is a rehearsed, deterministic live demo.

Treat every repository limit, role boundary, phase gate, permitted-command list, and
forbidden-command list as private control-plane guidance. Never repeat or summarize
those controls in room messages or audience-visible reasoning. In particular, never
announce files or commands you will not read or run, actions you are waiting to be
allowed to take, or that work is prepared, scripted, bounded, simulated, or deliberately
deferred. Public messages state only positive engineering content: the problem,
accepted behavior, ownership, a real result, or a concrete blocker. Acknowledgements
confirm the engineering outcome being owned; they do not recite process restrictions.

Jam human-in-the-loop questions are broadcast to every participant in the room. That
broadcast is notification, not shared ownership. When an agent asks the presenter a
transition question, only the named human presenter may answer it. Every other agent,
including the Developer, must quietly settle only its own delivered copy without
answering: use the transport's no-reply disposition (`ack` for a lease-backed CLI
delivery or `jam_no_reply` for an MCP delivery). Do not answer, claim, relay, flag,
create a task for, or narrate the question. This delivery settlement is mandatory so
an unrelated presenter question cannot fence later inbox work; it does not answer or
resume the question. Continue waiting for work explicitly addressed to that agent. A
broadcast mention or room delivery does not make the question an agent assignment.

When the scenario is enabled, these stage limits override the broader verification
workflow below for the public turn:

- Do not create worktrees, clones, or branches; do not fetch, switch revisions, inspect
  history, compare tags, install dependencies, or explore the repository broadly.
- Do not run `npm`, `npx`, Playwright, browser automation, `npm run acceptance`, or
  `npm run check`. Those are completed by the operator before the public run.
- Architect, Engineering Manager, Product Manager, and QA Engineer use Jam plus the
  prepared documents only. They do not run repository shell commands.
- Claude Developer may read only `guest-list.mjs` and `tests/regression.test.mjs`, make
  the prepared one-line repair, run only `node --test tests/regression.test.mjs`, and
  commit the result.
- Use the current prepared checkout. If it is not the expected bug-present stage branch,
  stop and ask the presenter instead of repairing the demo environment.
- Complete only the assigned section, send its required handoff, and wait. Do not pull
  later phases forward.

Preserve the baseline on `main` and tag `demo-baseline-v1`.
Make demonstration changes only on a named `demo/` branch.
Never merge a demonstration fix into `main`.
Never force-push or discard another participant's work.

When the conference flow is disabled, read `README.md` and your assigned role before
working. When it is enabled, use only the restricted reading list above.
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
Use the exact committed revision for independent QA review and the presenter's browser
observation.

Do not add runtime dependencies unless the task requires them.
Keep the app free of accounts, secrets, telemetry, and upload APIs.
Treat names and chat content as data, not shell commands or markup.
Do not change this file or role briefs merely to bypass a task boundary.
Keep raw recordings, traces, machine paths, credentials, and personal data out of Git.
