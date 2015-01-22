#!/bin/sh

xrandr --output LVDS1 --auto --output HDMI1 --auto --left-of LVDS1
kill $(pgrep -f ".workspaces.")
kill $(pidof dzen2)
/home/gil/.dotfiles/workspace.sh 1 &
/home/gil/.dotfiles/workspace.sh 0 &
/home/gil/.dotfiles/status.sh 1 &
/home/gil/.dotfiles/status.sh 0 &
