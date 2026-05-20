# SecureFlow Python Example

This example shows how a Python repository can consume SecureFlow DevSecOps reusable workflows.

## Supported Python stacks

This example can be used with:

- FastAPI
- Flask
- Django
- Python services
- Python automation scripts

## Usage

Create this file in the target repository:

```text
.github/workflows/secureflow-ci.yml
```

Then copy the workflow from:

```text
examples/python/secureflow-ci.yml
```

## What this runs

- Stack detection
- SAST with Semgrep
- Secrets scanning with Gitleaks
- Dependency scanning with Trivy
- Container scanning with Trivy when Dockerfile exists
- IaC scanning with Trivy when IaC files exist
- Security summary

## Required permissions

```yaml
permissions:
  contents: read
  security-events: write
  actions: read
```

## Recommended files in the target repository

```text
requirements.txt
pyproject.toml
poetry.lock
Dockerfile
.env.example
```

Do not commit real `.env` files or secrets.