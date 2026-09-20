#!/bin/bash

VPN_IFACE=$(scutil --nc list | grep Connected | sed -E 's/.*"(.*)".*/\1/')
NORDVPN=$(route get default 2>/dev/null | grep "interface: utun")

if [[ -n "$NORDVPN" ]]; then
  sketchybar -m --set vpn icon=󰒘 drawing=on
elif [[ -n "$VPN_IFACE" ]]; then
  sketchybar -m --set vpn icon=󰚊 drawing=on
else
  sketchybar -m --set vpn icon= drawing=on
fi
