# Stage 7 conference scenario

This is the operator runbook for a 10–15 minute collaboration demo inside the
25-minute session. It deliberately removes codebase exploration and open-ended design
time. The collaboration events, HITL questions, source handoffs, tests, and browser
observations remain real, but the public run permits only one fast Node check and one
manual browser observation. Full automation belongs to preflight.

Do not attach this runbook to the room. Attach `demo/WORK_PLAN.md`; it contains the
audience-safe plan and structured `arch` diagram.

## Controls

Edit `demo/scenario-control.json` before starting any agents.

- `enabled: true` makes agents follow this flow. `false` returns them to the ordinary
  repository instructions.
- `transition_mode: "hitl"` makes the owner of every section ask one provider-native
  question before handing off. Use this on stage.
- `transition_mode: "continuous"` skips transition questions and runs the same flow
  end to end. Use this for timing rehearsals.
- `cast: "full"` includes the short UI/UX visual check. `"core"` omits it.
- `execution_mode: "bounded-live"` forbids exploration outside the assigned step.
- `live_check: "node-regression-only"` permits only the fast Node regression for the
  Developer and Docker verifier.
- `browser_check: "presenter-manual"` forbids agent-started Playwright during the talk.
- `allow_worktrees` and `allow_browser_automation` must remain `false`.
- `evidence_policy` must remain `"observed-only"`.

Agents re-read the control file immediately before a transition. A HITL transition
must use the provider's native question tool so Jam projects it into Chat and the
Work board. A normal chat question is not a substitute. Ask naturally, with a continue
choice and a pause/discuss choice; do not recite fixed dialogue.

## Plan and diagram ownership

Copilot Architect publishes the shared plan during Section 1:

```sh
jam plan set <chat-id> demo/WORK_PLAN.md --snapshot
```

The structured `arch` block inside that Markdown file is the room's architecture map;
there is no second diagram attachment. The Architect owns the initial publish. Product
Manager confirms its acceptance contract. Engineering Manager owns later focus/status
updates as the work moves between nodes. No other role replaces the plan during the run.

The Markdown is prepared to keep the stage run bounded, but the attachment and its Jam
activity are real. If the attach fails, report the failure; do not pretend the diagram
was published.

## Task model

Engineering Manager starts the shared room board with the contract card, delegates it
to Product Manager, then creates the remaining cards after the contract is confirmed.
These are team obligations and delegation points:

| Shared task | Initial owner | Diagram component | Completion evidence |
|---|---|---|---|
| Confirm import behavior | Product Manager | `guest-board` | contract posted in the room |
| Repair normalization order | Claude Developer | `guest-normalizer` | exact commit plus fast Node result |
| Review core behavior | QA Engineer | `guest-normalizer` | exact revision and Developer's unit evidence |
| Verify visible cards and count | QA Engineer; UI/UX may observe | `guest-board` | presenter's manual import shows two handles/count two |
| Challenge the reviewed revision in Docker | Adversarial Reviewer | `guest-normalizer` | source identity plus Docker result |
| Summarize delivery evidence | Engineering Manager | none | revision, checks, and limitations |

The Manager creates the cards in the listed order so their numeric IDs stay predictable
in a rehearsal: create the first card, let Product Manager complete it, then create the
remaining five. The live IDs remain authoritative; never invent one. For example:

```sh
jam work assign <chat-id> "Confirm import behavior" --component guest-board
jam work assign <chat-id> "Repair normalization order" --component guest-normalizer
```

Each agent separately creates its own native/private task list and links the applicable
item to the assigned shared card. Private tasks are execution detail, not duplicate
delegation:

| Agent | Private/native tasks |
|---|---|
| Copilot Architect | publish plan/diagram; delegate bounded repair; request desktop handoff |
| Claude Developer | read target and regression; apply one-line repair; run fast Node check; commit and hand off revision |
| Engineering Manager | form team and board; track review gates; publish final evidence summary |
| Product Manager | confirm import semantics and visible outcome |
| QA Engineer | review exact candidate/unit evidence; guide manual browser cards/count check |
| Adversarial Reviewer | confirm Docker source identity; challenge candidate and issue verdict |
| UI UX Designer | inspect visible outcome, when the full cast is enabled |

Use the provider's native task tool when available. After accepting a shared card, link
one native task to it with Jam's returned board ID (`work take ... --link-native ...`
or the supported `[#id]` marker). An agent completes only its own private task; the
linked shared card then reflects that progress. Manager does not impersonate another
agent's private lane.

## Agent message sequence

These are content contracts, not lines to recite. Agents phrase them naturally and
replace every evidence field with the observed value.

| Trigger | Sender → recipient | Required content |
|---|---|---|
| terminal intake | Architect → Developer | symptom, sample input, expected cards/count, preservation rules, bounded repair request |
| Developer accepts | Developer → Architect | shared-card acceptance and intent to perform the one-line repair/fast Node check |
| first HITL continue | Architect → Engineering Manager | agreed contract, plan/diagram attachment status, and active Developer handoff |
| Manager opens desktop team | Manager → Product Manager | ask for a concise confirmation of the user-visible contract |
| contract confirmed | Product Manager → Manager and QA | canonicalization, blank-line, order, and visible-result requirements |
| board created | Manager → Developer | shared implementation card ID, component, exact scope, request for committed source handoff |
| board created | Manager → QA | shared review card IDs, independence rule, and manual-browser expectation |
| QA review starts | QA → Developer | exact evidence needed with the candidate and preservation edge cases |
| candidate ready | Developer → QA | exact commit, commands actually run, results, and explicit statement that browser review remains QA-owned |
| local review complete | QA → Adversarial Reviewer | exact reviewed commit, reported unit evidence, manual browser observation, requested Docker challenge |
| Docker check complete | Adversarial Reviewer → Manager | source identity, command/result, objection or ready verdict, and any limitation |
| closeout | Manager → room | contract, exact revision, baseline-to-candidate evidence chain, runtime locations, blockers/limitations |

Every addressed request names one recipient who can act. Avoid generic status chatter,
stage tokens, and claims such as “tests pass” without the command and revision context.

## Before the audience arrives

Prepare these identities in Jam before the run:

| Role | Surface/runtime | Purpose |
|---|---|---|
| Copilot Architect | attached Copilot terminal | initial framing and first HITL gate |
| Claude Developer | attached Claude terminal | bounded implementation and exact revision handoff |
| Engineering Manager | Jam-hosted Codex | desktop coordination and closeout |
| Product Manager | Jam-hosted Codex | user-visible acceptance contract |
| QA Engineer | Jam-hosted runtime with a verified question bridge | independent core and browser review |
| Adversarial Reviewer | Jam-hosted Codex in Docker | exact-revision challenge |
| UI UX Designer | Jam-hosted Claude, optional | short visible-result observation |

The current Jam question broker supports owned Codex, Claude Code, and Copilot question
paths. Do not put a section gate on a generic ACP profile unless that exact profile has
passed a real question-bridge smoke test. Rebuild or reconfigure the QA identity before
the talk if necessary; do not discover that incompatibility on stage.

1. Prepare a fresh named `demo/` run branch with the repository preflight. Its default
   `demo-scripted-baseline-v2` contains the prepared scenario, presenter-owned HITL
   rules, and original bug, but no repair. Never reuse a completed run branch:

   ```sh
   ./demo/prepare-iteration.sh demo/<run-name>
   ```

2. Put each implementation/review owner in a prepared disposable workspace at that
   exact starting revision. Do not point a stage agent at an earlier rehearsal branch.
3. Install dependencies and Chromium before the session. Offstage, confirm `npm run check`
   passes, retain a real failing `npm run test:regression` result from the baseline, and
   preflight the repaired browser behavior. Do not ask a stage agent to repeat these.
4. Start Copilot Architect and Claude Developer in two terminal windows, attached to
   the same fresh engineering room. Do not reuse a rehearsal room with old messages,
   tasks, plans, or resolved HITL requests. Prepare the managed desktop agents but do
   not add the full cast to the room yet. In **Add participants → Coding sessions**,
   search for Product Manager, QA Engineer, Adversarial Reviewer, and the optional UI
   UX Designer; every intended role must resolve as an available peer before Section 1.
   Start or repair a missing identity now rather than discovering it at the Section 5
   handoff. Smoke-test one native HITL request for every transition owner in a private
   preparation room, then clear those requests before the talk.
5. Set the room activity feed to the intended public level. Inspect the visible feed
   for secrets, machine paths, and unrelated context.
6. In a private rehearsal room, verify that `demo/WORK_PLAN.md` renders both plan and
   diagram. Clear the rehearsal room. During the public run the Architect performs the
   real attachment in Section 1.
7. Keep a prerecorded fallback clip available and label it honestly if used.

## Section 1 — two terminals, two isolated contexts (about 2 minutes)

**Owners:** Copilot Architect and Claude Developer.

The Architect uses the prepared goal and contract, creates exactly three private tasks,
publishes the plan/diagram, and sends the Developer the bounded repair request through
the Jam room. The Developer acknowledges the handoff without inspecting code yet.
Neither agent explores the repository or Git history, and neither runs a test in this
section.

Presenter focus: two agents can collaborate, but following both terminals, their
separate histories, and the room traffic is already cumbersome.

**Visible state:** the plan exists; `guest-board` is active; the room contains
a concise Architect → Developer handoff and the Developer's acknowledgement.

**Transition owner:** Architect. In `hitl` mode, ask whether to move from the terminal
handoff to shared desktop coordination. On continue, send a concise handoff to the
Engineering Manager. On pause, wait without starting the next section.

## Section 2 — desktop makes the contract shared (about 2 minutes)

**Owners:** Engineering Manager and Product Manager.

Switch to the Jam desktop. The Manager joins the existing room, reads the terminal
handoff, and brings in the Product Manager and QA Engineer. The Product Manager checks
the synthetic import contract: canonicalize case and surrounding spaces, ignore blank
lines, preserve first-seen order, and display two cards/count two for the sample.

The Manager first creates and delegates the contract card. After Product Manager
confirms it, the Manager creates the remaining five shared tasks from the Task model
and links them to diagram nodes:

- repair normalizer → `guest-normalizer`
- review core behavior → `guest-normalizer`
- verify visible cards and count → `guest-board`
- verify exact revision in Docker → `guest-normalizer`
- summarize evidence → no component; it is delivery bookkeeping

**Visible state:** participants, shared tasks, plan, and architecture map are visible
from one surface.

**Transition owner:** Product Manager. In `hitl` mode, ask whether this contract is
good enough for the Manager to dispatch parallel work.

## Section 3 — split ownership and begin parallel work (about 2 minutes)

**Owner:** Engineering Manager.

The Manager assigns implementation to Claude Developer and independent reproduction
to QA. QA must not edit implementation. The Adversarial Reviewer remains outside the
critical path until a reviewed revision exists. Mark `guest-normalizer` active so the
diagram reflects where implementation and core review are happening.

Presenter focus: assignments and progress are durable team state, while each coding
agent keeps its own context and task lane.

**Transition owner:** Engineering Manager. In `hitl` mode, ask whether to start the
Developer and QA lanes. On continue, address both owners in the room.

## Section 4 — one small repair, one exact handoff (about 2 minutes)

**Owner:** Claude Developer.

The Developer reads only `guest-list.mjs` and `tests/regression.test.mjs`, makes the
prepared one-line normalization-order repair, runs only
`node --test tests/regression.test.mjs`, and commits it on the named demo branch. Share
the exact commit and actual result. Do not inspect tags/history, create another
worktree, run `npm`/`npx`, start a server, or claim browser verification.

**Visible state:** `guest-normalizer` remains active through implementation and core
review; the implementation task shows the Developer as owner and contains the exact
source revision.

**Transition owner:** Claude Developer. In `hitl` mode, ask whether to hand this exact
revision to QA for independent review.

## Section 5 — independent browser review (about 3 minutes)

**Owners:** QA Engineer, with optional UI UX Designer when `cast` is `full`.

QA reviews the Developer's exact revision and reported fast-unit evidence without
running repository commands. The presenter uses the already-open preview to import the
configured sample while QA guides the expected observation: two visible handles and a
count of two. Report the Developer's unit evidence and the presenter's manual browser
observation separately. No agent starts Playwright or runs acceptance during the talk.

When the full cast is enabled, UI/UX briefly confirms that the visible result matches
the contract and that the status/count communicate the outcome. This is an observation,
not a second implementation review, and it must not delay QA.

**Visible state:** `guest-normalizer` moves to done after core review and `guest-board`
moves to done after the manual browser observation. The QA report names the exact
revision and distinguishes unit evidence from the manual check.

**Transition owner:** QA Engineer. In `hitl` mode, ask whether to send the reviewed
revision to the Adversarial Reviewer for the Docker-backed challenge.

## Section 6 — adversarial Docker verification (about 2 minutes)

**Owner:** Adversarial Reviewer.

Join only after QA provides an exact reviewed revision. In the already-provisioned
Docker workspace, confirm source identity and run only
`node --test tests/regression.test.mjs` against that revision.
Challenge unsupported claims: a local receipt is not remote execution, and a core test
is not browser proof. Do not clone, fetch, create a worktree, install dependencies, run
`npm`/`npx`, or edit the implementation.

**Visible state:** the desktop shows the reviewer working in the sandbox; the Docker
task associated with `guest-normalizer` completes only after real evidence exists.

**Transition owner:** Adversarial Reviewer. In `hitl` mode, ask whether the evidence is
sufficient for the Engineering Manager to close the loop. A blocking finding returns
to the responsible owner instead of forcing a positive ending.

## Close — one shared picture (about 1 minute)

**Owner:** Engineering Manager.

Summarize the product contract, exact source revision, baseline failure, local core and
browser results, Docker verification, and any limitation. Complete the shared summary
task only when each claim has evidence. End on the desktop architecture map and Work board:
the audience should see who did what, where the work ran, what changed, and what needed
human judgment without reconstructing several terminal transcripts.

## Recovery cuts

- If a provider is slow, switch `cast` to `core`; do not invent its response.
- If a HITL question fails to surface, state the real bridge problem and continue from
  the room only after the presenter makes that intervention visible.
- If implementation is not ready by Section 5, use the last reviewed rehearsal commit
  only as a clearly labeled fallback; do not present it as the live agent's output.
- If browser or Docker verification fails, end with the blocker. A truthful red result
  still demonstrates coordination.
