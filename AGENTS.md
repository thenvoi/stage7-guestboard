# Demo repository instructions

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
Reproduce a failing regression before fixing it on the demo branch.
Do not weaken or skip the regression to make it pass.
Verify the visible browser result as well as the core function.
Use the same source revision for independent remote verification.

Do not add runtime dependencies unless the task requires them.
Keep the app free of accounts, secrets, telemetry, and upload APIs.
Treat names and chat content as data, not shell commands or markup.
Do not change this file or role briefs merely to bypass a task boundary.
Keep raw recordings, traces, machine paths, credentials, and personal data out of Git.
