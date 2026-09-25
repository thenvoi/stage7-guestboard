# Run a repeatable Guestboard demo

## Prepare

1. Run `./demo/prepare-iteration.sh demo/<run>`. It starts from
   `demo-scripted-baseline-v8`, clears known ignored test artifacts, and proves the
   expected bug-present state. Never reuse a repaired checkout as the next baseline.
2. Give each agent a separate disposable clone/workspace and the exact baseline revision. Prepare repository access and dependencies before recording.
3. Attach the common brief plus each actor's role, or use the runtime's supported per-session instruction path. Supply exact teammate handles privately.
4. Run baseline checks. Run the regression and retain its real nonzero result.
5. Start the preview from the intended sandbox/workspace. Expose only its static preview port through the supported loopback-forwarding path. The app server has no auth; do not treat it as a public security boundary.
6. Open the browser and verify the footer identifies the intended source checkout. Show only synthetic data.

## Give the team a goal

Use ordinary language, for example:

> Importing the same guest with different capitalization or spaces creates duplicate cards and inflates the count. Please fix it, preserve first-seen order, and get independent QA review of the exact revision.

Let agents recruit the permitted collaborators, discuss findings, request review, and update tasks themselves. Do not send stage tokens or hold tasks artificially for the camera. If a task finishes before you show its board, inspect its actual history.

## Prove the repair

1. Import `Ada`, ` ada `, and `Lin`, one per line. The baseline produces three cards and count three.
2. Retain the original failing core and browser regression evidence.
3. Have QA inspect the exact repair commit and the Developer's observed fast-unit result.
4. Serve that same revision, reset, and repeat the same import. It must show two cards and count two.

Structured source IDs and test receipts belong in evidence. Chat should explain the result naturally with the relevant source reference.

## Audience room

Admit people only into a demo-only room whose agents have disposable, minimally privileged Docker/VM workspaces. Stop any reachable laptop-executing demo collaborators before admission. Inspect actual mounts, tools, network, and delegation paths; role text alone does not enforce confinement.

Shared Docker placement means one agent host across rooms, not isolated hostile tenants. Both rooms must contain only synthetic demo content. Deliver and test the repaired source in each audience-room workspace before admitting participants; another room's successful checkout does not update it automatically.

Participants may suggest small synthetic input lists in chat. The presenter can enter the same list into the preview and compare it with agent replies. Explicitly distinguish this manual input from an automatic Jam-to-app integration, which this app does not implement.

## Record and repeat

Record an uncut take and separate short clips. Keep authentication, credentials, unrelated conversations, and personal paths off screen. Record source commit, dirty-state status, provider versions, actual elapsed time, interventions, and cleanup privately.

Do not publish raw traces or recordings automatically. Review them before sharing. Label edited waiting time and prerecorded fallback clips honestly.

The in-app Reset button resets browser data only, not source code, branches, agents,
tasks, or rooms. A fresh engineering iteration requires
`demo/prepare-iteration.sh demo/<new-run>` plus a fresh Jam room. Preserve completed
branches rather than force-resetting them. Remove only explicitly owned disposable
resources after preserving required evidence.
