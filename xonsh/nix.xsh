$PATH.insert(1, "/nix/var/nix/profiles/default/bin")
$PATH.insert(1, "$HOME/.nix-profile/bin")

xontrib load direnv
$DIRENV_LOG_FORMAT=""  # reduce direnv verbosity

# Nix needs these things to find packages

$NIX_PATH=["nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixpkgs",
           "/nix/var/nix/profiles/per-user/root/channels",
           "ssh-config-file=/home/gil/.ssh/",
          ]

# Nix tries to manage LOCALE itself unless you tell it not to

$LOCALE_ARCHIVE="/usr/lib/locale/locale-archive"

# Inject `nix` into env_name as appropriate

from xonsh.prompt.env import env_name

def nix_env_name():
    if "IN_NIX_SHELL" in ${...}:
        return "(nix) "
    else:
        return env_name()

$PROMPT_FIELDS["env_name"] = nix_env_name

aliases["nix-fmt"] = "nixpkgs-fmt"

$NIXPKGS_ALLOW_UNFREE=1

# Force xonsh to use system bash to load completions so that bash completion
# doesn't break inside of nix environments

$XONSH_BASH_PATH_OVERRIDE = p"/usr/bin/bash"
