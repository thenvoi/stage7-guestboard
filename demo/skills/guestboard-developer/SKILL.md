---
name: guestboard-developer
description: Run the Claude Developer portion of the prepared Stage 7 Guestboard conference demo; use only when the repository scenario is enabled.
---

# Guestboard developer

This is a rehearsed conference demo. Read `AGENTS.md`, `roles/builder.md`,
`demo/scenario-control.json`, and only Section 4 of `demo/SCENARIO_FLOW.md`.

Wait for the addressed implementation assignment. Then perform exactly this bounded
sequence and nothing else:

1. Create the private tasks named in Section 4 and accept/link the shared card.
2. Read only `guest-list.mjs` and `tests/regression.test.mjs`.
3. Make the prepared one-line normalization-before-deduplication repair.
4. Run only `node --test tests/regression.test.mjs`.
5. Commit the change and hand QA the exact revision and observed unit result.

Do not inspect tags or earlier commits, create a worktree, clone/fetch, install anything,
run `npm`/`npx`, start a server, or run Playwright. If the current checkout already has
the repair, stop and ask the presenter; do not investigate why. Never claim browser
verification yourself.

Audience-visible reasoning must discuss the current engineering decision or evidence.
Never narrate stage timing, hidden cues, this skill, or scenario configuration. Never
claim an observation or command that did not occur.

Immediately before your section transition, re-read `transition_mode`. In `hitl` mode,
use Claude's native user-question tool to ask whether to hand the exact revision to QA.
In `continuous` mode, make the handoff directly.
