#!/usr/bin/env bash
set -eu

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
SCRIPT_DIR=$(dirname -- "$(readlink -f -- "$0")")
CURRENT_DATE=$(date +'%Y-%m-%d')

IS_WORKSPACE=false
IS_DRY_RUN=false
IS_QUIET=false
IS_VERBOSE=false
PRESET="conventional-commits"
COMMIT_MESSAGE=

# set `verbose` on `CI`
if [ "${CI:-}" == true ]; then
  IS_VERBOSE=true
fi

##############################
###### Helpers & Utils #######
##############################

function parseOptions {
  while :; do
    local KEY="${1-}"
    case "$KEY" in
    -v | --version)
      echo -n "$CLI_PREFIX last version available at GitHub"
      exit 0
      ;;
    -h | -\? | --help)
      echo -n "$USAGE"
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
      echo -n "$CLI_PREFIX Unknown option: $KEY"
      exit 1
      ;;
    ?*)
      COMMIT_MESSAGE="$KEY"
      ;;
    "")
      break
      ;;
    esac
    shift
  done
}

function isValidCommitType {
  local key="$1"
  shift
  local arr=("$@")

  for element in "${arr[@]}"; do
    if [[ "$key" == "${element}"* ]]; then
      return 0
    fi
  done
  return 1
}

##############################
##### Logging helpers #######
##############################
log() {
  if ! $IS_QUIET; then
    echo -e "$CLI_PREFIX $1"
  fi
}
log_verbose() {
  if $IS_VERBOSE; then
    echo -e "$CLI_PREFIX $1"
  fi
}

##############################
##### Early exit errors ######
##############################

parseOptions "$@"

if [ "$PRESET" != "" ]; then
  SOURCE_PRESET_FILE="$SCRIPT_DIR/presets/${PRESET}.sh"
  # shellcheck disable=SC1090
  source "$SOURCE_PRESET_FILE"
fi

##############################
##### Package variables ######
##############################

PKG_NAME=""

function parsePackages {
  if ! $IS_WORKSPACE; then
    return 0
  fi

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
}

function validateMessage {
  if [[ $(validate_commit "$COMMIT_MESSAGE") == 1 ]]; then
    log "Invalid commit message"
    log_verbose "Validation failed because of commit message \"$COMMIT_MESSAGE\" is not valid"
    exit 1
  else
    log_verbose "Validation succeed as commit message \"$COMMIT_MESSAGE\" is valid"
    exit 0
  fi
}

##############################
######## Initializate ########
##############################
parsePackages
validateMessage