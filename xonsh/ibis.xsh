from xonsh.tools import EnvPath, is_env_path

class BackendPath(EnvPath):
    def __init__(self, args=None):
        if not args:
           self._l = []
        else:
            self._l = args.split(" ")

def backend_path_to_str(x):
    """De-type to space separated string of backends"""
    return " ".join(x)

def str_to_backend_path(x):
    """Implicitly split on string with BackendPath.__init__"""
    return BackendPath(x)

${...}.register("PYTEST_BACKENDS",
                convert=str_to_backend_path,
                detype=backend_path_to_str,
                validate=is_env_path,
                default=BackendPath())
