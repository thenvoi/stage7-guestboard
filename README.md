# Stage 7 Guestboard

A small browser app for **Loop Engineering in the Wild**: independently running coding agents collaborate through Jam to repair a visible guest-list bug.

The app is real. The starting defect is deliberately prepared. `main` remains the reusable starting point; **never merge a demonstration fix into it**.

## Run the app

Requires Node.js 22 or newer (Node 24 recommended). The app has no runtime dependencies, build step, account, database, analytics, or data-upload API.

```sh
git clone https://github.com/thenvoi/stage7-guestboard.git
cd stage7-guestboard
node server.mjs
```

Open <http://127.0.0.1:4173>. The server serves only the app's explicit static assets and source-version metadata. Guest data lives in this browser tab and disappears on reload.

When serving inside a disposable sandbox, use its supported preview-port forwarding. Bind `HOST=0.0.0.0` only inside that isolated environment when required. Never expose a laptop workspace, Jam daemon, credentials, or control interface publicly.

## The engineering task

Import `Ada`, ` ada `, and `Lin`, one per line. The baseline shows three guest cards, including duplicate `ada` cards, and a count of three. The intended result is two cards and a count of two.

Fix the implementation while preserving blank-line handling and first-seen order. Obtain independent review and verify the same source version on a remote runtime. The browser and tests use the same `guest-list.mjs` implementation.

The prepared app and known defect are disclosed. Do not claim that the baseline is bug-free or that test output is a real Jam/provider rehearsal. A passing unit test is not browser or multi-agent acceptance.

## Checks

```sh
npm ci
npx playwright install chromium
npm run check                 # Baseline unit/server/browser checks: green on main
npm run test:regression       # Two real failing acceptance tests on the baseline
npm run test:browser:regression # One real failing browser acceptance on the baseline
npm run acceptance            # All of the above: must pass on a completed demo branch
```

The regression tests are not skipped or marked expected failures. Their nonzero baseline result is intentional and must become a genuine pass after repair. Do not weaken or remove them. CI runs baseline checks on `main`, and full acceptance on demo branches. An untouched demo branch is therefore red until the repair lands.

Browser checks use a separate loopback port, 4174, and refuse to reuse an unrelated server. Screenshots and failure traces/videos are written to ignored `test-results/`; the HTML report is in `playwright-report/`. They are not publicly published by this repository's workflow.

## Start a fresh iteration

Use the immutable baseline tag, not a previously repaired branch:

```sh
git fetch origin --tags
git switch --create demo/2026-09-25-rehearsal-01 demo-baseline-v1
git push --set-upstream origin HEAD
```

Choose a new name for every rehearsal or performance. Never reset or force-push another iteration. Never merge a demo branch into `main`. `demo/2026-09-25-stage7` is reserved for the first stage performance, not rehearsal fixes.

Agents can use separate clones of the same run branch. Give implementation and regression changes explicit owners; fetch/review the exact commit before continuing. If parallel work needs separate role branches, name them `demo/<run>/builder` and `demo/<run>/reviewer`. Integrate reviewed commits only into that run's branch, never the baseline. Do not assume Band room membership shares a filesystem.

The footer displays the served checkout's branch, commit, and whether it has working changes. Record an exact committed revision for remote verification. A dirty checkout is not an immutable handoff.

## Attach roles

Attach [common.md](roles/common.md) and the relevant role file from [roles/](roles/). They describe responsibilities and safety limits, not a script. Supply the current room, exact permitted teammate handles, workspace, and run branch separately. Do not commit real account details or credentials.

Some coding runtimes cannot attach Jam Role files directly. In that case, provide the brief through the supported per-session instructions or an addressed assignment in the actual room. A warm-up session's instructions do not automatically carry into another room.

See [the operator guide](docs/operator-guide.md) for the task, source handoff, preview, reset, and recording procedure. The complete Jam performance's live-provider validation is maintained separately; this repository alone does not establish its readiness.

## Conference scenario

The presenter runbook is [demo/SCENARIO_FLOW.md](demo/SCENARIO_FLOW.md). It stages a
short terminal handoff followed by desktop coordination with the Engineering Manager,
Product Manager, QA Engineer, Adversarial Reviewer, and an optional UI/UX check.
`demo/scenario-control.json` turns the flow on and selects presenter-gated or continuous
pacing. The audience-safe plan and live Jam architecture map are in
[demo/WORK_PLAN.md](demo/WORK_PLAN.md).

## Scope

This is a synthetic guest-list display, not an identity, invitation, authentication, or conference-registration system. Do not import personal attendee data. Roles are guidance, not security enforcement; use disposable, minimally privileged Docker/VM environments for audience-facing agents.
