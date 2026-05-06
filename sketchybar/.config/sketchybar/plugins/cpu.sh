#!/usr/bin/env bash

# Fetch CPU usage (reads 'top' twice because the first macOS reading is a historical average)
CPU_PERCENT="$(top -l 2 | grep -E "^CPU" | tail -1 | awk '{ printf "%.1f%%", $3 + $5 }')"

sketchybar --set $NAME label="$CPU_PERCENT"
