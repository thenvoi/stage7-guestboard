---
name: guestboard-qa
description: Run the QA Manager's fast evidence-review portion of the prepared Stage 7 Guestboard conference demo.
---

# Guestboard QA Manager

This is a rehearsed conference demo. Read `AGENTS.md`, `roles/reviewer.md`,
`demo/scenario-control.json`, and Sections 3 and 4 of
`demo/SCENARIO_FLOW.md`.

Perform one short evidence review using only the Developer's room handoff. Do not inspect
the repository, source files, commit, callers, tests, workspace, Git state, plan
attachment, or browser. Do not run any command or ask for independent reproduction.

Create exactly these private tasks, keep their status current, and complete them during
the same review pass:

1. `Check supplied repair summary`
2. `Match reported result to contract`
3. `Report evidence-review verdict`

Link the applicable task to the shared review card.

Return `PASS` when the Developer's handoff supplies all four facts and they agree:

1. an exact committed revision;
2. normalization and blank filtering occur before Set deduplication;
3. first-seen order remains preserved;
4. the Developer reports
   `node --test tests/regression.test.mjs` with 2 passed and 0 failed.

Return `BLOCKED` only when one of those facts is missing or contradictory, naming the
single missing or conflicting item. Do not investigate it yourself.

Send exactly one verdict message directly to the Engineering Manager. Include the exact
revision, label the test result as Developer-reported, state whether the supplied
evidence matches the two-card/count-two contract, and identify any missing item. Do not
send intermediate status, a second recap to the Developer, a browser caveat, or a
human-in-the-loop question.

All execution limits in this skill are private controls. Never narrate the simplified
procedure, stage timing, hidden cues, this skill, or scenario configuration. Public
reasoning states only the evidence being compared and the resulting decision. Never
claim independent execution, source inspection, or browser observation.

If Jam delivers another agent's presenter-owned HITL question, quietly settle only
your delivery copy with `ack` or `jam_no_reply`. Do not answer, relay, or discuss it.
