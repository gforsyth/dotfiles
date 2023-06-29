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

# Renewing subkeys

## mount backup and import master key
Turn off network, mount device with master keys

```
gpg --import /path/to/mastersub2021.key
```

## change expiry dates
set `$KEYID`, then 

```
gpg --expert --edit-key $KEYID
```

Run, in sequence
```
key 1
key 2
key 3
```

to select all subkeys, then type `expire` (won't expire things) to change expiry date.

then type `save` and exit.

## export 
Now export the new public key

```
gpg --armor --export $KEYID > gpg-$KEYID-date.asc
```

## unmount drive and nuke private key

```
gpg --delete-secret-key $KEYID
```

and then on in-use-machines

```
gpg --import gpg-$KEYID-date.asc
```
and trust

```
gpg --edit-key $KEYID
```

```
> trust
> 5
```

then `gpg --card-status` to confirm yubikey is working.



# Stuff to install on machines (via mamba or nix)

* diskonaut
* i3_balance_workspace (this is on pypi)
* fzf
* carapace
* feh
* flameshot
* gopass
