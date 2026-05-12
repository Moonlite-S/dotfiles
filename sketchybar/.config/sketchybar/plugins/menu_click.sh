#!/usr/bin/env bash

SLOT="${NAME##*.}"
APP=$(cat "/tmp/sketchybar_menu_app_${SLOT}" 2>/dev/null)
MENU=$(cat "/tmp/sketchybar_menu_name_${SLOT}" 2>/dev/null)

[ -z "$APP" ] || [ -z "$MENU" ] && exit 0

sketchybar --set menu_btn popup.drawing=off
osascript -e "tell application \"System Events\" to tell process \"${APP}\" to click menu bar item \"${MENU}\" of menu bar 1"
