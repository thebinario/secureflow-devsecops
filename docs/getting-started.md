# Getting Started

SecureFlow DevSecOps provides reusable GitHub Actions workflows and composite actions for secure CI pipelines.

## Usage

Create the following workflow in the repository that wants to consume SecureFlow:

```yaml
name: SecureFlow CI

on:
  pull_request:
  push:
    branches:
      - master

permissions:
  contents: read
  security-events: write
  actions: read

jobs:
  secure-ci:
    uses: thebinario/secureflow-devsecops/.github/workflows/secure-ci.yml@master
    with:
      fail_on_severity: critical
      enable_sast: true
      enable_secrets: true
      enable_dependencies: true
      enable_container: true
      enable_iac: true
