#!/bin/sh
HOSTNAME=$(hostname)

case $HOSTNAME in
    (theo) xrandr --output DVI-I-1 --auto --output DVI-I-2 --auto --left-of DVI-I-1;;
    (*) xrandr --output LVDS1 --auto --output HDMI1 --auto --left-of LVDS1;;
    esac

kill $(pgrep -f ".workspace.")
kill $(pidof dzen2)
/home/gil/.dotfiles/workspace.sh 1 &
/home/gil/.dotfiles/workspace.sh 0 &
/home/gil/.dotfiles/status.sh 1 &
/home/gil/.dotfiles/status.sh 0 &
