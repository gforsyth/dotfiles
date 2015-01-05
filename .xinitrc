
#if [[ "$(xrandr | grep 'HDMI1 connected')" != ""]]; then
#    xrandr --output LVDS1 --auto --output HDMI1 --auto --left-of LVDS1
#fi


feh --bg-center "$(find ~/.backgrounds/|shuf -n1)" &
xbindkeys
xrdb -merge ~/.Xresources
setxkbmap -option 'ctrl:nocaps'
xsetroot -cursor_name left_ptr
#xscreensaver -no-splash
/home/gil/.dotfiles/status.sh 0 &
/home/gil/.dotfiles/status.sh 1 &

/home/gil/.dotfiles/workspace.sh 0 &
/home/gil/.dotfiles/workspace.sh 1 &

( ( sleep 10 && /usr/bin/xscreensaver -no-splash -display :0.0 ) & )
xss-lock -- xscreensaver-command -lock &


export GTK_IM_MODULE='uim'
export QT_IM_MODULE='uim'
uim-xim &
export XMODIFIERS='@im=uim'

exec $1

#case $1 in
#xfce4|*)
#    exec openbox-session
#    ;;
#esac
