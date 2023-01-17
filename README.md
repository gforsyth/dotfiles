# Arch install notes

9380 on Arch defaults to using `s2idle` instead of sleep for `suspend` so
powerdrain is massive.

Fix is to add `mem_sleep_default=deep` to kernel cmdline and regenerate grub config

# Yubikey card service

```
sudo systemctl enable pcscd.service
sudo systemctl start pcscd.service 
sudo systemctl status pcscd.service
```

# Public GPG Key
$KEYID = "0x34132A8E9B2A857F"
gpg --recv-keys $KEYID

# Switching Yubikeys

Need to delete contents of `$HOME/.gnupg/private-keys-v1.d/` that correspond to
keygrips of keys, then run `gpg --card-status` to associate with new hardware
key

# Stuff to install on machines (via mamba or nix)

* diskonaut
* i3_balance_workspace (this is on pypi)
* fzf
* carapace
* feh
* flameshot
* gopass
