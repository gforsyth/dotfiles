##Helper functions
xontrib load abbrevs

from tqdm import tqdm as _tqdm

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

def _ver(args, stdin=None):
    """Helper for grabbing version of python library in local env"""
    pkg, *_ = args
    python -c @(f"import {pkg}; print({pkg}.__version__)")

def _loc(args, stdin=None):
    """Helper for grabbing file location of python library in local env"""
    pkg, *_ = args
    python -c @(f"import {pkg}; print({pkg}.__file__)")


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
if ![which btop all> /dev/null]:
    aliases["htop"] = "btop"

# always send xclip stuff to the system clipboard
aliases["xclip"] = ["xclip", "-sel", "clip"]

## conveniences
aliases["bd"] = "cd .."
aliases["bd.."] = "bd and bd"
aliases["bd..."] = "bd and bd and bd"
aliases["bd...."] = "bd.. and bd.."

## Rust utils
if ![which bat all> /dev/null]:
    aliases["cat"] = "bat"
if ![which exa all> /dev/null]:
    aliases["tree"] = "exa -T"
    aliases["ls"] = "exa"

##dont go boom aliases
aliases["rm"] = "rm -I"

##advcp aliases for progress bars
#aliases["cp"] = "acp -g"
#aliases["mv"] = "amv -g"

##git aliases
aliases["gs"] = "git status" #collides with ghostscript but who cares?
aliases["ga"] = "git add"
aliases["gd"] = "git diff"
aliases["gc"] = "git checkout"
aliases["grc"] = "git rebase --continue"
aliases["gpf"] = "git push --force-with-lease"
aliases["gpF"] = "git push --force"
abbrevs["gcp"] = "git cherry-pick "
aliases["gdf"] = "git difftool"  # difftastic diffs

def _get_default_branch(remote="upstream"):
    try:
        remote = $(git remote show @(remote) | grep "HEAD branch").strip().rsplit(": ")[1]
        return remote
    except:
        return "main"

def _pull_default():
    remotes = $(git remote show).strip().split()
    if "upstream" in remotes:
        git pull upstream @(_get_default_branch())
    elif "origin" in remotes:
        git pull origin @(_get_default_branch(remote="origin"))
    else:
        raise ValueError("bad remote")

def _checkout_default():
    git checkout @(_get_default_branch())

def _rebase_default():
    git rebase @(_get_default_branch()) -S

def _update_and_rebase():
    gcm and gpm and git checkout - and grm

aliases["gcm"] = _checkout_default
aliases["grm"] = _rebase_default
aliases["gpm"] = _pull_default
aliases["guar"] = _update_and_rebase

#python
aliases["pip"] = "python -m pip"
aliases["ver"] = _ver
aliases["loc"] = _loc

abbrevs["pipu"] = "pip list | fzf --multi --reverse | xargs pip uninstall -y"

def _calibre():
    with cleanpath():
        /usr/bin/calibre

aliases["calibre"] = _calibre
# conda/mamba/pip
abbrevs["ca"] = "conda activate"
abbrevs["pipi"] = "pip install '<edit>[]'"
# apt
abbrevs["sagi"] = "sudo apt install"
abbrevs["sagr"] = "sudo apt remove"
abbrevs["acs"] = "apt-cache search"
# pacman
abbrevs["spi"] = "sudo pacman -Sy"
# nix
abbrevs["npi"] = "nix profile install 'nixpkgs#<edit>'"
abbrevs["npl"] = "nix profile list"
abbrevs["npr"] = "nix profile remove <edit>"
abbrevs["nixb"] = "nix build \"<edit>\" --fallback --keep-going --print-build-logs"
# gh
abbrevs["prc"] = "gh pr checkout <edit>"
# vlcsharescreen
abbrevs["vlcshare"] = "cvlc --no-video-deco --no-embedded-video --screen-fps=15 --screen-left=0 --screen-width=1920 --screen-height=1080 screen://"

# bangbang
abbrevs['!!'] = lambda buffer, word: __xonsh__.history[-1].cmd

# check wheel size downloading only headers
abbrevs["wheelsize"] = "curl -sI <edit> | grep -i Content-Length"

# github action watcher
abbrevs["runs"] = """with ${...}.swap({'GITHUB_AUTH': $(gh auth token)}):
    watch_gha_runs --sha $(git rev-parse HEAD)
"""
