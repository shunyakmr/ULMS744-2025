#!/bin/bash

# Refuse to run if already on `main`
if [ "$BRANCH" = "main" ]; then
  echo "❌ You are on main. Switch to a chapter branch before releasing."
  exit 1
fi

# Get current `branch` name
BRANCH=$(git branch --show-current)

# Final commit on feature `branch`
quarto render
git add .
git commit -m "${1:-update}"
git push

# Switch to `main` and merge
git checkout main
git merge $BRANCH

# Render and publish `main`
quarto render
git add .
git commit -m "Publish: ${1:-update}"
git push origin main

echo "✅ Merged $BRANCH into main and published!"

# Make it executable (first time only)
# chmod +x _release.sh

# This is only to be ran on a `branch`.
# When the `branch` is ready for release, run this!
# It will merge the changes into `main`.

# Once it is merged, remember that the other branches will be "detached" from the main.
