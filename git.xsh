import re
from pathlib import Path

from xonsh.built_ins import _change_working_directory

__all__ = ()

GIT_REGEX = re.compile('(?:com[/:])(.+)\/(.+)\.git')

def _clone_or_cd(args):
    url = args[0]

    match = re.findall(GIT_REGEX, url)
    if match:
        org, repo = match[0]
    else:
        org, repo = url.split('/')

    base = Path('~/github.com').expanduser()
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

def _list_repos():
    p = Path('~/github.com').expanduser()

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
