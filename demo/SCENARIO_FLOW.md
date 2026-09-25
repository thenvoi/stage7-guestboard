# Stage 7 conference scenario

This is the operator runbook for an 8–10 minute collaboration demo inside the
25-minute session. It removes codebase exploration and open-ended design time. The
collaboration events, source handoffs, fast test, and QA review remain real. Full
automation and optional browser confirmation belong to operator preflight.

Do not attach this runbook to the room. Attach `demo/WORK_PLAN.md`; it contains the
audience-safe delivery plan and structured software-architecture diagram.

## Controls

Edit `demo/scenario-control.json` before starting any agents.

- `enabled: true` activates this conference flow.
- `transition_mode: "hitl"` enables the one purposeful presenter decision. Use it
  on stage. `"continuous"` skips it for timing rehearsals.
- `cast: "minimal"` is the supported stage cast: Architect, Developer, Engineering
  Manager, and QA Engineer.
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

The structured `arch` block is the Guestboard software architecture: browser UI,
shared guest-list logic, and static preview delivery. It is not a process diagram.
The Architect owns the initial publication and acceptance contract. Engineering
Manager owns later component focus and status updates.

## Task model

Engineering Manager receives the accepted contract from the Architect and creates
these three shared cards in order:

| Shared task | Initial owner | Diagram component | Completion evidence |
|---|---|---|---|
| Repair normalization order | Claude Developer | `guest-normalizer` | exact commit and fast Node result |
| Review core behavior | QA Engineer | `guest-normalizer` | QA verdict on exact revision |
| Summarize delivery evidence | Engineering Manager | none | revision, evidence, limitations |

Live board IDs are authoritative. Each role separately creates its native/private
tasks and links the applicable one to its assigned shared card.

| Agent | Private/native tasks |
|---|---|
| Copilot Architect | `Publish plan and architecture map`; `Delegate bounded repair scope`; `Request desktop coordination` |
| Claude Developer | `Repair guest normalization order`; `Run regression and commit repair`; `Hand exact revision to QA` |
| Engineering Manager | `Coordinate team and shared board`; `Track implementation and review gates`; `Publish final evidence summary` |
| QA Engineer | `Review exact candidate revision`; `Assess normalization contract`; `Report QA verdict` |

The Manager must visibly maintain its three tasks: complete the first after QA is
present and all three shared cards are in place, complete the second after QA's
verdict, and complete the third after publishing closeout.

## Message sequence

These are content contracts, not canned lines. Every result uses observed values.

| Trigger | Sender → recipient | Required content |
|---|---|---|
| terminal intake | Architect → Developer | symptom, sample, expected cards/count, preservation rules, ownership request |
| Developer accepts | Developer → Architect | brief acceptance of behavior and ownership |
| presenter switches surfaces | Architect → Engineering Manager | contract, plan/diagram status, active Developer handoff |
| work dispatched | Manager → Developer | shared card ID, component, exact scope, committed handoff request |
| work dispatched | Manager → QA | review card ID, independence rule, exact evidence expectation |
| QA prepares review | QA → Developer | exact revision and evidence requested |
| candidate ready | Developer → QA | exact commit and actual fast command/result |
| QA review complete | QA → Manager | exact revision, Developer evidence, QA verdict, limitation |
| closeout | Manager → room | contract, revision, evidence chain, ownership, limitations |

Every actionable request names one recipient. Avoid generic chatter and unsupported
claims such as “tests pass” without the command and revision context.

## Before the audience arrives

Prepare these identities:

| Role | Surface/runtime | Purpose |
|---|---|---|
| Copilot Architect | attached Copilot terminal | framing, plan, first presenter gate |
| Claude Developer | attached Claude terminal | bounded implementation and revision handoff |
| Engineering Manager | Jam-hosted Codex | desktop coordination and closeout |
| QA Engineer | Jam-hosted runtime | independent exact-revision review |

1. Run `./demo/prepare-iteration.sh demo/<run-name>` from
   `demo-scripted-baseline-v9`. Never reuse a repaired branch.
2. Put the Architect and Developer on that exact starting revision. Prepare runtime
   access and dependencies before the session.
3. Offstage, confirm baseline checks pass, retain the expected failing regression, and
   preflight the repaired browser behavior.
4. Start Architect and Developer in two terminals in the same fresh room. Confirm the
   Engineering Manager and QA Engineer are discoverable before the public run. Do not
   reuse a room with old messages, tasks, plans, or HITL requests.
5. Optionally open the preview on the exact run branch if the presenter wants to show
   the UI; the agent flow does not wait for or ask about it.
6. Check that `demo/WORK_PLAN.md` renders its plan and software architecture map.
7. Keep a clearly labelled prerecorded fallback available.

## Section 1 — two terminals, two isolated contexts (about 2 minutes)

**Owners:** Copilot Architect and Claude Developer.

The Architect publishes the plan and software architecture map, then sends the bounded
guest-identity contract to the Developer. The Developer gives a brief acknowledgement
of the behavior and ownership. Public messages describe the engineering work, not the
private run controls.

**Visible state:** plan and architecture map published; concise Architect → Developer
handoff; Developer ownership acknowledgement.

**Presenter gate:** Architect asks whether to move to desktop coordination. On continue,
the Architect adds and briefs the Engineering Manager. On pause, wait.

## Section 2 — desktop makes ownership shared (about 1 minute)

**Owner:** Engineering Manager.

The Manager enters the existing room and immediately creates its three private tasks,
starting `Coordinate team and shared board`. It brings in QA, records the Architect's
accepted contract, creates all three shared cards, completes its first private task,
starts `Track implementation and review gates`, and directly dispatches Developer and
QA. There is no additional presenter question.

## Section 3 — implementation and independent review (about 3 minutes)

**Owners:** Claude Developer and QA Engineer, coordinated by Engineering Manager.

Developer makes the prepared normalization-order repair, runs
`node --test tests/regression.test.mjs`, commits the result, and sends QA the exact
commit and observed output. This handoff is direct; it does not ask the presenter for
permission.

QA reviews the exact revision and Developer evidence without editing implementation,
then sends its verdict directly to the Manager. QA does not ask the room for preview
state.

**Visible state:** the shared normalizer card moves through Developer ownership and QA
review with one exact revision attached.

## Section 4 — evidence closeout (about 1 minute)

**Owner:** Engineering Manager.

After QA sends its verdict, no further approval or preview question is required.

Manager completes `Track implementation and review gates`, starts and completes
`Publish final evidence summary` around the room closeout, and summarizes the product
contract, exact source revision, Developer unit evidence, QA verdict, and limitations.
The Manager states that the agreed visible outcome is two cards/count two without
claiming personal preview observation. End on the Work board and software architecture
map.

## Recovery cuts

- If a HITL question fails to surface, state the bridge problem and make the presenter
  intervention visible before continuing.
- If implementation is late, use the last reviewed rehearsal commit only as a clearly
  labelled fallback.
- If QA finds a blocker, return it to the Developer. A truthful red result still
  demonstrates coordination.
