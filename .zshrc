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

eval $(keychain --eval --agents ssh -Q --quiet id_ed25519)
eval $(keychain --eval --agents ssh -Q --quiet id_rsa)
