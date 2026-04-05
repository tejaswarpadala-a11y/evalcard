#!/bin/bash
# ─────────────────────────────────────────────
# EVALCARD → GitHub Push Script
# Repo: tejaswarpadala-a11y/evalcard
# ─────────────────────────────────────────────

echo "Enter your GitHub Personal Access Token (classic, repo scope):"
read -s GITHUB_TOKEN

GITHUB_USER="tejaswarpadala-a11y"
REPO_NAME="evalcard"

# Create the repo via GitHub API
echo "Creating repo on GitHub..."
curl -s -X POST \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/user/repos \
  -d "{\"name\":\"$REPO_NAME\",\"description\":\"LLM-as-judge eval framework — scores any LLM output across 5 dimensions\",\"homepage\":\"https://github.com/$GITHUB_USER/$REPO_NAME\",\"private\":false,\"has_issues\":true}" \
  | python3 -c "import sys,json; d=json.load(sys.stdin); print('Repo created:', d.get('html_url','see above'))" 2>/dev/null || echo "Repo may already exist — continuing..."

# Push
cd evalcard
git remote add origin "https://$GITHUB_TOKEN@github.com/$GITHUB_USER/$REPO_NAME.git" 2>/dev/null || \
  git remote set-url origin "https://$GITHUB_TOKEN@github.com/$GITHUB_USER/$REPO_NAME.git"

git push -u origin main

echo ""
echo "Done! → https://github.com/$GITHUB_USER/$REPO_NAME"
