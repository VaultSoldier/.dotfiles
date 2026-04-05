#!/usr/bin/env bash
socket="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

while true; do
    socat -U - UNIX-CONNECT:"$socket" | while read -r line; do
        if [[ "$line" == "activespecial>>"* ]]; then
            name="${line#activespecial>>}"
            name="${name%%,*}"
            if [[ -z "$name" ]]; then
                layout=$(hyprctl activeworkspace -j | jq -r '.tiledLayout')
                if [[ "$layout" == "scrolling" ]]; then
                    hyprctl dispatch submap scrolling
                else
                    hyprctl dispatch submap global
                fi
            fi
        fi
    done
    sleep 1  # wait before reconnect attempt
done
