import ast
import re
from functools import lru_cache

import xonsh.lazyasd as xl

__all__ = ()


@xl.lazyobject
def RE_PYTEST_TEST():
    return re.compile(r"(.*test_.+\.(?:py|xsh))::(.*)")


@lru_cache
def _parse_ast(fname: str) -> ast.Module:
    with open(fname, "r") as f:
        return ast.parse(f.read(), filename=fname)


def _scrape_test_names(fname: str) -> list[str]:
    tree = _parse_ast(fname)
    yield from (
        func.name
        for func in tree.body
        if isinstance(func, ast.FunctionDef) and func.name.startswith("test_")
    )


@contextual_completer
def _complete_pytest(context):
    if context.command.command == "pytest" and (
        fname := re.match(RE_PYTEST_TEST, context.command.prefix)
    ):
        fname, test_prefix = fname.groups()
        yield from {
            RichCompletion(f"{fname}::{match}", display=match)
            for match in _scrape_test_names(fname)
            if match.startswith(test_prefix)
        }


__xonsh__.completers["pytest"] = _complete_pytest
__xonsh__.completers.move_to_end("pytest", last=False)
