#!/usr/bin/env xonsh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

$AEROSPACE_FOCUSED_MONITOR_NO=$(aerospace list-workspaces --focused).strip("\n").split("\n")[0]

_windows = $(aerospace list-windows --workspace $AEROSPACE_FOCUSED_MONITOR_NO)

if _windows:
    $AEROSPACE_LIST_OF_WINDOWS_IN_FOCUSED_MONITOR=set(map(lambda x: x.split("|")[1].strip().lower(), _windows.strip("\n").split("\n")))

    RENAMES = {
        "microsoft outlook": "outlook",
        "microsoft teams": "teams",
        "ghostty": "",
        "firefox": "",
    }

    $WINDOWS = list(map(lambda x: RENAMES.get(x, x), $AEROSPACE_LIST_OF_WINDOWS_IN_FOCUSED_MONITOR))

else:
    $WINDOWS = []

if $SENDER == "front_app_switched":
    sketchybar --set $NAME label=$INFO
    if $WINDOWS:
        sketchybar --set @("space." + $AEROSPACE_FOCUSED_MONITOR_NO) label=@($AEROSPACE_FOCUSED_MONITOR_NO + ": " + " | ".join($WINDOWS))

for i in range(1, 11):
    if not $(aerospace list-windows --workspace @(i)):
        sketchybar --set @(f"space.{i}") @(f"label={i}")
