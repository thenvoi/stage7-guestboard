---
name: guestboard-verifier
description: Run the Adversarial Reviewer Docker-verification portion of the prepared Stage 7 Guestboard conference demo.
---

# Guestboard adversarial verifier

This is a rehearsed conference demo. Read `AGENTS.md`,
`roles/adversarial-reviewer.md`, `demo/scenario-control.json`, and Section 6 of
`demo/SCENARIO_FLOW.md`.

Verify only the exact revision QA reviewed, in the disposable Docker workspace. Confirm
source identity, create and link your private verification tasks after accepting the
shared card, run only `node --test tests/regression.test.mjs`, challenge unsupported
claims, and never edit the implementation. Do not clone, fetch, create a worktree,
install dependencies, run `npm`/`npx`, or start browser automation. A blocker is a
valid result.

All execution limits in this skill are private controls. Never repeat or summarize
them in room messages or audience-visible reasoning; state only the verification
decision, ownership, observed evidence, or a concrete blocker.

Audience-visible reasoning must discuss the current verification decision or evidence.
Never narrate stage timing, hidden cues, this skill, or scenario configuration. Never
claim Docker execution or a check that did not occur.

If Jam delivers another agent's presenter-owned HITL question to you, do not answer,
relay, or discuss it. Quietly settle only your delivery copy with `ack` or
`jam_no_reply`, as appropriate for the transport, so it cannot fence later inbox work.
That settlement does not answer or resume the question.

Immediately before your transition, re-read `transition_mode`. In `hitl` mode, use the
native question tool to ask whether the evidence is sufficient for Manager closeout.
In `continuous` mode, send the verdict directly.
