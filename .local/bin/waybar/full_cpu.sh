#!/bin/bash

# --- CPU usage ---
# Read first snapshot
read cpu user nice system idle iowait irq softirq steal guest < /proc/stat
total1=$((user + nice + system + idle + iowait + irq + softirq + steal))

# Wait a short interval
sleep 0.3

# Read second snapshot
read cpu user2 nice2 system2 idle2 iowait2 irq2 softirq2 steal2 guest2 < /proc/stat
total2=$((user2 + nice2 + system2 + idle2 + iowait2 irq2 softirq2 steal2))

# Calculate active delta
idle_delta=$((idle2 - idle))
total_delta=$((total2 - total1))
cpu_usage=$((100 * (total_delta - idle_delta) / total_delta))

# --- CPU temp ---
cpu_temp="N/A"

for d in /sys/class/hwmon/hwmon*; do
    if [[ -f "$d/name" ]]; then
        name=$(<"$d/name")
        case "$name" in
            coretemp|acpitz)
                # Intel / ACPI fallback
                if [[ -f "$d/temp1_input" ]]; then
                    temp_raw=$(<"$d/temp1_input")
                    cpu_temp=$((temp_raw / 1000))
                    break
                fi
                ;;
            k10temp|zenpower)
                if [[ -f "$d/temp1_input" ]]; then
                    temp_raw=$(<"$d/temp1_input")
                    # offset 9°C je standard za vecinu Ryzen CPU-a
                    cpu_temp=$(( (temp_raw / 1000) - 4 ))
                    break
                fi
                ;;
        esac
    fi
done

# --- Output ---
echo "  ${cpu_usage}% |  ${cpu_temp}°C"
