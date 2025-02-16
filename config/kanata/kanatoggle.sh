#!/usr/bin/env fish

# Set the command name (adjust as needed)
set CMD "kanata"

# Check if the command is running
if pgrep -x $CMD > /dev/null
    echo "Process $CMD is running. Killing it..."
    pkill -x $CMD
else
    echo "Process $CMD not running. Starting it..."
    kanata --nodelay &
end
