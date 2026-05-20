# SecureFlow Fixtures

Fixtures are intentionally insecure sample projects used to validate SecureFlow scanners.

## Safety warning

These fixtures and community vulnerable labs are intentionally insecure.
Run them only locally.
Do not expose them to the internet.
Do not use real credentials.

## Included fixtures

- node-vulnerable-app
- python-vulnerable-app
- java-maven-vulnerable-app
- java-gradle-vulnerable-app
- dotnet-vulnerable-app
- go-vulnerable-app
- iac-misconfig
- docker-compose.vulnerable-labs.yml

## Community vulnerable labs

This repository references community projects for local validation:

- OWASP Juice Shop
- OWASP WebGoat
- DVWA

## Validation workflows

The workflows under `examples/fixtures/workflows/` now show how to call SecureFlow with `working_directory` for internal fixture validation.

Runnable workflow entrypoints live under `.github/workflows/` in this repository and mirror these examples for `workflow_dispatch` testing.

Those validation workflows are configured to fail when the insecure fixtures trigger findings so the gate behavior can be verified directly.
