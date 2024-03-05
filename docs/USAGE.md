# commitlint-sh \[0.x\]

> Except bugs, errors and/or strange behavior

[![Coverage Status](https://coveralls.io/repos/github/dalisoft/commitlint-sh/badge.svg?branch=master)](https://coveralls.io/github/dalisoft/commitlint-sh?branch=master)

Blazing fast minimal commitlint validation script written in **Bash** with presets support

List of contents:

- [Github repository](https://github.com/dalisoft/commitlint-sh)
- [Getting Started](./GET_STARTED.md)
- [Installation](./INSTALLATION.md)
- **Usage**
- [Configuration](./CONFIGURATION.md)
- [Benchmark](./BENCHMARK.md)

## Usage

This project can be used as you wish, local, remote, on CI and/or at VPS. Everywhere it works on same logic as you provide same credentials

### Requirements

> See [Getting Started](./GET_STARTED.md) page if you didn't read

- **bash** version **v5+** for best reliability

### Preparation

- Add `.commitlint-sh` to `.gitignore`
- Add your `.gitignore` to commit
- Push into remote

### Commands

```bash
git clone https://github.com/dalisoft/commitlint-sh.git --depth 1 .commitlint-sh
bash .commitlint-sh/validate.sh
```

## Options

| Name        | Description                          | Default      | Required |
| ----------- | ------------------------------------ | ------------ | -------- |
| `verbose`   | Verbose logs                         | `true` on CI | No       |
| `quiet`     | Quiet logs                           | `false`      | No       |
| `workspace` | Releases every projects on workspace | `false`      | No       |
