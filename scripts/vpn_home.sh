#!/bin/bash

tailscale up --operator=$USER --accept-routes --exit-node-allow-lan-access --accept-dns --exit-node=100.81.213.46 --reset && echo "VPN HOME ENABLED" >/dev/pts/0
