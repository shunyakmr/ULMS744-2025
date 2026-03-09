#! /bin/bash

# clear
# rm -r *_cache *_files

# Make script stop on errors
set -e

BRANCH=$(git branch --show-current)

# render
quarto render

# track changes
git add .
# commit only if something is staged
if git diff --cached --quiet; then
  echo "ℹ️ No changes to commit."
else
  git commit -m "${1:-update}"
fi

# publish
git push -u origin "$BRANCH"

echo "✅ Published: $BRANCH"

# Make it executable (first time only)
# chmod +x _publish.sh

# We can do this on main or inside a branch.
# Reminder: get into branch via git checkout BRANCH_NAME
