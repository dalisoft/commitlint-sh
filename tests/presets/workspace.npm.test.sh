#!/usr/bin/env bash
set -eu

ROOT_DIR="$(realpath ../../)"
REPO_FOLDER=$(mktemp -d)

setup_suite() {
  cd "$REPO_FOLDER"

  echo '{
  "name": "workspace1",
  "version": "1.0.0",
  "description": "> Except bugs, errors and/or strange behavior",
  "main": "index.js",
  "directories": {
    "doc": "docs",
    "test": "tests"
  },
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC"
}
' >>"$REPO_FOLDER/package.json"
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

  assert_status_code 0 "$ROOT_DIR/validate.sh --workspace \"$message\""
}
test_commit_0_3_skip_change() {
  local message="chore(workspace1): chore commit"

  assert_status_code 0 "$ROOT_DIR/validate.sh --workspace \"$message\""
}
test_commit_1_feat_breaking_major_message() {
  local message="feat(workspace1): allow provided config object to extend other configs

  BREAKING CHANGE: \`extends\` key in config file is now used for extending other config files"

  assert_status_code 0 "$ROOT_DIR/validate.sh --workspace \"$message\""
}
test_commit_2_feat_mark_major_message() {
  local message="feat!: send an email to the customer when a product is shipped"

  assert_status_code 0 "$ROOT_DIR/validate.sh --workspace \"$message\""
}
test_commit_3_feat_mark_scope_major_message() {
  local message="feat(workspace1)!: send an email to the customer when a product is shipped"

  assert_status_code 0 "$ROOT_DIR/validate.sh --workspace \"$message\""
}
test_commit_4_feat_mark_breaking_scope_major_message() {
  local message="chore(workspace1)!: drop support for Node 6

  BREAKING CHANGE: use JavaScript features not available in Node 6."

  assert_status_code 0 "$ROOT_DIR/validate.sh --workspace \"$message\""
}
test_commit_5_docs_root_no_update_message() {
  local message="docs: correct spelling of CHANGELOG"

  assert_status_code 0 "$ROOT_DIR/validate.sh --workspace \"$message\""
}
test_commit_5_docs_workspace_no_update_message() {
  local message="docs(workspace1): correct spelling of CHANGELOG"

  assert_status_code 0 "$ROOT_DIR/validate.sh --workspace \"$message\""
}
test_commit_6_feat_scope_message() {
  local message="feat(workspace1): add Polish language"

  assert_status_code 0 "$ROOT_DIR/validate.sh --workspace \"$message\""
}
test_commit_7_fix_multi_message() {
  local message="fix(workspace1): prevent racing of requests

  Introduce a request id and a reference to latest request. Dismiss incoming responses other than from latest request.

  Remove timeouts which were used to mitigate the racing issue but are obsolete now

  Reviewed-by: Z
  Refs: #123"

  assert_status_code 0 "$ROOT_DIR/validate.sh --workspace --verbose \"$message\""
}
test_commit_8_revert_message() {
  local message="revert(workspace1): let us never again speak of the noodle incident

  Refs: 676104e, a215868"

  assert_status_code 0 "$ROOT_DIR/validate.sh --workspace --quiet \"$message\""
}
