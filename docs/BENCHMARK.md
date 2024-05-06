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

> Spoiler: ~55-times faster than Node.js counterpart

| Command                                        | Mean \[ms\] | Min \[ms\] | Max \[ms\] |     Relative |
| :--------------------------------------------- | ----------: | ---------: | ---------: | -----------: |
| `echo "fix: it works" \| ../validate.sh`       |   3.2 ± 0.3 |        2.9 |        3.8 |  1.11 ± 0.21 |
| `echo "fix: it works" \| ./commitlint-rs`      |   2.8 ± 0.5 |        2.3 |        3.7 |         1.00 |
| `echo "fix: it works" \| ./commitlint-go lint` |   3.2 ± 0.8 |        2.5 |        5.0 |  1.13 ± 0.33 |
| `echo "fix: it works" \| commitlint`           | 162.1 ± 4.7 |      157.6 |      174.0 | 56.89 ± 9.25 |

### Workspace project

> Spoiler: ~25-times faster than Node.js counterpart

| Command                                   | Time \[ms\] |     Relative |
| :---------------------------------------- | ----------: | -----------: |
| `echo "foo(workspace)" \| ../validate.sh` |  6.83 ± 3.5 |         1.00 |
| `echo "foo(workspace)" \| commitlint`     |    194± 1.5 | 28.69 ± 0.33 |
