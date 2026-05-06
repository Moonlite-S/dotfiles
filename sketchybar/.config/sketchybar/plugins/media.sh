#!/usr/bin/env bash

STATE=$(nowplaying-cli get playbackRate 2>/dev/null)

if [ "$STATE" = "1" ] || [ "$STATE" = "1.0" ]; then
  TITLE=$(nowplaying-cli get title 2>/dev/null)
  ARTIST=$(nowplaying-cli get artist 2>/dev/null)

  if [ -z "$ARTIST" ] || [ "$ARTIST" = "null" ]; then
    FINAL_LABEL="$TITLE"
  else
    FINAL_LABEL="$TITLE - $ARTIST"
  fi

  # Show media module, and strip the padding from the CPU so they sit nicely together
  sketchybar --set $NAME label="$FINAL_LABEL" drawing=on \
    --set cpu padding_left=0
else
  # Hide the media module, and hand the 12px padding back to the CPU
  sketchybar --set $NAME drawing=off \
    --set cpu padding_left=12
fi
