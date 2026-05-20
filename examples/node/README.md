# SecureFlow Node.js Example

This example shows how a Node.js repository can consume SecureFlow DevSecOps reusable workflows.

## Supported Node.js stacks

This example can be used with:

- Node.js APIs
- Express
- NestJS
- React
- Next.js

## Usage

Create this file in the target repository:

```text
.github/workflows/secureflow-ci.yml
```

Then copy the workflow from:

```text
examples/node/secureflow-ci.yml
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
package.json
package-lock.json / yarn.lock / pnpm-lock.yaml
Dockerfile
.env.example
```

Do not commit real `.env` files or secrets.