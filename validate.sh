#!/bin/sh

if [ -n "${TRACE_TIME-}" ]; then
  PS4='+ $(gdate +%s%3N)\011 '
  exec 3>&2 2>/tmp/bashstart-csh.log

  set -eux
else
  set -eu
fi

readonly CLI_PREFIX="[commitlint-sh]"
readonly DESCRIPTION="Blazing fast minimal commitlint validation script written in Bash with presets support"
readonly USAGE="$CLI_PREFIX Usage: commitlint-sh [options]
$DESCRIPTION

Options:
  -w, --workspace Use in workspace environment for publishing workspaces separately.
  --verbose       Verbose mode, shows more detailed logs.
  --quiet         Quiet mode, shows less logs than default behavior.
  -h, --help      Show this help.
  -v, --version   Show version.
"

##############################
####### Root variables #######
##############################
IS_WORKSPACE=false
IS_QUIET=false
IS_VERBOSE=false
PRESET="conventional-commits"

# set `verbose` on `CI`
if [ "${CI:-}" = true ]; then
  IS_VERBOSE=true
fi

##############################
###### Helpers & Utils #######
##############################

while :; do
  KEY="${1-}"
  case "$KEY" in
  -v | --version)
    echo "$CLI_PREFIX last version available at GitHub"
    exit 0
    ;;
  -h | -\? | --help)
    echo "$USAGE"
    exit 0
    ;;
  -w | --workspace)
    IS_WORKSPACE=true
    PRESET="workspace"
    ;;
  -q | --quiet)
    IS_QUIET=true
    IS_VERBOSE=false
    ;;
  --verbose)
    IS_VERBOSE=true
    IS_QUIET=false
    ;;
  -?*)
    echo "$CLI_PREFIX Unknown option: $KEY"
    exit 1
    ;;
  ?*)
    echo "$CLI_PREFIX Unknown argument: $KEY"
    exit 1
    ;;
  "")
    break
    ;;
  esac
  shift
done

read -r message

# shellcheck disable=SC2317
isValidCommitType() {
  case $2 in
  *$1*)
    return 0
    ;;
  esac

  return 1
}

##############################
##### Logging helpers #######
##############################
log() {
  if ! $IS_QUIET; then
    echo "$CLI_PREFIX $1"
  fi
}
log_verbose() {
  if $IS_VERBOSE; then
    echo "$CLI_PREFIX $1"
  fi
}

##############################
##### Early exit errors ######
##############################

if [ "$PRESET" != "" ]; then
  # shellcheck source-path=presets
  . "../presets/${PRESET}.sh"
fi

##############################
##### Package variables ######
##############################

PKG_NAME=""
if $IS_WORKSPACE; then
  if [ -f "./package.json" ]; then
    PKG_NAME=$(awk -F': ' '/"name":/ {gsub(/[",]/, "", $2); print $2}' "./package.json")
  elif [ -f "./Cargo.toml" ]; then
    PKG_NAME=$(sed -n 's/^name = "\(.*\)"/\1/p' "./Cargo.toml")
  elif [ -f "./setup.py" ]; then
    PKG_NAME=$(sed -n 's/^setup(\s*name\s*=\s*["'\'']\([^"'\'']*\)["'\''].*/\1/p' "./setup.py")
  else
    cat <<EOF
This project currently supports only Node.js, Rust and Python projects.
Please wait for updates to get support in other languages!
EOF
    exit 1
  fi

  log_verbose "Workspace mode is enabled"
  log_verbose "Workspace project name: $PKG_NAME"
fi

##############################
###### Initializatation ######
##############################

# echo "$(validate_commit "$message")"

if [ $(validate_commit "$message") = 1 ]; then
  log "Invalid commit message"
  log_verbose "Validation failed because of commit message \"$message\" is not valid"
  # exit 1
else
  log_verbose "Validation succeed as commit message \"$message\" is valid"
  # exit 0
fi

if [ -n "${TRACE_TIME-}" ]; then
  set +x
  exec 2>&3 3>&-
  cat /tmp/bashstart-csh.log | node ../scripts/find-longest-line.mjs
fi
