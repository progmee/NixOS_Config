#!/bin/sh
set -e

# English comments for clarity
# Navigate to config directory
cd /etc/nixos

# Fetch latest changes from remote
git fetch origin main
LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse origin/main)

if [ "$LOCAL" != "$REMOTE" ]; then
    echo "--- Update found. Resetting local state to remote ---"
    
    # FORCED RESET: This will discard any local changes in /etc/nixos
    # to avoid merge conflicts
    git reset --hard origin/main
    
    # Rebuild the system using the new config
    sudo nixos-rebuild switch --flake .#nixos
    echo "--- Deployment successful ---"
else
    echo "--- No changes detected ---"
fi