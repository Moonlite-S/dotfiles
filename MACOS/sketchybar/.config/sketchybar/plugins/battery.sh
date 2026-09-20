#!/bin/sh

HOT_PINK="0xffff8fa3"
SAKURA_PRIMARY="0xffffb7b2"
CONNECTED_BLUE="0xff7dc4e4"

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
9[0-9] | 100)
  ICON=""
  ;;
[6-8][0-9])
  ICON=""
  ;;
[3-5][0-9])
  ICON=""
  ;;
[1-2][0-9])
  ICON=""
  ;;
*) ICON="" ;;
esac

if [[ "$CHARGING" != "" ]]; then
  ICON=""
fi

if [ "$PERCENTAGE" -lt 20 ]; then
  COLOR="$HOT_PINK"
elif [ "$PERCENTAGE" -lt 80 ]; then
  COLOR="$SAKURA_PRIMARY"
else
  COLOR="$CONNECTED_BLUE"
fi

sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR"
