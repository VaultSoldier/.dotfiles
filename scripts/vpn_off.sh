#!/bin/bash

tailscale up --operator=$USER --accept-routes --accept-dns --reset && echo "VPN DISABLED" > /dev/pts/0
