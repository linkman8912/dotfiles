#!/usr/bin/env fish

# this script will check if a file exists that will be set separately, and if so it will delete the file and turn off the main monitor, otherwise it should suspend the machine
# this is meant to be triggered on lid switch on, such that it can be used to keep a laptop on while it is clamshelled.

if nmcli device | grep Hotspot > /dev/null
  echo "hotspot connected"
  nmcli con down Hotspot
end
