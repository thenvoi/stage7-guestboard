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

Start the first immediately and complete it after the QA Engineer is present and three
shared cards are in place. Start the second when implementation and QA are dispatched
and complete it after QA's verdict. Start the third for closeout
and complete it only after publishing the final evidence summary. Keep every status
current rather than creating and completing
the tasks in one batch.

Bring in only the QA Engineer, keep implementation and review ownership separate, then
create and delegate these authoritative shared cards in order:

1. `Repair normalization order` — Developer — component `guest-normalizer`. Detail:
   normalize before deduplication while preserving blank filtering and first-seen
   order; completion requires the exact commit and fast Node result.
2. `Review core behavior` — QA Engineer — component `guest-normalizer`. Detail: review
   the exact candidate and Developer evidence without editing implementation; completion
   requires the QA verdict on that revision.
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
and observed unit result, and do not claim that you personally inspected the preview.
Then close the room's delivery tasks.
