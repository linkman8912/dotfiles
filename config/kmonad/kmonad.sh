#!/usr/bin/env bash

KBD_DEV=$(find /dev/input/by-path/*kbd* | fzf)
export KBD_DEV
# KBDCFG=$(envsubst < /home/linkman/.dotfiles/config/kmonad.kbd)

kmonad /home/linkman/.dotfiles/config/kmonad.kbd #<(echo "$KBDCFG")
