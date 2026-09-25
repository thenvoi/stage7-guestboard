#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  ./demo/prepare-iteration.sh demo/<new-run-name> [baseline-ref]

Examples:
  ./demo/prepare-iteration.sh demo/stage7-run-02
  ./demo/prepare-iteration.sh demo/2026-09-25-rehearsal-01 demo-scripted-baseline-v2

The command is intentionally non-destructive:
  - it refuses dirty workspaces, existing branches, and extra worktrees;
  - it preserves completed run branches;
  - it removes only ignored test-results/ and playwright-report/ artifacts;
  - it proves the new checkout is the prepared, bug-present conference baseline.

It does not create or clear a Jam room, start agents, push branches, or delete work.
EOF
}

die() {
  printf 'prepare-iteration: %s\n' "$*" >&2
  exit 1
}

run_branch="${1:-}"
baseline_ref="${2:-${DEMO_BASELINE_REF:-demo-scripted-baseline-v2}}"

if [[ -z "$run_branch" || "$run_branch" == "-h" || "$run_branch" == "--help" ]]; then
  usage
  [[ -n "$run_branch" ]] && exit 0
  exit 2
fi

[[ "$#" -le 2 ]] || die "too many arguments; use --help for usage"
[[ "$run_branch" == demo/* ]] || die "run branch must start with demo/"
[[ "$run_branch" != "demo/" ]] || die "run branch needs a name after demo/"

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
repo_root="$(git -C "$script_dir" rev-parse --show-toplevel 2>/dev/null)" ||
  die "this script must live inside a Git checkout"
cd "$repo_root"

git diff --quiet -- || die "tracked working-tree changes exist; preserve or commit them first"
git diff --cached --quiet -- || die "staged changes exist; preserve or commit them first"

untracked="$(git ls-files --others --exclude-standard)"
[[ -z "$untracked" ]] ||
  die "untracked files exist; preserve or remove them first: $(printf '%s' "$untracked" | tr '\n' ' ')"

worktree_count="$(git worktree list --porcelain | awk '/^worktree / { count++ } END { print count + 0 }')"
[[ "$worktree_count" -eq 1 ]] ||
  die "expected one worktree, found $worktree_count; inspect with: git worktree list"

git rev-parse --verify --quiet "${baseline_ref}^{commit}" >/dev/null ||
  die "baseline ref does not exist locally: $baseline_ref"

if git show-ref --verify --quiet "refs/heads/$run_branch"; then
  die "local branch already exists: $run_branch"
fi
if git show-ref --verify --quiet "refs/remotes/origin/$run_branch"; then
  die "origin tracking branch already exists: $run_branch"
fi

git switch --create "$run_branch" "$baseline_ref"

for generated_path in test-results playwright-report; do
  target="$repo_root/$generated_path"
  if [[ -e "$target" ]]; then
    rm -rf -- "$target"
  fi
done

node --input-type=module <<'NODE'
import fs from 'node:fs';
import { parseGuestInput } from './guest-list.mjs';

const control = JSON.parse(fs.readFileSync('demo/scenario-control.json', 'utf8'));
const required = {
  enabled: true,
  transition_mode: 'hitl',
  execution_mode: 'bounded-live',
  live_check: 'node-regression-only',
  browser_check: 'presenter-manual',
  allow_worktrees: false,
  allow_browser_automation: false,
  evidence_policy: 'observed-only',
};

for (const [key, expected] of Object.entries(required)) {
  if (control[key] !== expected) {
    throw new Error(
      `scenario-control.json: expected ${key}=${JSON.stringify(expected)}, got ${JSON.stringify(control[key])}`,
    );
  }
}

const sample = parseGuestInput(control.sample_input);
const expectedBug = ['ada', 'ada', 'lin'];
if (JSON.stringify(sample) !== JSON.stringify(expectedBug)) {
  throw new Error(
    `expected bug-present sample ${JSON.stringify(expectedBug)}, got ${JSON.stringify(sample)}`,
  );
}
NODE

printf '\nCore baseline checks (must pass)\n'
node --test tests/baseline.test.mjs

regression_output="$(mktemp "${TMPDIR:-/tmp}/stage7-regression.XXXXXX")"
cleanup() {
  rm -f -- "$regression_output"
}
trap cleanup EXIT

printf '\nPrepared regression (must fail 2 tests)\n'
if node --test tests/regression.test.mjs >"$regression_output" 2>&1; then
  cat "$regression_output"
  die "regression unexpectedly passed; this is not the bug-present baseline"
fi
if ! grep -Eq 'tests 2$' "$regression_output" ||
  ! grep -Eq 'pass 0$' "$regression_output" ||
  ! grep -Eq 'fail 2$' "$regression_output"; then
  cat "$regression_output"
  die "regression failed for an unexpected reason"
fi
cat "$regression_output"

git diff --quiet -- || die "preflight changed tracked files"
git diff --cached --quiet -- || die "preflight changed the index"
[[ -z "$(git ls-files --others --exclude-standard)" ]] || die "preflight left untracked files"

branch="$(git branch --show-current)"
revision="$(git rev-parse HEAD)"

cat <<EOF

Prepared repository iteration
  branch:   $branch
  revision: $revision
  baseline: $baseline_ref
  bug:      confirmed (Ada / ada / Lin -> 3 normalized entries)
  tests:    core baseline passed; regression failed 2/2 as expected
  artifacts: test-results/ and playwright-report/ cleared

Next operator actions
  1. Create a fresh Jam room; do not reuse messages, tasks, plans, or HITL requests.
  2. Confirm Architect and Developer use this branch and revision.
  3. In Add participants, confirm every desktop role is discoverable before starting,
     especially the Adversarial Reviewer.
  4. Pre-provision the reviewer's Docker workspace at this exact revision.
  5. Push only if the remote verifier requires it:
       git push --set-upstream origin $branch
EOF
