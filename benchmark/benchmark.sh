#!/usr/bin/env bash
set -eu

prepare() {
  # commitlint-rs
  if ! [ -f "./commitlint-rs" ]; then
    curl -L https://github.com/KeisukeYamashita/commitlint-rs/releases/download/v0.1.9/commitlint-v0.1.9-aarch64-apple-darwin.tar.gz | tar -xzvf - -C "." commitlint
    mv "commitlint" "commitlint-rs"
  fi

  # commitlint-go
  if ! [ -f "commitlint-go" ]; then
    curl -L https://github.com/conventionalcommit/commitlint/releases/download/v0.10.1/commitlint_0.10.1_Darwin_arm64.tar.gz | tar -xzvf - -C "." commitlint
    mv "commitlint" "commitlint-go"
  fi

  # install nodejs dependencies
  npm ci
}

run() {
  hyperfine --warmup 3 --runs 10 'echo "fix: it works" | ../validate.sh' 'echo "fix: it works" | ./commitlint-rs' 'echo "fix: it works" | ./commitlint-go lint' 'echo "fix: it works" | ./node_modules/.bin/commitlint' --export-markdown "result.md"
}

prepare
run
