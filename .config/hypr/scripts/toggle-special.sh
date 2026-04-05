#!/usr/bin/env bash
set -uo pipefail

"$@" || true
sleep 0.05
special=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .specialWorkspace.name')
if [[ -n "$special" ]]; then
    hyprctl dispatch submap global
elif [[ "$(hyprctl activeworkspace -j | jq -r '.tiledLayout')" == "scrolling" ]]; then
    hyprctl dispatch submap scrolling
else
    hyprctl dispatch submap global
fi
