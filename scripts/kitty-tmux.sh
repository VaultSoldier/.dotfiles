#!/usr/bin/env bash

tmux new-session -s "|TERM|pid_$$"
exec zsh
