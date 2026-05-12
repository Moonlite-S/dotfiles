#!/usr/bin/env bash

CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"
PLUGIN_DIR="$CONFIG_DIR/plugins"
MAX_ITEMS=8

APP=$(osascript -e 'tell application "System Events" to name of first application process whose frontmost is true' 2>/dev/null)
[ -z "$APP" ] && exit 0

MENU_NAMES=$(
  osascript 2>/dev/null <<OSASCRIPT
tell application "System Events"
  tell process "${APP}"
    set theMenus to menu bar items of menu bar 1
    set output to ""
    repeat with i from 3 to (count of theMenus)
      set output to output & (name of item i of theMenus) & linefeed
    end repeat
    return output
  end tell
end tell
OSASCRIPT
)

MENUS=()
while IFS= read -r line; do
  [[ -n "$line" && "$line" != *"::"* ]] && MENUS+=("$line")
done <<<"$MENU_NAMES"

for i in $(seq 1 $MAX_ITEMS); do
  idx=$((i - 1))
  MENU_NAME="${MENUS[$idx]:-}"
  if [ -n "$MENU_NAME" ]; then
    printf '%s' "$APP" >"/tmp/sketchybar_menu_app_${i}"
    printf '%s' "$MENU_NAME" >"/tmp/sketchybar_menu_name_${i}"
    sketchybar --set "menu_btn.$i" label="$MENU_NAME" drawing=on
  else
    sketchybar --set "menu_btn.$i" drawing=off
  fi
done
