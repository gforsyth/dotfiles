#!/bin/sh

MONITOR_OUTPUT=HDMI1
MODE=`xrandr | grep "$MONITOR_OUTPUT connected" -c`
if [ "$MODE" == '1' ]
then
    xrandr --output LVDS1 --auto --output HDMI1 --auto --left-of LVDS1
else
    xrandr --output LVDS1 --auto
fi
exit
