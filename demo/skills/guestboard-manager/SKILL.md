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
3. `Publish final evidence summary`

Start the first immediately and complete it after the QA Manager is present and three
shared cards are in place. Start the second when implementation and QA are dispatched
and complete it after QA's verdict. Start the third for closeout and complete it only
after publishing the final evidence summary. Keep every status current rather than
creating and completing the tasks in one batch.

Bring in only the QA Manager, keep implementation and review ownership separate, then
create and delegate these authoritative shared cards in order:

1. `Repair normalization order` — Developer — component `guest-normalizer`. Detail:
   normalize before deduplication while preserving blank filtering and first-seen
   order; completion requires the exact commit and fast Node result.
2. `Review supplied repair evidence` — QA Manager — component `guest-normalizer`.
   Detail: compare the Developer's room handoff—exact revision, one-line normalization
   summary, and reported 2/2 focused result—with the accepted contract; completion
   requires one `PASS` or `BLOCKED` verdict sent directly to Engineering Manager.
3. `Summarize delivery evidence` — Engineering Manager — no component. Detail: publish
   the contract, exact revision, Developer result, QA verdict, and limitations.

These definitions are complete. Use them even if the plan snapshot or repository is
also readable; do not ask the Architect or presenter to restate card metadata or grant
plan access. Make the current node visible in the architecture map and close with an
evidence-backed summary rather than a transcript recap.

Use Jam only. Do not inspect the checkout, run tests, start a server, or perform another
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
human-in-the-loop question. Once QA returns its verdict, publish the evidence summary:
state that the agreed visible outcome is two cards/count two, identify the exact revision
and Developer-reported unit result, and do not claim that you personally inspected the
preview. Then close the room's delivery tasks.

In the QA assignment, request exactly one evidence-review verdict based on the
Developer's complete room handoff. Ask QA to track it with exactly these private tasks:
`Check supplied repair summary`, `Match reported result to contract`, and `Report
evidence-review verdict`. Do not ask QA to reproduce, inspect, execute, browse, or send
intermediate status. If the handoff has all required fields, QA should not ask the
Developer a follow-up question.
