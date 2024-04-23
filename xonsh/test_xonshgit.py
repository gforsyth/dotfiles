import re
import sys

import pytest
from xonsh.execer import Execer
from xonsh.imphooks import XonshImportHook

sys.meta_path.append(XonshImportHook(Execer()))

import xonshgit


@pytest.mark.parametrize(
    "repo",
    [
        "https://github.com/gforsyth/pomegranate.git",
        "git@github.com:gforsyth/pomegranate.git",
        "https://github.com/gforsyth/pomegranate",
        "gforsyth/pomegranate",
        "gforsyth2/pomegranate",
        "gforsyth2/pomegranate2",
        "gforsyth/pomegranate2",
        "https://github.com/gforsyth/heisenbug.lol",
        "gforsyth/heisenbug.lol",
    ],
)
def test_match_repo_pattern(repo):
    assert re.findall(xonshgit.GIT_REGEX, repo)


@pytest.mark.parametrize(
    "repo, exp_len",
    [
        ("https://github.com/gforsyth/pomegranate.git", 3),
        ("git@github.com:gforsyth/pomegranate.git", 3),
        ("https://github.com/gforsyth/pomegranate", 3),
        ("gforsyth/pomegranate", 2),
        ("gforsyth2/pomegranate", 2),
        ("gforsyth2/pomegranate2", 2),
        ("gforsyth/pomegranate2", 2),
        ("gforsyth/heisenbug.lol", 2),
    ],
)
def test_match_repo_pattern_length(repo, exp_len):
    match = re.findall(xonshgit.GIT_REGEX, repo)
    assert isinstance(match, list)
    match_non_empty = [x for x in match[0] if x]
    assert len(match_non_empty) == exp_len
