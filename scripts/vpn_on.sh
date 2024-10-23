#!/bin/bash

tailscale up --operator=$USER --accept-routes --exit-node-allow-lan-access --accept-dns --exit-node=100.85.223.148 --reset && echo "VPN ENABLED" > /dev/pts/0
