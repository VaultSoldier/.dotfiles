#!/usr/bin/env bash
set -euo pipefail

LOCK="/tmp/lid-handler.lock"
LID="/proc/acpi/button/lid/LID/state"
LAPTOP_DISPLAY="eDP-1"

exec 9>"$LOCK"
flock -n 9 || exit 1

is_lid_closed() {
	rg -q "closed" "$LID" 2>/dev/null
}

external_connected() {
	hyprctl monitors -j | jq --arg d "$LAPTOP_DISPLAY" \
		'[.[] | select(.name != $d)] | length > 0'
}

if is_lid_closed; then
	if [ "$(external_connected)" = "true" ]; then
		hyprctl dispatch dpms off $LAPTOP_DISPLAY
	fi
else
	hyprctl dispatch dpms on $LAPTOP_DISPLAY
fi
