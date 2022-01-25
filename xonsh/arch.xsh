from copy import deepcopy
from contextlib import contextmanager

@contextmanager
def cleanpath():
    $OLDPATH = deepcopy($PATH)
    $PATH = ["/usr/bin", "/usr/local/bin", "/usr/bin/vendor_perl", "/usr/bin/core_perl"]
    yield
    $PATH = deepcopy($OLDPATH)
    del $OLDPATH

def _pikaur(args):
    with cleanpath():
        if args:
            /usr/bin/pikaur @([arg for arg in args])
        else:
            /usr/bin/pikaur

aliases['pikaur'] = _pikaur
