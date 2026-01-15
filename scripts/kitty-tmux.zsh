#!/usr/bin/env zsh

tmux new-session -s "|TERM|pid_$$"
exec zsh
