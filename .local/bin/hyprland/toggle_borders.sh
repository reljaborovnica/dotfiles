#!/bin/bash

# Get current border size
BORDER=$(hyprctl getoption general:border_size -j | jq '.int')

if [ "$BORDER" -eq 0 ]; then
  hyprctl keyword general:border_size 1
else
  hyprctl keyword general:border_size 0
fi

