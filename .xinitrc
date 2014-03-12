
#if [[ "$(xrandr | grep 'HDMI1 connected')" != ""]]; then
#    xrandr --output LVDS1 --auto --output HDMI1 --auto --left-of LVDS1
#fi


feh --bg-center "$(find ~/.backgrounds/|shuf -n1)" &
xbindkeys
xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr
/home/gil/.dotfiles/status.sh 0 &
/home/gil/.dotfiles/status.sh 1 &
/home/gil/.dotfiles/MultipleDropbox.sh &


exec $1

#case $1 in
#xfce4|*)
#    exec openbox-session
#    ;;
#esac
