# From https://github.com/drduh/YubiKey-Guide#ssh
$GPG_TTY = $(tty).strip("\n")
$SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket).strip("\n")
_ = $(gpg-connect-agent updatestartuptty /bye)

def export_gpg_ssh():
    """Export the current yubikey signing key as an SSH rsa public key"""
    print($(ssh-add -L))
