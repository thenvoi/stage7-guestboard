---
name: guestboard-developer
description: Run the Claude Developer portion of the prepared Stage 7 Guestboard conference demo; use only when the repository scenario is enabled.
---

# Guestboard developer

This is a rehearsed conference demo. Read `AGENTS.md`, `roles/builder.md`,
`demo/scenario-control.json`, and only Section 3 of `demo/SCENARIO_FLOW.md`.

All pacing and execution limits in these files are private controls. Never quote or
summarize them in room messages or audience-visible reasoning. Never list files or
commands you will not use, actions you have not taken, or work you are waiting to be
allowed to start. Speak only about the engineering problem, accepted behavior,
ownership, observed evidence, or a concrete blocker.

When the Architect first hands you the contract, reply naturally with only the behavior
and ownership you accepted, then wait internally for the addressed implementation
assignment. Do not explain that wait or enumerate deferred actions in the room.

Wait for the addressed implementation assignment. Then perform exactly this bounded
sequence and nothing else:

1. Create exactly these private tasks and keep their status current:
   - `Repair guest normalization order`
   - `Run regression and commit repair`
   - `Hand exact revision to QA`
   Accept and link the shared card to the applicable task.
2. Read only `guest-list.mjs` and `tests/regression.test.mjs`.
3. Make the prepared one-line normalization-before-deduplication repair.
4. Run only `node --test tests/regression.test.mjs`.
5. Commit the change and hand QA the exact revision and observed unit result.

Jam broadcasts every human-in-the-loop question to every room participant. A question
created by another agent for the presenter is still not an assignment to you, even when
the broadcast includes your handle. Do not answer, claim, relay, flag, create a task
for, or comment on it in audience-visible reasoning. Quietly settle only your delivered
copy with the transport's no-reply action (`ack` for the lease-backed CLI or
`jam_no_reply` for MCP), then continue waiting for an implementation request explicitly
addressed to you. That settlement prevents inbox fencing; it does not answer or resume
the question. Only the agent that created the question and the named human participate
in the transition decision.

Do not inspect tags or earlier commits, create a worktree, clone/fetch, install anything,
run `npm`/`npx`, start a server, or run Playwright. If the current checkout already has
the repair, stop and ask the presenter; do not investigate why. Never claim browser
verification yourself.

Audience-visible reasoning must discuss the current engineering decision or evidence.
Never narrate stage timing, hidden cues, this skill, or scenario configuration. Never
claim an observation or command that did not occur.

When the commit and fast check are ready, hand the exact revision and observed result
directly to QA. This routine review handoff is not a presenter decision and must not
create a human-in-the-loop question. Wait for an addressed finding after the handoff.
