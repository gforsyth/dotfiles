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
aliases["gc"] = "git commit -v"

def _get_default_branch(remote="upstream"):
    return $(git remote show @(remote) | grep "HEAD branch").strip().rsplit(": ")[1]

def _pull_default():
    git pull upstream @(_get_default_branch())

def _checkout_default():
    git checkout @(_get_default_branch())

aliases["gpu"] = _pull_default
aliases["gcm"] = _checkout_default

#python
aliases["pip"] = "python -m pip"
aliases["ver"] = _ver
aliases["loc"] = _loc

#mtg
aliases["mtg"] = ["wine",  "/home/gil/.wine/drive_c/Program Files/Wizards of the Coast/MTGA/MTGA.exe"]

def _calibre():
    with cleanpath():
        /usr/bin/calibre

aliases["calibre"] = _calibre
# conda/mamba
abbrevs["ca"] = "conda activate"

def _mark_gh_notifications_read():
    # grabs threads that start with `chore(deps` or `chore(conda`
    threads = $(gh api --paginate notifications --jq r'.[] | "\(.id) \(.subject.title)"' | grep -E r"chore\(deps|chore\(conda" | cut -d " " -f1).strip().split()
    # marks them read
    print(f"Marking {len(threads)} threads as read...")
    for thread in _tqdm(threads):
        gh api --method PATCH -H "Accept: application/vnd.github.v3+json" /notifications/threads/@(thread)
    
aliases["mark_gh_read"] = _mark_gh_notifications_read

def _mark_merged_prs():
    _capture = $(gh api --paginate notifications --jq r'.[] | select(.subject.type=="PullRequest") | "\(.id) \(.subject.url)"').strip().split()
    ids = _capture[::2]
    prs = _capture[1::2]
    merged = []
    print(f"Grabbing status of {len(prs)} PRs...")
    for id, pr in _tqdm(zip(ids, prs)):
        if !(gh api -H "Accept: application/vnd.github+json" @(f"{pr.strip('https://api.github.com')}/merge")):
            merged.append(id)
    print(f"Marking {len(merged)} PRs as read...")
    for thread in _tqdm(merged):
        gh api --method PATCH -H "Accept: application/vnd.github.v3+json" /notifications/threads/@(thread)

aliases["mark_merged_prs_read"] = _mark_merged_prs

# grabs PRs where the user that opened it is a Bot
# gh api --paginate notifications --jq r'.[] | select(.subject.title | contains("deps")) | .subject.url' | cut -d "/" -f4- | xargs gh api --jq r'select(.user.type == "Bot") | .id'

def _validate_substrait_yaml(args):
    ajv validate -s text/simple_extensions_schema.yaml --strict=true --spec=draft2020 -d @(args[0])

aliases["validate"] = _validate_substrait_yaml
