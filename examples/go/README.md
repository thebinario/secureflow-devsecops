# SecureFlow Go Examples

This entry groups the Go examples for APIs and services.

## Consumer workflows

Copy the consumer workflow into the target repository at:

```text
.github/workflows/secureflow-ci.yml
```

- `../consumers/go/secureflow-ci.yml`

## Local fixtures

Use this fixture to validate SecureFlow locally in this repository:

- `../fixtures/go-vulnerable-app`

## Community lab note

For community lab reference, evaluate intentionally vulnerable Go apps only in isolated local environments.

Example:

- GOwasp

This repository keeps the automated validation scope inside the local fixture so the workflow stays reproducible and controlled.
