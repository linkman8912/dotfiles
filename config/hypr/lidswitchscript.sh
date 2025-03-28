#!/usr/bin/env fish

# this script will check if a file exists that will be set separately, and if so it will delete the file and turn off the main monitor, otherwise it should suspend the machine
# this is meant to be triggered on lid switch on, such that it can be used to keep a laptop on while it is clamshelled.

if cat ~/.lidswitchkeepson > /dev/null
  echo ".lidswitchkeepson exists"
  rm ~/.lidswitchkeepson
  # hyprctl keyword monitor "eDP-1, disable"
  if nmcli con show | grep Hotspot > /dev/null
    nmcli con up Hotspot
  else
    nmcli con add type wifi ifname wlp1s0 con-name Hotspot autoconnect yes ssid Hotspot
    nmcli con modify Hotspot 802-11-wireless.mode ap 802-11-wireless.band bg ipv4.method shared
    nmcli con modify Hotspot wifi-sec.key-mgmt wpa-psk
    nmcli con modify Hotspot wifi-sec.psk "hotspaht"
    nmcli con up Hotspot
  end
else
  systemctl suspend
end
