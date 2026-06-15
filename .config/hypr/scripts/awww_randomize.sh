#!/usr/bin/env bash
# Changes the wallpaper to a randomly chosen image in a given directory
# at a set interval.
DEFAULT_INTERVAL=300 # In seconds
ONE_TIME=false

# Parse flags
while [[ "$1" == -* ]]; do
	case "$1" in
		-o|--once) ONE_TIME=true; shift ;;
		*) echo "Unknown option: $1"; exit 1 ;;
	esac
done

if [ $# -lt 1 ] || [ ! -d "$1" ]; then
	printf "Usage:\n\t\e[1m%s\e[0m [\e[4m-o\e[0m] \e[4mDIRECTORY\e[0m [\e[4mINTERVAL\e[0m]\n" "$0"
	printf "\tChanges the wallpaper to a randomly chosen image in DIRECTORY every\n\tINTERVAL seconds (or every %d seconds if unspecified).\n" "$DEFAULT_INTERVAL"
	printf "\t-o, --once\tSet a random wallpaper and exit.\n"
	exit 1
fi

# See awww-img(1)
RESIZE_TYPE="fit"
export AWWW_TRANSITION_FPS="${AWWW_TRANSITION_FPS:-60}"
export AWWW_TRANSITION_STEP="${AWWW_TRANSITION_STEP:-2}"

pick_random() {
	find "$1" -type f |
		while read -r img; do
			echo "$(</dev/urandom tr -dc a-zA-Z0-9 | head -c 8):$img"
		done |
		sort -n | cut -d':' -f2- | head -n1
}

if $ONE_TIME; then
	img="$(pick_random "$1")"
	awww img --resize="$RESIZE_TYPE" "$img"
	exit 0
fi

while true; do
	find "$1" -type f |
		while read -r img; do
			echo "$(</dev/urandom tr -dc a-zA-Z0-9 | head -c 8):$img"
		done |
		sort -n | cut -d':' -f2- |
		while read -r img; do
			awww img --resize="$RESIZE_TYPE" "$img"
			sleep "${2:-$DEFAULT_INTERVAL}"
		done
done
