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