#!/usr/bin/env sh

#set OPACITY_MONITOR /tmp/hypropacityoff;
#set ACTIVE_OPACITY /tmp/hypractiveopacity;
#set INACTIVE_OPACITY /tmp/hyprinactiveopacity;

OPACITY_MONITOR=/tmp/hypropacityoff;
ACTIVE_OPACITY=/tmp/hypractiveopacity;
INACTIVE_OPACITY=/tmp/hyprinactiveopacity;

if test -e $OPACITY_MONITOR ; then
  echo "transgender for everyone";
  hyprctl keyword decoration:active_opacity $(cat $ACTIVE_OPACITY);
  hyprctl keyword decoration:inactive_opacity $(cat $INACTIVE_OPACITY);
  rm $OPACITY_MONITOR $ACTIVE_OPACITY $INACTIVE_OPACITY;
else
  echo "kill all trannies bill passed";
  touch $OPACITY_MONITOR;
  hyprctl getoption decoration:active_opacity | sed -e "s/float: //g" -e "s/set.*//g" > $ACTIVE_OPACITY;
  hyprctl getoption decoration:inactive_opacity | sed -e "s/float: //g" -e "s/set.*//g" > $INACTIVE_OPACITY;

  hyprctl keyword decoration:active_opacity 1;
  hyprctl keyword decoration:inactive_opacity 1;
fi
