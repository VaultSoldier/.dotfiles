#!/usr/bin/env bash
socket="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

set_layout_by_submap() {
    local layout
    layout=$(hyprctl activeworkspace -j | jq -r '.tiledLayout')
    if [[ "$layout" == "scrolling" ]]; then
        hyprctl dispatch submap scrolling
    else
        hyprctl dispatch submap global
    fi

}

handle() {
    local line="$1"

    case "$line" in
    "activespecial>>"*)
        name="${line#activespecial>>}"
        name="${name%%,*}"

        if [[ -n "$name" ]]; then
            hyprctl dispatch submap global
        else
            set_layout_by_submap
        fi
        ;;

    "focusedmonv2>>"*)
        special=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .specialWorkspace.name')
        [[ -n "$special" ]] && return
        set_layout_by_submap
        ;;
    esac
}

socat -U - UNIX-CONNECT:"$socket" | while read -r line; do handle "$line"; done
