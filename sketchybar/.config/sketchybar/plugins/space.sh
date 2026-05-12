#!/usr/bin/env bash

SELECTED_COLOR="0x44ffb7b2"
HOVER_COLOR="0x22ffb7b2"

case "$SENDER" in
space_change)
  if [ "$SELECTED" = "true" ]; then
    sketchybar --animate exp 20 \
      --set "$NAME" background.color=$SELECTED_COLOR \
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
  ;;
mouse.entered)
  [ "$SELECTED" = "true" ] && exit 0
  sketchybar --animate exp 10 \
    --set "$NAME" background.color=$HOVER_COLOR \
    background.drawing=on
  ;;
mouse.exited)
  [ "$SELECTED" = "true" ] && exit 0
  sketchybar --animate exp 10 \
    --set "$NAME" background.color=0x00ffb7b2 \
    background.drawing=off
  ;;
esac
