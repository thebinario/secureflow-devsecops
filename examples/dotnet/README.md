# SecureFlow .NET Examples

This entry groups the .NET examples for APIs and services.

## Consumer workflows

Copy the consumer workflow into the target repository at:

```text
.github/workflows/secureflow-ci.yml
```

- `../consumers/dotnet/secureflow-ci.yml`

## Local fixtures

Use this fixture to validate SecureFlow locally in this repository:

- `../fixtures/dotnet-vulnerable-app`

## Community lab note

For community lab reference, evaluate intentionally vulnerable .NET apps only in isolated local environments.

Examples:

- OWASP VulnerableApp4APISecurity
- AspGoat

This repository keeps the automated validation scope inside the local fixture so the workflow stays reproducible and controlled.
