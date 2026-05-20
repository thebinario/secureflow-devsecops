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
- iac-misconfig
- docker-compose.vulnerable-labs.yml

## Community vulnerable labs

This repository references community projects for local validation:

- OWASP Juice Shop
- OWASP WebGoat
- DVWA

## Validation workflows

The workflows under `examples/fixtures/workflows/` are examples for controlled validation runs.

The current reusable workflow does not support `working_directory`, so scanning internal fixtures directly through `.github/workflows/secure-ci.yml` is still limited.

## Future improvement

The main reusable workflow should support `working_directory` to allow scanning internal fixtures directly.

That improvement should:

- add input `working_directory` to `.github/workflows/secure-ci.yml`
- pass the input through the composite actions
- allow scanning subpaths such as `examples/fixtures/node-vulnerable-app`
