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

> Spoiler: ~30-times faster than Node.js counterpart

| Command                                                  | Mean \[ms\] | Min \[ms\] | Max \[ms\] |     Relative |
| :------------------------------------------------------- | ----------: | ---------: | ---------: | -----------: |
| `echo "fix: it works" \| ../validate.sh`                 |   6.8 ± 4.3 |        3.2 |       15.2 |  2.63 ± 1.69 |
| `echo "fix: it works" \| ./commitlint-rs`                |   2.6 ± 0.3 |        2.1 |        3.1 |         1.00 |
| `echo "fix: it works" \| ./commitlint-go lint`           |   2.6 ± 0.2 |        2.2 |        3.0 |  1.00 ± 0.16 |
| `echo "fix: it works" \| ./node_modules/.bin/commitlint` | 159.4 ± 3.9 |      157.5 |      169.9 | 61.55 ± 7.73 |

### Workspace project

> Spoiler: ~30-times faster than Node.js counterpart

| Command                                                          | Mean \[ms\] | Min \[ms\] | Max \[ms\] |     Relative |
| :--------------------------------------------------------------- | ----------: | ---------: | ---------: | -----------: |
| `echo "echo "foo(workspace)"" \| ../validate.sh`                 |   6.8 ± 4.3 |        3.2 |       15.2 |  2.63 ± 1.69 |
| `echo "echo "foo(workspace)"" \| ./node_modules/.bin/commitlint` | 159.4 ± 3.9 |      157.5 |      169.9 | 61.55 ± 7.73 |
