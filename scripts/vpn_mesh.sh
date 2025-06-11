#!/usr/bin/env bash

tailscale up --operator=$USER --accept-routes --accept-dns --reset && echo "MESH ON" >/dev/pts/0
