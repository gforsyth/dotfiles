
#if [[ "$(xrandr | grep 'HDMI1 connected')" != ""]]; then
#    xrandr --output LVDS1 --auto --output HDMI1 --auto --left-of LVDS1
#fi

#background shuffler
feh --bg-center "$(find ~/.backgrounds/|shuf -n1)" &
#can't remember...
xbindkeys
#merge in style
xrdb -merge ~/.Xresources
#remap capslock to extra ctrl
setxkbmap -option 'ctrl:nocaps'
#fix cursor pointing wrong way
xsetroot -cursor_name left_ptr

#setup status bars on top of screen
/home/gil/.dotfiles/status.sh 0 &
/home/gil/.dotfiles/workspace.sh 0 &

#start up screensaver demon (should probably change this)
( ( sleep 10 && /usr/bin/xscreensaver -no-splash -display :0.0 ) & )
xss-lock -- xscreensaver-command -lock &

#configure uim for japanese input
export GTK_IM_MODULE='uim'
export QT_IM_MODULE='uim'
uim-xim &
export XMODIFIERS='@im=uim'

#launch wingo
exec wingo 

#case $1 in
#xfce4|*)
#    exec openbox-session
#    ;;
#esac
