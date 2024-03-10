#!/usr/bin/env bash
set -eu

# RegExp as variable
regexp_commit_primary="^([a-z]+)(\(([^\)]+)\))?:\ (.+)$"
regexp_commit_major="^([a-z]+)(\(([^\)]+)\))?!?:\ (.+)$"
string_commit_major="BREAKING CHANGE"

# Release types
RELEASE_SKIP_TYPES=("build" "chore" "docs" "test" "style" "ci" "skip ci")
RELEASE_PATCH_TYPES=("fix" "close" "closes" "perf" "revert")
RELEASE_MINOR_TYPES=("refactor" "feat")
RELEASE_MAJOR_TYPES=("BREAKING CHANGE")

validate_commit() {
  local subject="$1"

  local type

  # Extracting the type, scope, and description using Bash regex
  if [[ "$subject" =~ $regexp_commit_primary ]]; then
    type="${BASH_REMATCH[1]}"
  elif [[ "$subject" =~ $regexp_commit_major ]]; then
    type="BREAKING CHANGE"
  elif [[ "$subject" =~ $string_commit_major ]]; then
    type="BREAKING CHANGE"
  else
    echo 1
    return 1
  fi

  if isValidCommitType "$type" "${RELEASE_SKIP_TYPES[@]}"; then
    echo 0
    return 0
  elif isValidCommitType "$type" "${RELEASE_PATCH_TYPES[@]}"; then
    echo 2
    return 2
  elif isValidCommitType "$type" "${RELEASE_MINOR_TYPES[@]}"; then
    echo 3
    return 3
  elif isValidCommitType "$type" "${RELEASE_MAJOR_TYPES[@]}"; then
    echo 4
    return 4
  fi

  echo 1
  return 1
}
