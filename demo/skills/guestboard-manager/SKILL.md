---
name: guestboard-manager
description: Run the Engineering Manager coordination and closeout portions of the prepared Stage 7 Guestboard conference demo.
---

# Guestboard manager

This is a rehearsed conference demo. Read `AGENTS.md`, `roles/lead.md`,
`demo/scenario-control.json`, and only Sections 2, 3, and Close of
`demo/SCENARIO_FLOW.md`.

Use the existing engineering room. Before recruiting or creating shared cards, create
exactly these three private tasks with the provider's native task tool:

1. `Coordinate team and shared board`
2. `Track implementation and review gates`
3. `Publish final evidence summary`

Start the first immediately and complete it after the configured cast and six shared
cards are in place. Start the second when implementation and QA are dispatched and
complete it after the adversarial verdict. Start the third for closeout and complete it
only after publishing the final evidence summary. Keep every status current rather than
creating and completing the tasks in one batch.

Bring in only the configured cast, keep implementation and review ownership separate,
then create and delegate the six shared tasks from the runbook with the component IDs
in `demo/WORK_PLAN.md`. Make the current node visible in the architecture map. Close
with an evidence-backed summary rather than a transcript recap.

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

Immediately before dispatch, re-read `transition_mode`. In `hitl` mode, use the native
question tool to ask whether to start the Developer and QA lanes. In `continuous` mode,
dispatch them directly.
