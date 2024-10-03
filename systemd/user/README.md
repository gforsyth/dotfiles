# Local systemd services

These are all user-level services.

They should go in `~/.config/systemd/user/`

And are enabled and started with

``` sh
systemctl --user enable service.name
systemctl --user start service.name
```
