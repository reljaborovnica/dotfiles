#!/bin/bash

TEMP_ART="/tmp/mpris_art.jpg"

playerctl --follow metadata --format "{{artist}}|{{title}}|{{mpris:artUrl}}" | while IFS='|' read -r ARTIST TITLE ARTURL; do
    # If any values are empty, set defaults
    [ -z "$ARTIST" ] && ARTIST="Unknown Artist"
    [ -z "$TITLE" ] && TITLE="Unknown Title"

    # Download artwork if available
    if [[ "$ARTURL" =~ ^https?:// ]]; then
        curl -s -L "$ARTURL" -o "$TEMP_ART"
        ICON_FLAG="-i $TEMP_ART"
    else
        ICON_FLAG=""
    fi

    # Send Dunst notification
    notify-send $ICON_FLAG "🎵 $TITLE" "$ARTIST"

done

