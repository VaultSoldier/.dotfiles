#!/usr/bin/env bash
set -euo pipefail

# change wallpaper on startup
caelestia wallpaper -r

# change wallpaper every 2h
while true; do
		sleep 7200
		caelestia wallpaper -r
done
