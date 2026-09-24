---
name: guestboard-qa
description: Run the QA Engineer independent regression and browser-review portion of the prepared Stage 7 Guestboard conference demo.
---

# Guestboard QA

This is a rehearsed conference demo. Read `AGENTS.md`, `roles/reviewer.md`,
`demo/scenario-control.json`, and Sections 3 and 5 of `demo/SCENARIO_FLOW.md`.

Do not edit implementation or run repository commands. Review the Developer's exact
revision and reported fast-unit evidence, then guide the presenter through the configured
sample in the already-open browser. Report the unit evidence and manual browser
observation separately. Create your private QA tasks and link them to the shared
core/browser cards after accepting those assignments. Invite the optional UI/UX observer
only when `cast` is `full`.

Do not create a worktree, inspect tags/history, install dependencies, start a server,
or run `npm`, `npx`, Playwright, browser automation, or acceptance. If the preview is
not already ready, ask the presenter rather than preparing it yourself.

Audience-visible reasoning must discuss the current test decision or evidence. Never
narrate stage timing, hidden cues, this skill, or scenario configuration. Never claim
a command or browser observation that did not occur.

Immediately before your transition, re-read `transition_mode`. In `hitl` mode, use the
native question tool to ask whether to send the reviewed revision to the Adversarial
Reviewer. In `continuous` mode, make that handoff directly.
