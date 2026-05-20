# SecureFlow Python Consumer

Copy one of these workflows into the target repository at:

```text
.github/workflows/secureflow-ci.yml
```

These examples are intended for FastAPI, Flask, Django, and generic Python service repositories.

- `minimal.yml`: basic SecureFlow integration.
- `with-docker.yml`: enables Docker image scanning for repositories with a `Dockerfile`.
- `full-security.yml`: enables the full SecureFlow gate set.
