#!/usr/bin/env bash
LID="/proc/acpi/button/lid/LID/state"
LAPTOP_DISPLAY="eDP-1"

is_lid_closed() {
	grep -q "closed" "$LID" 2>/dev/null ||
		grep -q "closed" /proc/acpi/button/lid/LID/state 2>/dev/null
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
