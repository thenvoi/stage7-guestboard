#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  ./demo/jam-agents.sh [--check | --cleanup [--yes]] [--restart] [--env-file <path>]

Actions (default from JAM_AGENTS_ACTION, otherwise ensure):
  ensure     create missing agents; re-apply runtime settings and instructions to
             agents that already exist
  --check    report each agent's presence and current settings; change nothing
  --cleanup  delete the roster's Band agents and local records (band rm); prints
             the plan only unless --yes is given or JAM_AGENTS_CONFIRM=1

Options:
  --restart         with ensure, restart existing agents' rooms so changes apply now
  --env-file PATH   account file to load (default: .env.jam-agents in the repo root)

Configuration:
  Account   JAM_CONFIG_DIR (required), JAM_PROFILE, JAM_BAND_URL, JAM_AGENT_OWNER
  Roster    demo/jam-agents.conf (JAM_AGENTS_CONF to use another file)
  Precedence: environment > env file > roster defaults.
  See demo/jam-agents.env.example.
EOF
}

die() {
  printf 'jam-agents: %s\n' "$*" >&2
  exit 1
}

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
repo_root="$(git -C "$script_dir" rev-parse --show-toplevel 2>/dev/null)" ||
  die "this script must live inside a Git checkout"

cli_action=""
restart=0
env_file=""
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --check) cli_action=check ;;
    --cleanup) cli_action=cleanup ;;
    --ensure) cli_action=ensure ;;
    --yes) export JAM_AGENTS_CONFIRM=1 ;;
    --restart) restart=1 ;;
    --env-file) [[ "$#" -ge 2 ]] || die "--env-file needs a path"; env_file="$2"; shift ;;
    -h|--help) usage; exit 0 ;;
    *) die "unknown argument: $1 (use --help)" ;;
  esac
  shift
done

# Load the local account file without letting it override the caller's environment.
env_file="${env_file:-${JAM_AGENTS_ENV_FILE:-$repo_root/.env.jam-agents}}"
if [[ -f "$env_file" ]]; then
  saved_env="$(export -p)"
  set -a
  # shellcheck disable=SC1090
  . "$env_file"
  set +a
  eval "$saved_env"
elif [[ -n "${JAM_AGENTS_ENV_FILE:-}" ]]; then
  die "env file not found: $env_file"
fi

roster="${JAM_AGENTS_CONF:-$script_dir/jam-agents.conf}"
[[ -f "$roster" ]] || die "roster not found: $roster"
# shellcheck disable=SC1090
. "$roster"

action="${cli_action:-${JAM_AGENTS_ACTION:-ensure}}"
case "$action" in ensure|check|cleanup) ;; *) die "unknown action: $action" ;; esac

[[ -n "${JAM_CONFIG_DIR:-}" ]] ||
  die "JAM_CONFIG_DIR is not set; set it in the environment or $env_file"
export JAM_CONFIG_DIR
[[ -n "${JAM_PROFILE:-}" ]] && export JAM_PROFILE
[[ -n "${JAM_BAND_URL:-}" ]] && export JAM_BAND_URL
workspace="${JAM_AGENTS_WORKSPACE:-$repo_root}"

command -v band >/dev/null || die "band CLI not found on PATH"
band daemon status 2>&1 | grep -q 'daemon running' ||
  die "Band daemon is not running for $JAM_CONFIG_DIR; start Band with that config dir first"

owner="${JAM_AGENT_OWNER:-$(band whoami 2>/dev/null | grep -oE '@[A-Za-z0-9_-]+' | head -n 1 | tr -d @ || true)}"
[[ -n "$owner" ]] || die "could not determine the account handle; set JAM_AGENT_OWNER"

printf 'account: @%s  profile: %s  config: %s\n' "$owner" "${JAM_PROFILE:-default}" "$JAM_CONFIG_DIR"
printf 'action:  %s  workspace: %s\n' "$action" "$workspace"

# Read one roster setting for an agent key, e.g. setting manager MODEL.
setting() {
  local var="${1}_${2}"
  printf '%s' "${!var:-}"
}

runtime_flags() {
  local key="$1" value
  flags=()
  value="$(setting "$key" MODEL)"; [[ -n "$value" ]] && flags+=(--runtime-model "$value")
  value="$(setting "$key" EFFORT)"; [[ -n "$value" ]] && flags+=(--runtime-effort "$value")
  value="$(setting "$key" APPROVAL)"; [[ -n "$value" ]] && flags+=(--runtime-approval "$value")
  value="$(setting "$key" SANDBOX)"; [[ -n "$value" ]] && flags+=(--runtime-sandbox "$value")
  value="$(setting "$key" CLAUDE_PERMISSION_MODE)"
  [[ -n "$value" ]] && flags+=(--claude-permission-mode "$value")
  return 0
}

# Prints present | missing; fails on any other lookup error.
agent_state() {
  local session="$1" out
  if out="$(band sessions --session "$session" 2>&1)"; then
    echo present
  elif grep -q 'peer not found' <<<"$out"; then
    echo missing
  else
    printf 'jam-agents: %s: %s\n' "$session" "$out" >&2
    return 1
  fi
}

# Prints the owner/handle Band assigned to a local session, if it exists.
agent_handle() {
  band list 2>/dev/null | awk -v s="[$1]" '$2 == s { print $1; exit }'
}

ensure_agent() {
  local key="$1" name session transport instructions label state
  name="$(setting "$key" NAME)"
  session="$(setting "$key" SESSION)"
  [[ -n "$session" ]] || session="$(tr '[:upper:] ' '[:lower:]-' <<<"$name")"
  transport="$(setting "$key" TRANSPORT)"
  instructions="$(setting "$key" INSTRUCTIONS)"
  [[ -n "$name" && -n "$transport" && -n "$instructions" ]] ||
    die "agent '$key' needs ${key}_NAME, ${key}_TRANSPORT, and ${key}_INSTRUCTIONS"
  [[ "$instructions" = /* ]] || instructions="$repo_root/$instructions"
  [[ -f "$instructions" ]] || die "instructions file not found: $instructions"
  [[ "$session" =~ ^[a-z0-9_-]+$ ]] || die "agent '$key' session must be lowercase without spaces: $session"
  runtime_flags "$key"
  state="$(agent_state "$session")"
  label="\"$name\" [$session]"
  [[ "$state" == present ]] && label="$label $(agent_handle "$session")"

  case "$action:$state" in
    check:present)
      echo "[present] $label"
      band runtime template show --session "$session" 2>&1 | sed 's/^/    /'
      band agent instructions show --session "$session" --reveal 2>&1 | sed 's/^/    /'
      ;;
    check:missing)
      echo "[missing] $label"
      ;;
    ensure:missing)
      echo "[create]  $label ($transport)"
      band agent create --session "$session" --name "$name" \
        --description "$(setting "$key" DESCRIPTION)" \
        --cwd "$workspace" --transport "$transport" ${flags[@]+"${flags[@]}"} \
        --instructions-file "$instructions"
      ;;
    ensure:present)
      echo "[update]  $label ($transport)"
      local apply=()
      [[ "$restart" -eq 1 ]] && apply=(--apply-and-restart)
      band runtime template set --session "$session" --transport "$transport" \
        ${flags[@]+"${flags[@]}"} ${apply[@]+"${apply[@]}"}
      band agent instructions set --session "$session" --instructions-file "$instructions"
      ;;
    cleanup:missing)
      echo "[absent]  $label"
      ;;
    cleanup:present)
      if [[ "${JAM_AGENTS_CONFIRM:-0}" == 1 ]]; then
        echo "[remove]  $label"
        band rm --session "$session"
      else
        echo "[would remove] $label (rerun with --yes to delete the Band agent)"
      fi
      ;;
  esac
}

for key in $JAM_AGENTS; do
  ensure_agent "$key"
done
