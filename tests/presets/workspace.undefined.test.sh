#!/usr/bin/env bash
set -eu

ROOT_DIR="$(realpath ../../)"
REPO_FOLDER=$(mktemp -d)

setup_suite() {
  cd "$REPO_FOLDER"

  echo '[package]
name = "workspace1"
version = "0.0.1"
' >>"$REPO_FOLDER/unknown.toml"
}

teardown_suite() {
  rm -rf "$REPO_FOLDER"
  unset REPO_FOLDER
}

#####################################
## This tests of specification at  ##
## https://conventionalcommits.org ##
#####################################

test_commit_0_1_initial_message() {
  local message="fix(workspace1): initial commit"

  assert_status_code 1 "echo \"$message\" | $ROOT_DIR/validate.sh --workspace"
}
test_commit_0_3_skip_change() {
  local message="chore(workspace1): chore commit"

  assert_status_code 1 "echo \"$message\" | $ROOT_DIR/validate.sh --workspace"
}
test_commit_1_feat_breaking_major_message() {
  local message="feat(workspace1): allow provided config object to extend other configs

  BREAKING CHANGE: \`extends\` key in config file is now used for extending other config files"

  assert_status_code 1 "echo \"$message\" | $ROOT_DIR/validate.sh --workspace"
}
