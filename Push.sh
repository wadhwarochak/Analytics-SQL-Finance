#!/bin/bash

# Exit on any error
set -e

# Ask user for commit message
read -p "Enter commit message (press Enter for default): " USER_MSG

# Use default if empty
COMMIT_MSG=${USER_MSG:-"Updated recent changes"}

# Show status
git status

# Add all changes
git add -A

# Commit
git commit -m "$COMMIT_MSG"

# Push
git push

echo "✅ Changes pushed successfully with message: '$COMMIT_MSG'"
