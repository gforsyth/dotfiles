#!/bin/sh

SEP="  "
ICONPATH="$HOME/.dzen2/icons"

myVol(){
    PERCENT=`amixer get Master | grep dB | awk '{print $4}'`
    MUTED=`amixer get Master | grep dB | awk '{print $6}'`
    MUTEICON="^fg(white) ^i($ICONPATH/mute.xbm)"
    VOLICON="^fg(white) ^i($ICONPATH/spkr_01.xbm)"
    if [ "$MUTED" = "[off]" ]; then
        echo "$MUTEICON || "
    else
        echo "$VOLICON $PERCENT || "
    fi
}

myBat(){
    bat_text="$(acpi -b)"
    if acpi -b | grep -q Charging; then
        bat_icon="^fg(white) ^i($ICONPATH/ac_01.xbm)"
    else
        bat_icon="^fg(white) ^i($ICONPATH/bat_full_01.xbm)"
    fi


    if echo $bat_text | grep -q remaining || echo $bat_text | grep -q 'until charged'; then
        bat_text="$(echo $bat_text | sed -rn 's/.* ([0-9]+%), ([0-9]{2}:[0-9]{2}).*/\1 (\2)/p')"
    elif echo $bat_text | grep -q unavailable; then
        bat_text="$(echo $bat_text | sed -rn 's/.* ([0-9]+%), .*/\1 (unknown)/p')"
    else 
        bat_text='100% (Full)'
    fi
    
    echo "$bat_icon $bat_text || "
}

myWireless(){
    ESSID=`iwconfig wlan0 | grep ESSID | cut -d '"' -f 2`
    MYIP=$(ip addr show wlan0 | grep global | awk '{print $2}' | cut -d '/' -f 1)
    echo "$ESSID || "
}

myDistro(){
    ARCH="^fg(white) ^i($ICONPATH/arch.xbm)"
    UNAME=`uname -a | awk '{print $3}'`

        echo "$ARCH $UNAME || "
}

myDate(){
    MYDATE=`date | awk '{print $2,  $3",", $6,"||", $1, $4}'`
    echo "$MYDATE || "
}

while true ; do
    echo "$(myDistro)$(myDate)$(myWireless)$(myVol)$(myBat)"
    sleep 1
done | dzen2 -dock -x 750 -w 600 -fn '-*-clean-*-*-*-*-9-*-*-*-*-*-*-*' -xs "$1"
