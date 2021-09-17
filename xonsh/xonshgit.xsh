import re
from pathlib import Path

from xonsh.dirstack import _change_working_directory

__all__ = ()

GIT_REGEX = re.compile("(github.com)?[/|:]?([A-Za-z-_0-9]+)/([A-Za-z-_0-9]+)")

def _clone_or_cd(args):
    url = args[0]

    match = re.findall(GIT_REGEX, url)
    base, org, repo = match[0]

    home = p"~".expanduser()

    if base:
        base = home / base
        org = base / org
        repo = org / repo

        if repo.exists():
            _change_working_directory(repo.__str__())
        elif org.exists():
            _change_working_directory(org.__str__())
            ![git clone @(url)]
            _change_working_directory(repo.__str__())
        elif base.exists():
            _change_working_directory(base.__str__())
            ![mkdir @(org.name)]
            _change_working_directory(org.__str__())
            ![git clone @(url)]
            _change_working_directory(repo.__str__())
    else:
        ghrepo = home / "github.com" / org / repo
        _change_working_directory(ghrepo)


def _list_repos():
    p = p"~/github.com".expanduser()

    return ['/'.join(repo.parts[-2:]) for repo in p.glob('*/*') if repo.is_dir()]


def _complete_git(prefix, line, start, end, ctx):
    args = line.split(" ")
    if len(args) == 0 or args[0] != "g":
        return None
    elif len(args) == 2:
        possible = set([match for match in _list_repos() if match.startswith(args[1])])
    else:
        possible = _list_repos()

    return possible


aliases['g'] = _clone_or_cd

__xonsh__.completers["githelp"] = _complete_git
__xonsh__.completers.move_to_end("githelp", last=False)
