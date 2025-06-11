#!/usr/bin/env bash

tailscale up --operator=$USER --accept-routes --exit-node-allow-lan-access --accept-dns --exit-node=100.111.129.123 --reset && echo "VPN ENABLED" >/dev/pts/0
