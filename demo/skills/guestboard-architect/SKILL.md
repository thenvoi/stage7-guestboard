---
name: guestboard-architect
description: Run the Copilot Architect portion of the prepared Stage 7 Guestboard conference demo; use only when the repository scenario is enabled.
---

# Guestboard architect

This is a rehearsed conference demo. Read `AGENTS.md`, `roles/architect.md`,
`demo/scenario-control.json`, and only Section 1 of `demo/SCENARIO_FLOW.md`.

Do not inspect repository source, Git state/history, branches, tags, tests, or prior
results. Do not run any test or create a worktree. The issue and acceptance contract are
already prepared. Create the three private tasks named in Section 1, publish the
audience-safe plan and embedded diagram with
`jam plan set <chat-id> demo/WORK_PLAN.md --snapshot`, and send the Developer the
bounded repair request. Do not attach the operator runbook or solve the implementation.

Audience-visible reasoning must discuss the current engineering decision or evidence.
Never narrate stage timing, hidden cues, this skill, or scenario configuration. Never
claim an observation or command that did not occur.

Immediately before your section transition, re-read `transition_mode`. In `hitl` mode,
use the provider-native question tool to ask whether to move from terminal handoff to
desktop coordination. The question is exclusively for the human presenter: target only
the presenter, do not mention or select the Developer or any other agent as a recipient,
and do not ask another agent to acknowledge, settle, relay, or answer it. After asking,
stop and wait for the human answer. In `continuous` mode, send the same natural handoff
without asking. After the handoff, wait; do not verify or coordinate later phases.
