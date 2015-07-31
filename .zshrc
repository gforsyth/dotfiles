source /home/gil/.dotfiles/antigen/antigen.zsh

antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle docker
antigen bundle pip
antigen bundle archlinux

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
#
# Load the theme.
antigen theme robbyrussell

# Tell antigen that you're done.
antigen apply

zstyle ':completion:*' menu select

alias grep="/usr/bin/grep $GREP_OPTIONS"
unset GREP_OPTIONS

alias fuck='eval $(thefuck $(fc -ln -1)); history -R'
alias FUCK='fuck'
# make feh always scale images to window size
alias feh='feh -.'

export PATH=$PATH:/home/gil/anaconda/bin
export EDITOR="vim"
export BROWSER="chromium"


export TERM=rxvt-unicode-256color

eval $(keychain --eval --agents ssh -Q --quiet id_ed25519)
keychain --agents ssh -Q --quiet ~/.ssh/id_rsa

source /usr/share/autoenv-git/activate.sh

source /usr/share/zsh/plugins/bd.zsh

