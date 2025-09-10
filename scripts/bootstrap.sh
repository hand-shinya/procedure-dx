#!/usr/bin/env bash
set -euo pipefail
: "${GITHUB_ORG:?Set GITHUB_ORG}"
: "${REPO_NAME:?Set REPO_NAME}"
: "${AUTHOR_NAME:?Set AUTHOR_NAME}"
: "${AUTHOR_EMAIL:?Set AUTHOR_EMAIL}"

if ! command -v gh >/dev/null 2>&1; then
  echo "gh (GitHub CLI) が必要です。https://cli.github.com/"; exit 1
fi
if ! command -v git >/dev/null 2>&1; then
  echo "git が必要です。"; exit 1
fi

if ! gh repo view "${GITHUB_ORG}/${REPO_NAME}" >/dev/null 2>&1; then
  gh repo create "${GITHUB_ORG}/${REPO_NAME}" --public --confirm
fi

git init
git lfs install
git config user.name "$AUTHOR_NAME"
git config user.email "$AUTHOR_EMAIL"

git add .
git commit -m "chore: initial snapshot"
git branch -M main
git remote add origin "https://github.com/${GITHUB_ORG}/${REPO_NAME}.git" || true
git push -u origin main

if ! gh release view v0.1.0 >/dev/null 2>&1; then
  gh release create v0.1.0 --title "Initial public snapshot" --notes "Public snapshot of concepts/logic & arch."
fi

echo "Done."
