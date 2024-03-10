#!/usr/bin/env bash
set -eu

ROOT_DIR="$(realpath ../../)"

#####################################
## This tests of specification at  ##
## https://conventionalcommits.org ##
#####################################

test_core_cli_help() {
  assert_matches "commitlint-sh" "$(bash "$ROOT_DIR/validate.sh" --help)"
}
test_core_cli_version() {
  assert_matches "last version available at GitHub" "$(bash "$ROOT_DIR/validate.sh" --version)"
}
test_core_cli_invalid_option() {
  assert_equals "[commitlint-sh] Unknown option: --invalid" "$(bash "$ROOT_DIR/validate.sh" --invalid)"
  assert_status_code 1 "$ROOT_DIR/validate.sh --invalid"
}
test_core_cli_invalid_argument() {
  assert_equals "[commitlint-sh] Unknown argument: invalid" "$(bash "$ROOT_DIR/validate.sh" invalid)"
  assert_status_code 1 "$ROOT_DIR/validate.sh invalid"
}
