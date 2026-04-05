#!/usr/bin/env bash
socket="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

handle() {
    local line="$1"

    [[ "$line" != "activespecial>>"* ]] && return

    name="${line#activespecial>>}"
    name="${name%%,*}"

    # if special workspace set submap global
    if [[ -n "$name" ]]; then
        hyprctl dispatch submap global
    else
        # if no special workspace set based on current layout
        layout=$(hyprctl activeworkspace -j | jq -r '.tiledLayout')
        if [[ "$layout" == "scrolling" ]]; then
            hyprctl dispatch submap scrolling
        else
            hyprctl dispatch submap global
        fi
    fi
}

socat -U - UNIX-CONNECT:"$socket" | while read -r line; do handle "$line"; done
