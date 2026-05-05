#!/bin/sh
# Exit on error and print each command
set -ex

# Go to config directory
cd /etc/nixos

# Force fetch from remote
git fetch origin main

# Check if we actually need an update
LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse origin/main)

if [ "$LOCAL" != "$REMOTE" ]; then
    echo "--- Changes detected. Forcing reset ---"
    
    # Force local state to match remote exactly
    git reset --hard origin/main
    
    # Run rebuild. 
    # Use full path and ensure it doesn't try to open an interactive sudo prompt
    /run/current-system/sw/bin/sudo /run/current-system/sw/bin/nixos-rebuild switch --flake /etc/nixos#nixos
    
    echo "--- Update completed successfully ---"
else
    echo "--- System is up to date ---"
fi