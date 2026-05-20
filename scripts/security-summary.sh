#!/usr/bin/env bash

set -euo pipefail

LANGUAGE="${LANGUAGE:-unknown}"
PACKAGE_MANAGER="${PACKAGE_MANAGER:-unknown}"
FRAMEWORK="${FRAMEWORK:-unknown}"
HAS_DOCKERFILE="${HAS_DOCKERFILE:-false}"
HAS_IAC="${HAS_IAC:-false}"
HAS_TESTS="${HAS_TESTS:-false}"

ENABLE_SAST="${ENABLE_SAST:-false}"
ENABLE_SECRETS="${ENABLE_SECRETS:-false}"
ENABLE_DEPENDENCIES="${ENABLE_DEPENDENCIES:-false}"
ENABLE_CONTAINER="${ENABLE_CONTAINER:-false}"
ENABLE_IAC="${ENABLE_IAC:-false}"

FAIL_ON_SEVERITY="${FAIL_ON_SEVERITY:-critical}"

SEMGREP_REPORT="${SEMGREP_REPORT:-semgrep-results.sarif}"
GITLEAKS_REPORT="${GITLEAKS_REPORT:-gitleaks-results.sarif}"
TRIVY_DEPENDENCY_REPORT="${TRIVY_DEPENDENCY_REPORT:-trivy-dependency-results.sarif}"
TRIVY_CONTAINER_REPORT="${TRIVY_CONTAINER_REPORT:-trivy-container-results.sarif}"
TRIVY_IAC_REPORT="${TRIVY_IAC_REPORT:-trivy-iac-results.sarif}"

SUMMARY_FILE="${GITHUB_STEP_SUMMARY:-secureflow-summary.md}"

status_icon() {
  local enabled="$1"

  if [ "$enabled" = "true" ]; then
    echo "✅ Enabled"
  else
    echo "⏭️ Disabled"
  fi
}

report_status() {
  local report_file="$1"

  if [ -f "$report_file" ]; then
    echo "✅ Generated"
  else
    echo "⚠️ Not found"
  fi
}

{
  echo "# SecureFlow DevSecOps Summary"
  echo ""
  echo "## Detected Stack"
  echo ""
  echo "| Attribute | Value |"
  echo "|---|---|"
  echo "| Language | \`${LANGUAGE}\` |"
  echo "| Package manager | \`${PACKAGE_MANAGER}\` |"
  echo "| Framework | \`${FRAMEWORK}\` |"
  echo "| Dockerfile | \`${HAS_DOCKERFILE}\` |"
  echo "| IaC files | \`${HAS_IAC}\` |"
  echo "| Tests | \`${HAS_TESTS}\` |"
  echo ""
  echo "## Security Checks"
  echo ""
  echo "| Check | Status | Report |"
  echo "|---|---|---|"
  echo "| SAST | $(status_icon "$ENABLE_SAST") | $(report_status "$SEMGREP_REPORT") |"
  echo "| Secrets scan | $(status_icon "$ENABLE_SECRETS") | $(report_status "$GITLEAKS_REPORT") |"
  echo "| Dependency scan | $(status_icon "$ENABLE_DEPENDENCIES") | $(report_status "$TRIVY_DEPENDENCY_REPORT") |"
  echo "| Container scan | $(status_icon "$ENABLE_CONTAINER") | $(report_status "$TRIVY_CONTAINER_REPORT") |"
  echo "| IaC scan | $(status_icon "$ENABLE_IAC") | $(report_status "$TRIVY_IAC_REPORT") |"
  echo ""
  echo "## Security Gate"
  echo ""
  echo "| Setting | Value |"
  echo "|---|---|"
  echo "| Fail on severity | \`${FAIL_ON_SEVERITY}\` |"
  echo ""
  echo "## Reports"
  echo ""
  echo "| Report | Path | Status |"
  echo "|---|---|---|"
  echo "| Semgrep SAST | \`${SEMGREP_REPORT}\` | $(report_status "$SEMGREP_REPORT") |"
  echo "| Gitleaks Secrets | \`${GITLEAKS_REPORT}\` | $(report_status "$GITLEAKS_REPORT") |"
  echo "| Trivy Dependencies | \`${TRIVY_DEPENDENCY_REPORT}\` | $(report_status "$TRIVY_DEPENDENCY_REPORT") |"
  echo "| Trivy Container | \`${TRIVY_CONTAINER_REPORT}\` | $(report_status "$TRIVY_CONTAINER_REPORT") |"
  echo "| Trivy IaC | \`${TRIVY_IAC_REPORT}\` | $(report_status "$TRIVY_IAC_REPORT") |"
  echo ""
  echo "## Notes"
  echo ""
  echo "- This summary is generated automatically by SecureFlow."
  echo "- Detailed findings are available in GitHub Code Scanning when SARIF upload is enabled."
  echo "- Failed jobs indicate that at least one security gate blocked the pipeline."
} >> "$SUMMARY_FILE"

echo "Security summary generated at: $SUMMARY_FILE"