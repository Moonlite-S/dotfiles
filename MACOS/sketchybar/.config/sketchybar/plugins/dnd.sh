#!/usr/bin/env bash

# Read the length of the active focus assertions array
DND_COUNT=$(jq '.data[0].storeAssertionRecords | length' ~/Library/DoNotDisturb/DB/Assertions.json)

if [ "$DND_COUNT" -gt 0 ]; then
  # DND or a Focus Mode is ON
  sketchybar --set "$NAME" icon= icon.drawing=on
else
  # DND is OFF
  sketchybar --set "$NAME" icon.drawing=off
fi
