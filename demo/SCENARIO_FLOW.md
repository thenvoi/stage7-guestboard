# Stage 7 conference scenario

This is the operator runbook for an 8–10 minute collaboration demo inside the
25-minute session. It removes codebase exploration and open-ended design time. The
collaboration events, source handoffs, fast test, and QA evidence review remain real. Full
automation and optional browser confirmation belong to operator preflight.

Do not attach this runbook to the room. Attach `demo/WORK_PLAN.md`; it contains the
audience-safe delivery plan and structured software-architecture diagram.

## Controls

Edit `demo/scenario-control.json` before starting any agents.

- `enabled: true` activates this conference flow.
- `transition_mode: "hitl"` enables the one purposeful presenter decision. Use it
  on stage. `"continuous"` skips it for timing rehearsals.
- `cast: "minimal"` is the supported stage cast: Architect, Developer, Engineering
  Manager, and QA Manager.
- `execution_mode: "bounded-live"` keeps every role on its assigned contribution.
- `live_check: "node-regression-only"` permits the Developer's fast Node regression.
- `browser_check: "operator-optional"` keeps preview display outside the agent flow.
- `allow_worktrees` and `allow_browser_automation` must remain `false`.
- `evidence_policy` must remain `"observed-only"`.

The one presenter decision is:

1. Architect: move from the two terminals to desktop coordination.

Routine assignment, implementation, review handoff, and closeout do not need human
approval. They proceed through addressed room messages.

A native HITL question is broadcast to all participants. Only the named presenter may
answer it. Every other agent quietly settles only its delivery copy with `ack` for CLI
lease delivery or `jam_no_reply` for MCP delivery. That bookkeeping neither answers
nor resumes the question and prevents an unrelated question from fencing later work.

## Plan and diagram ownership

Copilot Architect publishes the shared plan during Section 1:

```sh
jam plan set <chat-id> demo/WORK_PLAN.md --snapshot
```

Do not re-run `plan set` mid-run: attaching a new snapshot resets every component's
color.

The structured `arch` block is the Guestboard web app as three layers, like a
frontend/backend/database map:

| Layer | Components |
|---|---|
| `browser-ui` — Browser UI | `import-form`, `guest-board` |
| `guest-core` — Guest-list core | `input-parser`, `guest-normalizer` |
| `preview-delivery` — Preview delivery | `preview-server`, `source-version` |

It is not a process diagram. `import-form` and `preview-server` are context only; no
work touches them and they stay uncolored.

### How the map shows progress

The map's colors come only from plan overlay commands, never from task status:

```sh
band plan focus  <chat-id> <component> --note "<short caption>"   # blue: working here now
band plan status <chat-id> <component> done --note "<evidence>"   # green: finished
band plan status <chat-id> <component> blocked --note "<reason>"  # red: blocked
```

Only one component can be blue at a time; a new `focus` dims the previous blue
component to idle. A component turns green only after the evidence named in its note
exists. Each owner colors its own component, so the map moves through the layers as
the work moves:

| Order | Component | Blue (who, when) | Green (who, when) |
|---|---|---|---|
| 1 | `guest-board` | Architect, after publishing the plan | Manager, after the closeout summary |
| 2 | `guest-normalizer` | Developer, when the repair starts | Developer, after the edit |
| 3 | `input-parser` | Developer, before the regression run | Developer, with the observed 2/2 result |
| 4 | `source-version` | QA, when the review starts | QA, with a `PASS` verdict (red with `BLOCKED`) |
| 5 | `guest-board` | Manager, when closeout starts | Manager, after the closeout summary |

End state: `guest-board`, `guest-normalizer`, `input-parser`, and `source-version` are
green.

### How the board links to the map

Clicking a component filters the Work board to tasks whose subject contains that
component id as a word. Every shared card and every component-related private task
therefore starts with its component id (`guest-normalizer: …`). Shared cards also carry
a `Components: <id>` line in their detail. Do not pass `--component` flags to a Band
room board; it rejects them. Clicking a layer header matches only the layer id, so the
filter works on components, not layers.

## Task model

Engineering Manager receives the accepted contract from the Architect and creates
these four shared cards in order:

| Shared card | Owner | Component | Completion evidence |
|---|---|---|---|
| `guest-normalizer: Repair normalization order` | Claude Developer | `guest-normalizer` | the edit: normalize before deduplication |
| `input-parser: Prove audience import yields two guests` | Claude Developer | `input-parser` | observed `node --test tests/regression.test.mjs` result and exact commit |
| `source-version: Review supplied repair evidence` | QA Manager | `source-version` | one evidence-review verdict for the exact revision |
| `guest-board: Summarize delivery evidence` | Engineering Manager | `guest-board` | contract, revision, evidence chain, limitations |

Live board IDs are authoritative. Each role separately creates its native/private
tasks and links the applicable one to its shared card.

| Agent | Private/native tasks |
|---|---|
| Copilot Architect | `Publish plan and architecture map`; `guest-board: Agree visible contract`; `Request desktop coordination` |
| Claude Developer | `guest-normalizer: Repair normalization order`; `input-parser: Run audience-import regression`; `source-version: Commit and hand revision to QA` |
| Engineering Manager | `Coordinate team and shared board`; `Track implementation and review gates`; `guest-board: Publish final evidence summary` |
| QA Manager | `source-version: Check supplied repair summary`; `source-version: Match reported result to contract`; `source-version: Report evidence-review verdict` |

The Manager must visibly maintain its three tasks: complete the first after QA is
present and all four shared cards are in place, complete the second after QA's
verdict, and complete the third after publishing closeout.

## Message sequence

These are content contracts, not canned lines. Every result uses observed values.

| Trigger | Sender → recipient | Required content |
|---|---|---|
| terminal intake | Architect → Developer | symptom, sample, expected cards/count, preservation rules, ownership request |
| Developer accepts | Developer → Architect | brief acceptance of behavior and ownership |
| presenter switches surfaces | Architect → Engineering Manager | contract, plan/diagram status, active Developer handoff, and all four card definitions including owners/components/evidence |
| work dispatched | Manager → Developer | both shared card IDs and components, exact scope, committed handoff request |
| work dispatched | Manager → QA | review card ID and component, the three exact private-task names, and one-pass evidence-review contract |
| candidate ready | Developer → QA | exact commit, one-line repair summary, preservation statement, and actual fast command/result |
| QA evidence review complete | QA → Manager | one PASS/BLOCKED verdict with exact revision and Developer-reported result |
| closeout | Manager → room | contract, revision, evidence chain, ownership, limitations |

Every actionable request names one recipient. Avoid generic chatter and unsupported
claims such as “tests pass” without the command and revision context.

## Before the audience arrives

Prepare these identities:

| Role | Surface/runtime | Purpose |
|---|---|---|
| Copilot Architect | attached Copilot terminal | framing, plan, first presenter gate |
| Claude Developer | attached Claude terminal | bounded implementation and revision handoff |
| Engineering Manager | Jam-hosted Codex (`gpt-5.6-sol`, high) | desktop coordination and closeout |
| QA Manager | Jam-hosted Claude Code (`claude-opus-5-5`, high) | fast supplied-evidence review |

1. Run `./demo/prepare-iteration.sh demo/<run-name>` from
   `demo-scripted-baseline-v12`. Never reuse a repaired branch.
2. Put the Architect and Developer on that exact starting revision. Prepare runtime
   access and dependencies before the session.
3. Offstage, confirm baseline checks pass, retain the expected failing regression, and
   preflight the repaired browser behavior.
4. Run `./demo/jam-agents.sh` against the presenter's Band account to create or update
   the Engineering Manager and QA Manager agents (see the README's Jam-hosted agents
   section). Use `--check` to confirm settings and `--cleanup --yes` to remove them
   after the performance.
5. Start Architect and Developer in two terminals in the same fresh room. Confirm the
   Engineering Manager and QA Manager are discoverable before the public run. Do not
   reuse a room with old messages, tasks, plans, or HITL requests.
   Read-only repository access may be provided to the Docker Manager, but the Architect
   handoff remains self-contained and must not depend on that access.
6. Optionally open the preview on the exact run branch if the presenter wants to show
   the UI; the agent flow does not wait for or ask about it.
7. Check that `demo/WORK_PLAN.md` renders its plan, both Mermaid diagrams (codebase
   architecture and where the issue is), and the three-layer architecture map with connector
   labels. Run all four identities against the same Band daemon
   (the same `JAM_CONFIG_DIR`): plan overlay colors are local to that daemon, so a
   focus/status update made through another daemon will not show on the presenter's
   desktop. Use a fresh room so the map starts uncolored.
8. Keep a clearly labelled prerecorded fallback available.

## Section 1 — two terminals, two isolated contexts (about 2 minutes)

**Owners:** Copilot Architect and Claude Developer.

The Architect publishes the plan and software architecture map, focuses
`guest-board` with the visible contract as its caption, then sends the bounded
guest-identity contract to the Developer. The Developer gives a brief acknowledgement
of the behavior and ownership. Public messages describe the engineering work, not the
private run controls.

**Visible state:** plan and architecture map published; `guest-board` blue with the
contract caption; concise Architect → Developer handoff; Developer ownership
acknowledgement.

**Presenter gate:** Architect asks whether to move to desktop coordination. On continue,
the Architect adds and briefs the Engineering Manager, including the exact four shared
card definitions. On pause, wait.

## Section 2 — desktop makes ownership shared (about 1 minute)

**Owner:** Engineering Manager.

The Manager enters the existing room and immediately creates its three private tasks,
starting `Coordinate team and shared board`. It brings in QA, records the Architect's
accepted contract, creates all four component-prefixed shared cards, completes its
first private task, starts `Track implementation and review gates`, and directly
dispatches Developer and QA. It does not request card metadata or plan access and does
not change the map colors in this section. There is no additional presenter question.

**Visible state:** four shared cards in To-do, one per component; clicking a component
in the map filters the board to its card.

## Section 3 — implementation and fast evidence review (about 2 minutes)

**Owners:** Claude Developer and QA Manager, coordinated by Engineering Manager.

Developer focuses `guest-normalizer`, makes the prepared normalization-order repair,
and marks `guest-normalizer` done. It then focuses `input-parser`, runs
`node --test tests/regression.test.mjs`, marks `input-parser` done with the observed
result, commits, and sends QA the exact commit and observed output. This handoff is
direct; it does not ask the presenter for permission.

QA focuses `source-version` and compares only the Developer's complete room handoff
with the accepted contract. It does not inspect or execute the repository. It completes
its three named tasks in one pass, marks `source-version` done for `PASS` or blocked
for `BLOCKED`, sends one verdict directly to the Manager, and sends no intermediate
status or duplicate recap.

**Visible state:** the map turns blue then green from the core layer
(`guest-normalizer`, `input-parser`) to delivery (`source-version`); the matching cards
move through In progress to Done with one exact revision attached.

## Section 4 — evidence closeout (about 1 minute)

**Owner:** Engineering Manager.

After QA sends its verdict, no further approval or preview question is required.

Manager completes `Track implementation and review gates`, focuses `guest-board`,
starts and completes `guest-board: Publish final evidence summary` around the room
closeout, and summarizes the product contract, exact source revision, Developer unit
evidence, QA verdict, and limitations. It then completes the summary card and marks
`guest-board` done. The Manager states that the agreed visible outcome is two
cards/count two without claiming personal preview observation. End on the Work board
and software architecture map: four green components and four Done cards.

## Recovery cuts

- If a HITL question fails to surface, state the bridge problem and make the presenter
  intervention visible before continuing.
- If implementation is late, use the last reviewed rehearsal commit only as a clearly
  labelled fallback.
- If QA finds a blocker, return it to the Developer. A truthful red result still
  demonstrates coordination.
