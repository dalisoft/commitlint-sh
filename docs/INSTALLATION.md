# commitlint-sh \[0.x\]

> Except bugs, errors and/or strange behavior

[![Coverage Status](https://coveralls.io/repos/github/dalisoft/commitlint-sh/badge.svg?branch=master)](https://coveralls.io/github/dalisoft/commitlint-sh?branch=master)

Blazing fast minimal commitlint validation script written in **Bash** with presets support

List of contents:

- [Github repository](https://github.com/dalisoft/commitlint-sh)
- [Getting Started](./GET_STARTED.md)
- **Installation**
- [Usage](./USAGE.md)
- [Configuration](./CONFIGURATION.md)
- [Benchmark](./BENCHMARK.md)

## Installation

This project can be installed many ways but here we'll provide some ways

### Git cloning (Recommended)

Cloning on project folder is the easiest and safest way to use project

```sh
# this line is important
git clone https://github.com/dalisoft/commitlint-sh.git --depth 1 .commitlint-sh

# other lines are optional
echo '.commitlint-sh' >> .gitignore'
git add -A .gitignore
git commit -m "chore: integration of commitlint-sh to my project"
```

### Git submodules

Using this project as **Git submodule** can be but it's not recommended

```sh
# this line is important
git submodule add -b master --name commitlint-sh --depth=1 -f https://github.com/dalisoft/commitlint-sh.git .commitlint-sh

# other lines are optional
git add -A .commitlint-sh
git commit -m "chore: integration of commitlint-sh to my project"
```
