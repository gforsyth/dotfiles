#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

##################################################
               # prompt settings
##################################################
green='\e[0;32m'
GREEN='\e[0;32m'
red='\e[0;31m'
RED='\e[1;31m'
blue='\e[0;34m'
BLUE='\e[1;34m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
NC='\e[0m'

[ -n "$SSH_CLIENT" ] && ps1_informer=" ${BLUE}[ssh]${NC}"

if [ $(id -u) -eq 0 ];
then
  PS1="┌${RED}[\u]${NC} [\h]$ps1_informer:\[\e[0;32;49m\]\w\[\e[0m \n└>"
else
  PS1="┌[${GREEN}\u${NC}] [\h]$ps1_informer:\[\e[0;32;49m\]\w\[\e[0m \n└>"
fi
##################################################
##################################################


##################################################
               # aliases
##################################################
alias ls='ls --color=auto'
alias lock='xscreensaver-command -lock'
alias bd=". bd -s"
alias winesteam="wine ~/.wine/drive_c/Program\ Files\ \(x86\)/Steam/Steam.exe -no-dwrite"
##################################################
##################################################

export BROWSER="/usr/bin/chromium"

#export PATH=$PATH:/home/gil/.gem/ruby/2.1.0/bin
#export CPATH=/usr/include/libusb-1.0/:/usr/local/include/aiousb
#export AIOUSBLIBDIR=/usr/local/lib

##################################################
             # pretty ls colors
##################################################
LS_COLORS='rs=0:di=00;34:ln=00;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=00;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;33:*.au=00;33:*.flac=00;33:*.mid=00;33:*.midi=00;33:*.mka=00;33:*.mp3=00;33:*.mpc=00;33:*.ogg=00;33:*.ra=00;33:*.wav=00;33:*.axa=00;33:*.oga=00;33:*.spx=00;33:*.xspf=00;33:';
export LS_COLORS
