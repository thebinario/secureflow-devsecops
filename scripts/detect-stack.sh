#!/usr/bin/env bash

set -euo pipefail

LANGUAGE="unknown"
PACKAGE_MANAGER="unknown"
FRAMEWORK="unknown"
HAS_DOCKERFILE="false"
HAS_IAC="false"
HAS_TESTS="false"

if [ -f "package.json" ]; then
  LANGUAGE="node"

  if [ -f "pnpm-lock.yaml" ]; then
    PACKAGE_MANAGER="pnpm"
  elif [ -f "yarn.lock" ]; then
    PACKAGE_MANAGER="yarn"
  elif [ -f "package-lock.json" ]; then
    PACKAGE_MANAGER="npm"
  fi

  if grep -q '"next"' package.json; then
    FRAMEWORK="nextjs"
  elif grep -q '"@nestjs/core"' package.json; then
    FRAMEWORK="nestjs"
  elif grep -q '"react"' package.json; then
    FRAMEWORK="react"
  elif grep -q '"express"' package.json; then
    FRAMEWORK="express"
  fi
fi

if [ -f "pyproject.toml" ] || [ -f "requirements.txt" ]; then
  LANGUAGE="python"

  if [ -f "poetry.lock" ]; then
    PACKAGE_MANAGER="poetry"
  elif [ -f "requirements.txt" ]; then
    PACKAGE_MANAGER="pip"
  fi

  if [ -f "pyproject.toml" ] && grep -qi "fastapi" pyproject.toml; then
    FRAMEWORK="fastapi"
  elif [ -f "requirements.txt" ] && grep -qi "fastapi" requirements.txt; then
    FRAMEWORK="fastapi"
  elif [ -f "requirements.txt" ] && grep -qi "django" requirements.txt; then
    FRAMEWORK="django"
  fi
fi

if [ -f "pom.xml" ]; then
  LANGUAGE="java"
  PACKAGE_MANAGER="maven"
  FRAMEWORK="unknown"
fi

if [ -f "build.gradle" ] || [ -f "build.gradle.kts" ]; then
  LANGUAGE="java"
  PACKAGE_MANAGER="gradle"
  FRAMEWORK="unknown"
fi

if find . -maxdepth 3 -name "*.csproj" | grep -q .; then
  LANGUAGE="dotnet"
  PACKAGE_MANAGER="nuget"
  FRAMEWORK="dotnet"
fi

if [ -f "go.mod" ]; then
  LANGUAGE="go"
  PACKAGE_MANAGER="go-modules"
  FRAMEWORK="unknown"
fi

if [ -f "Dockerfile" ] || find . -maxdepth 3 -iname "Dockerfile*" | grep -q .; then
  HAS_DOCKERFILE="true"
fi

if find . -maxdepth 5 \( -name "*.tf" -o -name "serverless.yml" -o -name "template.yaml" -o -name "template.yml" -o -name "cloudformation.yaml" -o -name "cloudformation.yml" \) | grep -q .; then
  HAS_IAC="true"
fi

if find . -maxdepth 4 \( -path "*/test/*" -o -path "*/tests/*" -o -name "*.spec.*" -o -name "*.test.*" \) | grep -q .; then
  HAS_TESTS="true"
fi

echo "language=$LANGUAGE" >> "$GITHUB_OUTPUT"
echo "package_manager=$PACKAGE_MANAGER" >> "$GITHUB_OUTPUT"
echo "framework=$FRAMEWORK" >> "$GITHUB_OUTPUT"
echo "has_dockerfile=$HAS_DOCKERFILE" >> "$GITHUB_OUTPUT"
echo "has_iac=$HAS_IAC" >> "$GITHUB_OUTPUT"
echo "has_tests=$HAS_TESTS" >> "$GITHUB_OUTPUT"

echo "Detected language: $LANGUAGE"
echo "Detected package manager: $PACKAGE_MANAGER"
echo "Detected framework: $FRAMEWORK"
echo "Has Dockerfile: $HAS_DOCKERFILE"
echo "Has IaC: $HAS_IAC"
echo "Has tests: $HAS_TESTS"