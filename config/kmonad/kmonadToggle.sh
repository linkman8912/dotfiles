#!/usr/bin/env fish
if test -e /proc/(pgrep kmonad)
  echo "killing kmonad"
  kill kmonad
else
  echo "starting kmonad"
  kmonad ~/.dotfiles/config/kmonad/kmonad.kbd & disown
end
echo "ok"
