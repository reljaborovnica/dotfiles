#!/bin/bash

# Get current gaps_in value
GAPS=$(hyprctl getoption general:gaps_in -j | jq -r '.custom' | awk '{print $1}')

if [ "$GAPS" -eq 0 ]; then
  hyprctl keyword general:gaps_in 8
  hyprctl keyword general:gaps_out 20
else
  hyprctl keyword general:gaps_in 0
  hyprctl keyword general:gaps_out 0
fi

