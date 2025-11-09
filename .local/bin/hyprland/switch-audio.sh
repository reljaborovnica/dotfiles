#!/bin/bash

# Function to simplify device names
get_clean_name() {
    case "$1" in
        *HyperX*) echo "Hyper X Cloud III" ;;
        *hdmi*)            echo "BenQ EX2710Q HDMI" ;;
        *iec958-stereo*) echo "IEC958" ;;
        *)                 echo "$1" ;;
    esac
}

# Function to get appropriate icon
get_device_icon() {
    case "$1" in
        *HyperX*) echo "audio-headphones" ;;
        *hdmi*)            echo "video-display" ;;
        *iec958-stereo*)          echo "audio-card" ;;
        *)                 echo "audio-card" ;;  
    esac
}

# Get available output devices
DEVICES=$(pactl list short sinks | awk '{print $1,$2}')

# Get current default sink
CURRENT_SINK=$(pactl info | grep "Default Sink" | cut -d' ' -f3)

# Extract sink IDs and names
SINK_IDS=()
SINK_NAMES=()
CLEAN_NAMES=()
ICONS=()
while read -r id name; do
    SINK_IDS+=("$id")
    SINK_NAMES+=("$name")
    clean_name=$(get_clean_name "$name")
    CLEAN_NAMES+=("$clean_name")
    ICONS+=("$(get_device_icon "$name")")
done <<< "$DEVICES"

# Find current sink index
CURRENT_INDEX=-1
for i in "${!SINK_IDS[@]}"; do
    if [[ "${SINK_NAMES[$i]}" == "$CURRENT_SINK" ]]; then
        CURRENT_INDEX=$i
        break
    fi
done

# Switch to next sink
NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ${#SINK_IDS[@]} ))
NEXT_SINK="${SINK_NAMES[$NEXT_INDEX]}"
NEXT_CLEAN_NAME="${CLEAN_NAMES[$NEXT_INDEX]}"
NEXT_ICON="${ICONS[$NEXT_INDEX]}"

# Set new default sink
pactl set-default-sink "$NEXT_SINK"

# Move all playing streams to new sink
pactl list short sink-inputs | awk '{print $1}' | xargs -I{} pactl move-sink-input {} "$NEXT_SINK"

# Show notification with sound and icon
notify-send -t 3000 -i "$NEXT_ICON" "Audio Output" "$NEXT_CLEAN_NAME"
