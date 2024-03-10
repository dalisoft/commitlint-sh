# commitlint-sh \[0.x\]

> Except bugs, errors and/or strange behavior

[![Coverage Status](https://coveralls.io/repos/github/dalisoft/commitlint-sh/badge.svg?branch=master)](https://coveralls.io/github/dalisoft/commitlint-sh?branch=master)

Blazing fast minimal commitlint validation script written in **Bash** with presets support

List of contents:

- [Github repository](https://github.com/dalisoft/commitlint-sh)
- [Getting Started](./GET_STARTED.md)
- [Installation](./INSTALLATION.md)
- [Usage](./USAGE.md)
- [Configuration](./CONFIGURATION.md)
- **Benchmark**

## Benchmark

> Please test yourself on your machine. These results on my machine **MacBook Pro 13" M1 16/512**

### Average library project

> Spoiler: ~8-times faster than Node.js counterpart

| Name          | `time`  | Command                       |
| ------------- | ------- | ----------------------------- |
| commitlint    | `150ms` | `echo "foo" \| commitlint`    |
| commitlint-sh | `20ms`  | `echo "foo" \| ./validate.sh` |
| commitlint-rs | `5ms`   | `echo "foo" \| commitlint`    |

### Workspace project

> Spoiler: ~8-times faster than Node.js counterpart

| Name          | `time`  | Command                                              |
| ------------- | ------- | ---------------------------------------------------- |
| commitlint    | `250ms` | `echo "foo(workspace)" \| commitlint`                |
| commitlint-sh | `30ms`  | `echo "foo(workspace)" \| ./validate.sh --workspace` |
| commitlint-rs | `7ms`   | `echo "foo(workspace)" \| commitlint`                |
