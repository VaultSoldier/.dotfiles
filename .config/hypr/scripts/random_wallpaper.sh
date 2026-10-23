#!/usr/bin/env bash
set -euo pipefail

# change wallpaper on startup (non-fatal: shell may not be up yet / empty dir)
caelestia wallpaper -r || true

# change wallpaper every 2h
while true; do
		sleep 7200
		caelestia wallpaper -r
done
