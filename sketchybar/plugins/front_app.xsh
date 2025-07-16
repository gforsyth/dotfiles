#!/usr/bin/env xonsh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

$AEROSPACE_FOCUSED_MONITOR_NO=$(aerospace list-workspaces --focused).strip("\n").split("\n")[0]

$AEROSPACE_LIST_OF_WINDOWS_IN_FOCUSED_MONITOR=set(map(lambda x: x.split("|")[1].strip().lower(),$(aerospace list-windows --workspace $AEROSPACE_FOCUSED_MONITOR_NO).strip("\n").split("\n")))

ICONS = {
    "firefox": "",
}

if $SENDER == "front_app_switched":
    sketchybar --set $NAME label=$INFO
    sketchybar --set @("space." + $AEROSPACE_FOCUSED_MONITOR_NO) label=@(" | ".join($AEROSPACE_LIST_OF_WINDOWS_IN_FOCUSED_MONITOR))


#if [ "$SENDER" = "front_app_switched" ]; then
#  sketchybar --set "$NAME" label="$INFO"

#  source $HOME/.config/sketchybar/plugins/icon_map.sh
#  apps=$AEROSPACE_LIST_OF_WINDOWS_IN_FOCUSED_MONITOR
#  icon_strip=" "
#  if [ "${apps}" != "" ]; then
#    while read -r app
#    do
#      icon_strip+=" $(icon_map "$app")"
#    done <<< "${apps}"
#  else
#    icon_strip=" —"
#  fi
#  sketchybar --set space.$AEROSPACE_FOCUSED_MONITOR_NO label="$icon_strip"
#fi
