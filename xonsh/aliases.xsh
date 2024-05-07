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
aliases["htop"] = "btop"

# always send xclip stuff to the system clipboard
aliases["xclip"] = ["xclip", "-sel", "clip"]

## conveniences
aliases["bd"] = "cd .."
aliases["bd.."] = "bd and bd"
aliases["bd..."] = "bd and bd and bd"
aliases["bd...."] = "bd.. and bd.."

## sudo
if !(which doas):
    aliases["sudo"] = "doas"
    aliases["sudoedit"] = "doas vim"


## Rust utils
aliases["cat"] = "bat"
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
aliases["gco"] = "git checkout"
aliases["grc"] = "git rebase --continue"
aliases["gpf"] = "git push --force-with-lease"
aliases["gpF"] = "git push --force"
abbrevs["gcp"] = "git cherry-pick "
aliases["gcm"] = "git checkout main"
aliases["grm"] = "git rebase main"
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
# nix
abbrevs["npi"] = "nix profile install 'nixpkgs#<edit>'"
abbrevs["npl"] = "nix profile list"
abbrevs["npr"] = "nix profile remove <edit>"
abbrevs["nixb"] = "nix build \"<edit>\" --fallback --keep-going --print-build-logs"
# gh
abbrevs["prc"] = "gh pr checkout <edit>"
# nmcli
abbrevs["list_wireless"] = "nmcli device wifi0 list"
abbrevs["new_wireless"] = "nmcli device wifi0 connect <edit> "
# vlcsharescreen
abbrevs["vlcshare"] = "cvlc --no-video-deco --no-embedded-video --screen-fps=15 --screen-left=0 --screen-width=1920 --screen-height=1080 screen://"

#pyarrow funtimes
abbrevs["arrowcmake"] = r"""cmake -DCMAKE_INSTALL_PREFIX=$ARROW_HOME \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DCMAKE_BUILD_TYPE=Debug \
      -DARROW_BUILD_TESTS=ON \
      -DARROW_COMPUTE=ON \
      -DARROW_CSV=ON \
      -DARROW_DATASET=ON \
      -DARROW_FILESYSTEM=ON \
      -DARROW_HDFS=ON \
      -DARROW_JSON=ON \
      -DARROW_PARQUET=ON \
      -DARROW_WITH_BROTLI=ON \
      -DARROW_WITH_BZ2=ON \
      -DARROW_WITH_LZ4=ON \
      -DARROW_WITH_SNAPPY=ON \
      -DARROW_WITH_ZLIB=ON \
      -DARROW_WITH_ZSTD=ON \
      -DPARQUET_REQUIRE_ENCRYPTION=ON \
      <edit>
      ..
"""

# bangbang
abbrevs['!!'] = lambda buffer, word: __xonsh__.history[-1].cmd

#druid is terrible
abbrevs["nodruid"] = "docker compose stop druid-broker druid-coordinator druid-historical druid-middlemanager druid-zookeeper druid druid-postgres"

def _validate_substrait_yaml(args):
    ajv validate -s text/simple_extensions_schema.yaml --strict=true --spec=draft2020 -d @(args[0])

aliases["validate"] = _validate_substrait_yaml

aliases["pa"] = "gopass ls --flat | rofi -dmenu | xargs --no-run-if-empty gopass show -c"

aliases["set_snowflake"] = _set_snowflake

def _kill_theseus():
    nvidia-smi | grep theseus | tr -s " " | cut -f5 -d " " | xargs kill

aliases["kill_theseus"] = _kill_theseus
