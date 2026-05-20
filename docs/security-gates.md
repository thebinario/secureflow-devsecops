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