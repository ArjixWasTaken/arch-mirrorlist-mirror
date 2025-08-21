#!/bin/bash

# Arch Linux Mirror Status Update Script
# This script replaces the GitHub Actions workflow to avoid IP blocking issues
# Run this script as a cron job to automatically update the mirror status

set -e  # Exit on any error

# Configuration
MIRROR_URL="https://archlinux.org/mirrors/status/json/"
OUTPUT_FILE="mirrors.json"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Change to script directory
cd "$SCRIPT_DIR"

echo "=== Arch Linux Mirror Status Update - $(date) ==="

# Fetch mirror status JSON
echo "Fetching mirror status from archlinux.org..."
echo "URL: $MIRROR_URL"
echo "Output file: $OUTPUT_FILE"

# Use more verbose curl for debugging
if curl -f -s -w "HTTP Status: %{http_code}\n" "$MIRROR_URL" -o "$OUTPUT_FILE"; then
    echo "Successfully fetched mirror status"
    echo "File size: $(wc -c < "$OUTPUT_FILE") bytes"
    
    # Check if file is not empty
    if [ ! -s "$OUTPUT_FILE" ]; then
        echo "Error: Downloaded file is empty"
        exit 1
    fi
else
    echo "Failed to fetch mirror status from $MIRROR_URL"
    echo "Curl exit code: $?"
    exit 1
fi

# Validate JSON if jq is available
if command -v jq &> /dev/null; then
    echo "Validating JSON format..."
    if jq . "$OUTPUT_FILE" > /dev/null; then
        echo "JSON is valid"
    else
        echo "Invalid JSON format"
        exit 1
    fi
else
    echo "jq not available, skipping JSON validation"
fi

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "Warning: Not in a git repository. File updated but not committed."
    echo "Update completed successfully at $(date)"
    exit 0
fi

# Configure git if not already configured
if [ -z "$(git config user.name)" ]; then
    git config --local user.name "Mirror Update Script"
fi
if [ -z "$(git config user.email)" ]; then
    git config --local user.email "update@local"
fi

# Commit and push changes
echo "Checking for changes..."
git add "$OUTPUT_FILE"

if git diff --staged --quiet; then
    echo "No changes to commit"
else
    echo "Committing changes..."
    git commit -m "Update mirror status - $(date -u)"
    
    # Only push if we have a remote configured
    if git remote | grep -q origin; then
        echo "Pushing changes to remote repository..."
        git push
        echo "Successfully pushed changes"
    else
        echo "No remote 'origin' configured. Changes committed locally only."
    fi
fi

echo "Update completed successfully at $(date)"