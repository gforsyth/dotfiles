##Helper functions

def _lock_screen(args, stdin=None):
    scrot -o /tmp/screen.png
    convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
    i3lock -i /tmp/screen.png

def _mkcd(args, stdin=None):
    if len(args) == 1:
        mkdir -p @(args[0])
        cd @(args[0])
    else:
        return

def _sysz():
    with ${...}.swap({"SHELL": "/usr/bin/bash"}):
        sysz

# Need to reset $SHELL for sysz to work
aliases["sysz"] = _sysz

## Alias clear explicitly to avoid miniconda interference
aliases["clear"] = "/usr/bin/clear"

## For kitty only, add alias to display images in terminal
aliases["icat"] = "kitty +kitten icat"

##Aliases (yeah... no shit, kid)
aliases["mkcd"] = _mkcd
aliases["lock"] = _lock_screen
aliases["feh"] = "feh -. --conversion-timeout 1"
aliases["mkdir"] = "mkdir -p"
aliases["music"] = "mps"
aliases["dd"] = "dcfldd"
aliases["lookup"] = "/usr/bin/dict" #collision with Python dict
aliases["xo"] = "xdg-open"
aliases["htop"] = "btop"

## Rust utils
aliases["cat"] = "bat"
aliases["tree"] = "exa -T"

##dont go boom aliases
aliases["rm"] = "rm -I"

##advcp aliases for progress bars
#aliases["cp"] = "acp -g"
#aliases["mv"] = "amv -g"

##git aliases
aliases["gs"] = "git status" #collides with ghostscript but who cares?
aliases["ga"] = "git add"
aliases["gd"] = "git diff"
aliases["gch"] = "git checkout"
aliases["gc"] = "git commit -v"
