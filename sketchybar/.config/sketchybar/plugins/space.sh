#!/usr/bin/env bash

# This script runs every time you switch spaces.
# $SELECTED is a variable provided by SketchyBar (true/false).

if [ "$SELECTED" = "true" ]; then
  sketchybar --animate exp 20 \
    --set "$NAME" background.color=0x44ffb7b2 \
    background.drawing=on \
    icon.highlight=on \
    icon.padding_left=14 \
    icon.padding_right=14
else
  sketchybar --animate exp 20 \
    --set "$NAME" background.color=0x00ffb7b2 \
    background.drawing=off \
    icon.highlight=off \
    icon.padding_left=6 \
    icon.padding_right=6
fi
