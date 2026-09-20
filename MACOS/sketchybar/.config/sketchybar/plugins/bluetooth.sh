#!/bin/sh

CONNECTED_BLUE="0xff7dc4e4"
DISCONNECTED_MUTED="0xffe2c3c6"

COUNT=$(system_profiler SPBluetoothDataType 2>/dev/null | awk '/Not Connected:/ {found=0; next} /Connected:/ {found=1; next} found && /Address:/ {c++} END {print c+0}')

if [ "$COUNT" -gt 0 ]; then
  sketchybar --set "$NAME" icon="󰂯" label.drawing=off icon.color="$CONNECTED_BLUE"
else
  sketchybar --set "$NAME" icon="󰂯" label.drawing=off icon.color="$DISCONNECTED_MUTED"
fi
