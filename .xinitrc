#background shuffler
feh --bg-center "$(find ~/.backgrounds/|shuf -n1)" &
#merge in style
xrdb -merge ~/.Xresources
#remap capslock to extra ctrl
setxkbmap -option 'ctrl:nocaps'
#fix cursor pointing wrong way
xsetroot -cursor_name left_ptr

#start dropbox
dropbox-cli start

#synchronizes copy/paste buffers used by X applications
autocutsel -fork &
autocutsel -selection PRIMARY -fork &

#launch i3
exec i3 
