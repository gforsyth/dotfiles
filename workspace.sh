#!/bin/sh

while true ; do
    python2 dzen-workspaces.py
    sleep 1
done | dzen2 -dock -x 850 -w 300 -fn '-*-clean-*-*-*-*-9-*-*-*-*-*-*-*' -xs "$1"
