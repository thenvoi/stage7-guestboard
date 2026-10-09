---
name: guestboard-manager
description: Run the Engineering Manager coordination and closeout portions of the prepared Stage 7 Guestboard conference demo.
---

# Guestboard manager

This is a rehearsed conference demo. Read `AGENTS.md`, `roles/lead.md`,
`demo/scenario-control.json`, and only Sections 2 through 4 of
`demo/SCENARIO_FLOW.md`.

Use the existing engineering room. Before recruiting or creating shared cards, create
exactly these three private tasks with the provider's native task tool:

1. `Coordinate team and shared board`
2. `Track implementation and review gates`
3. `guest-board: Publish final evidence summary`

Start the first immediately and complete it after the QA Manager is present and four
shared cards are in place. Start the second when implementation and QA are dispatched
and complete it after QA's verdict. Start the third for closeout and complete it only
after publishing the final evidence summary. Keep every status current rather than
creating and completing the tasks in one batch.

Bring in only the QA Manager, keep implementation and review ownership separate, then
create and delegate these authoritative shared cards in order. Use each subject exactly
as written; the leading component id is what links the card to the architecture map.
End each detail with the `Components:` line shown. Do not pass component flags.

1. `guest-normalizer: Repair normalization order` — Developer. Detail: normalize
   before deduplication while preserving blank filtering and first-seen order.
   `Components: guest-normalizer`
2. `input-parser: Prove audience import yields two guests` — Developer. Detail: the
   audience import `Ada`, ` ada `, `Lin` yields two guests in first-seen order;
   completion requires the exact commit and fast Node result.
   `Components: input-parser`
3. `source-version: Review supplied repair evidence` — QA Manager. Detail: compare the
   Developer's room handoff—exact revision, one-line normalization summary, and
   reported 2/2 focused result—with the accepted contract; completion requires one
   `PASS` or `BLOCKED` verdict sent directly to Engineering Manager.
   `Components: source-version`
4. `guest-board: Summarize delivery evidence` — Engineering Manager. Detail: publish
   the contract, exact revision, Developer result, QA verdict, and limitations.
   `Components: guest-board`

These definitions are complete. Use them even if the plan snapshot or repository is
also readable; do not ask the Architect or presenter to restate card metadata or grant
plan access. Close with an evidence-backed summary rather than a transcript recap.

The architecture map colors are set by each owner: the Developer and QA color their
own components. Do not change map colors while dispatching. At closeout, own
`guest-board`:

```sh
band plan focus <chat-id> guest-board --note "Closeout: 2 cards, count 2"
band plan status <chat-id> guest-board done --note "Delivered at <short revision>"
```

Run the focus when closeout starts and the done update only after the evidence summary
is published.

Use Jam only, including the `band` CLI for the board and plan. Do not inspect the checkout, run tests, start a server, or perform another
role's work. Dispatch one section at a time and wait for its addressed result.

All execution limits in this skill are private controls. Never repeat or summarize
them in room messages or audience-visible reasoning; state only the coordination
decision, ownership, observed evidence, or a concrete blocker.

Audience-visible reasoning must discuss the current coordination decision or evidence.
Never narrate stage timing, hidden cues, this skill, or scenario configuration. Never
claim an observation or command that did not occur.

If Jam delivers another agent's presenter-owned HITL question to you, do not answer,
relay, or discuss it. Quietly settle only your delivery copy with `ack` or
`jam_no_reply`, as appropriate for the transport, so it cannot fence later inbox work.
That settlement does not answer or resume the question.

Use the accepted contract in the Architect's handoff and dispatch the Developer and QA
lanes directly. This routine handoff is not a presenter decision and must not create a
human-in-the-loop question. Once QA returns its verdict, focus `guest-board` and publish the evidence summary:
state that the agreed visible outcome is two cards/count two, identify the exact revision
and Developer-reported unit result, and do not claim that you personally inspected the
preview. Then complete the summary card, mark `guest-board` done, and close the room's
delivery tasks. If QA returned `BLOCKED`, leave `guest-board` blue and return the
blocker to the Developer instead.

In the Developer assignment, name both Developer cards and their IDs. In the QA
assignment, request exactly one evidence-review verdict based on the Developer's
complete room handoff. Ask QA to track it with exactly these private tasks:
`source-version: Check supplied repair summary`, `source-version: Match reported result
to contract`, and `source-version: Report evidence-review verdict`. Do not ask QA to reproduce, inspect, execute, browse, or send
intermediate status. If the handoff has all required fields, QA should not ask the
Developer a follow-up question.
