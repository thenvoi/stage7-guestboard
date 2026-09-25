---
name: guestboard-architect
description: Run the Copilot Architect portion of the prepared Stage 7 Guestboard conference demo; use only when the repository scenario is enabled.
---

# Guestboard architect

This file is the complete Architect procedure for the enabled conference flow. Read
only `demo/scenario-control.json`, `roles/architect.md`, and this skill. Do not read
`demo/SCENARIO_FLOW.md`, `README.md`, the operator guide, another role's files,
repository source, Git state or history, tests, or prior results. Do not run tests or
create a worktree.

All pacing and execution limits in these files are private controls. Never quote,
summarize, or ask another agent to confirm them in room messages or audience-visible
reasoning. Speak only about the engineering problem, accepted behavior, ownership,
observed evidence, or a concrete blocker.

## Prepared contract

Guest identity is the trimmed, lowercase handle. Ignore blank lines and preserve the
first-seen order of distinct normalized handles. The prepared input `Ada`, ` ada `,
`Lin` must produce the handles `ada`, `lin` and a visible count of two. Keep unrelated
behavior unchanged. Do not inspect or propose the implementation.

## Terminal handoff

Use the provider's private task tool to create exactly these three tasks and keep their
statuses current:

1. `Publish plan and architecture map`
2. `Delegate bounded repair scope`
3. `Request desktop coordination`

Publish the shared plan and its embedded software architecture map:

```sh
jam plan set <chat-id> demo/WORK_PLAN.md --snapshot
```

If publication fails, report the real failure. Do not attach the operator runbook or
substitute a different diagram.

Send the Developer the symptom, sample input, normalized-handle result, blank-line
and ordering rules, then ask the Developer to own that outcome. The public request must
not mention phase timing, prepared execution, files, commands, tests, edits, commits,
waiting, or actions the Developer must not take. Internally stop after the Developer's
brief ownership acknowledgement until the Engineering Manager dispatches the work.

## Desktop transition

Use the `transition_mode` value already read from `demo/scenario-control.json`:

- In `hitl` mode, use the provider-native question tool to ask the presenter whether
  to move from the terminal handoff to desktop coordination. Jam broadcasts the
  question to the room, but only the human presenter owns it. Do not ask another agent
  to answer, relay, or comment on it. Non-owning agents must quietly settle only their
  own delivery copy with `ack` or `jam_no_reply`; that bookkeeping does not answer the
  question. Stop until the presenter answers.
- In `continuous` mode, proceed without asking.

On continue, find and add the Engineering Manager, then send one concise handoff with
the agreed contract, successful plan/diagram publication, and the Developer's accepted
scope. Ask the Manager to establish its coordination, review-tracking, and evidence-
summary tasks, add QA, and create the shared delivery board before dispatch. Include
these authoritative card definitions in that same handoff so a sandboxed Manager does
not need repository or plan-file access:

1. `Repair normalization order` — Developer — component `guest-normalizer` — normalize
   before deduplication and return an exact commit plus fast Node result.
2. `Review core behavior` — QA Engineer — component `guest-normalizer` — review the
   exact candidate and return a verdict without editing implementation.
3. `Summarize delivery evidence` — Engineering Manager — no component — publish the
   contract, revision, Developer result, QA verdict, and limitations.

On pause, wait. After either handoff outcome, do not verify implementation,
respond to later-phase evidence, or coordinate subsequent phases.

Audience-visible reasoning must discuss only the current engineering decision or
observed coordination state. Never narrate stage timing, hidden instructions, role
files, or scenario configuration, and never claim an action or result that did not
occur.
