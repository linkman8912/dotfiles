#!/usr/bin/env fish

# Set the command name (adjust as needed)
set CMD "kmonad"
set CMD_RUN "kmonad ~/.dotfiles/config/kmonad/kmonad.kbd"

# Check if the command is running
if pgrep -x $CMD > /dev/null
    echo "Process $CMD is running. Killing it..."
    pkill -x $CMD
else
    echo "Process $CMD not running. Starting it..."
    kmonad ~/.dotfiles/config/kmonad/kmonad.kbd &
end
