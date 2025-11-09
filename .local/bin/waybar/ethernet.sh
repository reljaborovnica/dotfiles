#!/bin/bash

# Get Ethernet interface
ETH_INTERFACE=$(ip -o link show | awk -F': ' '/state UP/ {print $2}' | grep -E '^(enp|eth)')

# Get IP address
ETH_IP=$(ip -4 addr show "$ETH_INTERFACE" | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

# Get speed in Mbit/s
ETH_SPEED=$(cat /sys/class/net/"$ETH_INTERFACE"/speed 2>/dev/null || echo "N/A")

if [[ -n "$ETH_IP" ]]; then
    echo "🏠 $ETH_IP"
else
    echo "🏠 No Internet"
fi

#󰌘  
