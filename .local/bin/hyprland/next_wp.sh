#!/bin/bash

WALLDIR="$HOME/Pictures/Wallpapers/Hyprwall"
CACHEDIR="$WALLDIR/.cache"
LISTFILE="$CACHEDIR/wallpaper_list.txt"
INDEXFILE="$CACHEDIR/wallpaper_index.txt"

# Always regenerate the list to stay fresh
find "$WALLDIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) | sort > "$LISTFILE"

# Check if list is empty
TOTAL=$(wc -l < "$LISTFILE")
if [ "$TOTAL" -eq 0 ]; then
    echo "No wallpapers found in $WALLDIR"
    exit 1
fi

# Read index or initialize
if [ ! -f "$INDEXFILE" ]; then
    INDEX=0
else
    INDEX=$(cat "$INDEXFILE")
    # Fallback in case file is empty or broken
    if ! [[ "$INDEX" =~ ^[0-9]+$ ]]; then
        INDEX=0
    fi
fi

# Loop if index is out of range
if [ "$INDEX" -ge "$TOTAL" ]; then
    INDEX=0
fi

# Get the wallpaper
WALL=$(sed -n "$((INDEX + 1))p" "$LISTFILE")

# Check that WALL exists
if [ -z "$WALL" ]; then
    echo "No wallpaper found at index $INDEX"
    exit 1
fi

# Set the wallpaper
swww img "$WALL" 

# Save new index
echo $((INDEX + 1)) > "$INDEXFILE"
