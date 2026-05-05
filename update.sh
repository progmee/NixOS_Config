#!/bin/sh
set -e

cd /etc/nixos

git fetch origin main
LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse @{u})

if [ "$LOCAL" != "$REMOTE" ]; then
	echo "Found an update from github. Starting a deploy..."
	git pull origin main

	sudo nixos-rebuild switch --flake .#nixos
	echo "Configuration terminated"
else
	echo "No updates available"
fi
