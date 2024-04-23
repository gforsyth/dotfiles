import ast
from functools import lru_cache

__all__ = ()


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
        fname := context.command.prefix
    ).endswith(".py::"):
        yield from {
            RichCompletion(f"{fname}{match}", display=match)
            for match in _scrape_test_names(fname.strip(":"))
        }


__xonsh__.completers["pytest"] = _complete_pytest
__xonsh__.completers.move_to_end("pytest", last=False)
