# Security Gates

SecureFlow supports configurable security gates for SAST findings.

## SAST

SAST is powered by Semgrep.

Default config:

```text
p/owasp-top-ten

## Secrets scanning

Secrets scanning is powered by Gitleaks.

Gitleaks detects hardcoded secrets such as:

- API keys
- Passwords
- Tokens
- Private keys
- Cloud credentials

Default behavior:

```text
redact: true
exit_code: 1
report_format: sarif

## Dependency scanning

Dependency scanning is powered by Trivy.

Trivy runs in filesystem mode and scans dependency files found in the repository.

Default behavior:

```text
severity: CRITICAL,HIGH
ignore_unfixed: true
exit_code: 1
report_format: sarif
```

Example:

```yaml
jobs:
  secure-ci:
    uses: thebinario/secureflow-devsecops/.github/workflows/secure-ci.yml@main
    with:
      enable_dependencies: true
      trivy_dependency_severity: "CRITICAL,HIGH"
      trivy_dependency_ignore_unfixed: "true"
      trivy_dependency_exit_code: "1"
```

## Container scanning

Container scanning is powered by Trivy.

The container scan builds the Docker image from the target repository and scans the generated image before deployment.

Default behavior:

```text
severity: CRITICAL,HIGH
ignore_unfixed: true
exit_code: 1
report_format: sarif
```

Example:

```yaml
jobs:
  secure-ci:
    uses: thebinario/secureflow-devsecops/.github/workflows/secure-ci.yml@main
    with:
      enable_container: true
      container_image_name: "my-api"
      container_image_tag: "ci-${{ github.sha }}"
      dockerfile_path: "Dockerfile"
      docker_build_context: "."
      trivy_container_severity: "CRITICAL,HIGH"
      trivy_container_ignore_unfixed: "true"
      trivy_container_exit_code: "1"
```

## IaC scanning

IaC scanning is powered by Trivy.

The IaC scan checks infrastructure files for security misconfigurations.

Supported examples:

- Terraform files
- CloudFormation templates
- Serverless files
- Kubernetes manifests

Default behavior:

```text
severity: CRITICAL,HIGH
exit_code: 1
report_format: sarif
```

Example:

```yaml
jobs:
  secure-ci:
    uses: thebinario/secureflow-devsecops/.github/workflows/secure-ci.yml@main
    with:
      enable_iac: true
      iac_scan_path: "."
      trivy_iac_severity: "CRITICAL,HIGH"
      trivy_iac_exit_code: "1"
```

## Security summary

SecureFlow generates a GitHub Actions job summary at the end of the pipeline.

The summary includes:

- Detected language
- Detected package manager
- Detected framework
- Dockerfile detection
- IaC detection
- Enabled security checks
- Generated reports
- Security gate configuration

The summary is written using `GITHUB_STEP_SUMMARY`.

## Examples

SecureFlow provides example workflows for common stacks.

### Node.js

Use this example for Node.js, Express, NestJS, React or Next.js projects:

```text
examples/consumers/node/full-security.yml
```

### Python

Use this example for FastAPI, Flask, Django or Python service projects:

```text
examples/consumers/python/full-security.yml
```

## Minimal usage

```yaml
name: SecureFlow CI

on:
  pull_request:
  push:
    branches:
      - main

permissions:
  contents: read
  security-events: write
  actions: read

jobs:
  secure-ci:
    uses: thebinario/secureflow-devsecops/.github/workflows/secure-ci.yml@main
    with:
      enable_sast: true
      enable_secrets: true
      enable_dependencies: true
      enable_container: true
      enable_iac: true
```
