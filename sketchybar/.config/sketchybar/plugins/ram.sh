#!/usr/bin/env bash

# Fetch memory pressure and invert it to get usage percentage
RAM_PERCENT="$(memory_pressure | grep "System-wide memory free percentage:" | awk '{ printf("%02.0f%%\n", 100-$5) }')"

sketchybar --set $NAME label="$RAM_PERCENT"
