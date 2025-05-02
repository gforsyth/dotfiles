import itertools
import os
import re
from pathlib import Path

from xonsh.dirstack import _change_working_directory
from xonsh.completers.tools import *

__all__ = ()

_FORGES = ["github.com"]
if "FORGE" in ${...}:
    _FORGES.append($FORGE)

_forge_str = "|".join(_FORGES)

_GIT_REGEX = re.compile(rf"({_forge_str})?[/|:]?([A-Za-z-_0-9]+)/([A-Za-z-_0-9\.]+)?")

def _clone_or_cd(args):
    home = p"~".expanduser()

    if not args:
        _change_working_directory(home / "github.com")
        return

    url = args[0]
    match = re.findall(_GIT_REGEX, url)
    base, org, repo = map(str.lower, match[0])
    repo = repo.removesuffix(".git")

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
        for forge in _FORGES:
            if (ghrepo := home / forge / org / repo).exists():
                _change_working_directory(ghrepo)


def _list_repos():
    superglob = itertools.chain.from_iterable([pf"~/{forge}".expanduser().glob("*/*") for forge in _FORGES])
    yield from ('/'.join(repo.parts[-2:]) for repo in superglob if repo.is_dir() and not any(f.startswith(".") for f in repo.parts[-2:]))


@contextual_completer
def _complete_git(context):
    if (context.command.args and context.command.args[0].value == "g" and context.command.arg_index == 1):
        if context.command.prefix:
            yield from {RichCompletion(match, description="hi") for match in _list_repos()
                        if match.startswith(context.command.prefix)}
        else:
            yield from {RichCompletion(repo) for repo in _list_repos()}


aliases['g'] = _clone_or_cd

__xonsh__.completers["githelp"] = _complete_git
__xonsh__.completers.move_to_end("githelp", last=False)
