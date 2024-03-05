# commitlint-sh \[0.x\]

> Except bugs, errors and/or strange behavior

[![Coverage Status](https://coveralls.io/repos/github/dalisoft/commitlint-sh/badge.svg?branch=master)](https://coveralls.io/github/dalisoft/commitlint-sh?branch=master)

Blazing fast minimal commitlint validation script written in **Bash** with presets support

List of contents:

- [Github repository](https://github.com/dalisoft/commitlint-sh)
- **Getting Started**
- [Installation](./INSTALLATION.md)
- [Usage](./USAGE.md)
- [Configuration](./CONFIGURATION.md)
- [Benchmark](./BENCHMARK.md)

## Getting Started

Welcome to commitlint-sh! This tool is designed to streamline your software release process, making it easier to manage versions, changelogs, and deployment. Whether you're working on a small project or a large enterprise application, commitlint-sh is here to simplify your workflow.

### Prerequisites

Before you start using commitlint-sh, make sure you have the following installed on your system:

- `git` (version 2.30 or later)
- `bash` (version 5.x or later) with `curl`, `sed` dependencies
- `npm` (version 9.x or later), required for `npm` package

### Features

- Available on all **Unix** environments
- Zero third-party dependencies
- No pre-install, just use
- Blazing fast, no wait
- Workspace support out-of-box
- Programming language agnostic
- Fast (<5 sec with all plugins execution)
- Plugins available/compatible
- Presets available/compatible

### Limitations

- Currently supports only **Node.js**, **Rust** and **Python** projects (library only)
- Rebased commits tracking are lost so duplicate releases possible
- Available only in **Unix** environments (no Windows support yet)

### Versioning priority

If one of files described below will be found, script parse first matched file and priority will ran as these

1. **Node.js** (`package.json`)
2. **Rust** (`Cargo.toml`)
3. **Python** (`setup.py`)

## Comparison

| Features      | commitlint-sh | semantic-release | go-semantic-release |
| ------------- | ------------- | ---------------- | ------------------- |
| Performance   | Fast          | Slow             | Fast                |
| Startup delay | -             | Slow             | Fast                |
| Platform      | Unix-only     | ALL              | ALL                 |
| Dependencies  | -             | +                | ?                   |
| Configuration | -             | +                | +                   |
| Presets       | +             | +                | -                   |
| Plugins       | +             | +                | +                   |
| Workspaces    | Built-in      | ?                | -                   |
| `0.x` support | Built-in      | -                | ?                   |
| `semver`      | +             | +                | +                   |

## Similar projects

- [commitlint](https://commitlint.js.org)

## Credits to

- [Bash](https://www.gnu.org/software/bash)
- [ShellCheck](https://github.com/koalaman/shellcheck)
- [Bashcov](https://github.com/infertux/bashcov)
- [bash_unit](https://github.com/pgrange/bash_unit)

## License

GPL-3
