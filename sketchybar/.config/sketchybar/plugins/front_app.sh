#!/usr/bin/env bash

# Fetch the active window details from Yabai
WINDOW_INFO=$(yabai -m query --windows --window 2>/dev/null)

# If no window is focused (e.g., clicking the empty desktop), clear the label
if [ -z "$WINDOW_INFO" ]; then
  sketchybar --set $NAME label=""
  exit 0
fi

# Extract the app name and window title using jq
APP_NAME=$(echo "$WINDOW_INFO" | jq -r '.app')
WINDOW_TITLE=$(echo "$WINDOW_INFO" | jq -r '.title')

# Truncate extremely long window titles so they don't eat your entire top bar
if [ ${#WINDOW_TITLE} -gt 50 ]; then
  WINDOW_TITLE="${WINDOW_TITLE:0:50}..."
fi

# Format the output
# If the title is empty or exactly the same as the app name, just show the app name
if [ "$APP_NAME" == "$WINDOW_TITLE" ] || [ -z "$WINDOW_TITLE" ]; then
  FINAL_LABEL="$APP_NAME"
else
  FINAL_LABEL="$APP_NAME :: $WINDOW_TITLE"
fi

sketchybar --set $NAME label="$FINAL_LABEL"
