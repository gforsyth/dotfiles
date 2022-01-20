# Make sure to call newest version of borg on rsync
$BORG_REMOTE_PATH="/usr/local/bin/borg1/borg1"

def _borglist():
    with ${...}.swap({"BORG_PASSPHRASE": $(gopass show misc/rsyncnet).split()[0]}):
        borg list rsyncnet:backup

aliases["borglist"] = _borglist

aliases["borg"] = ["borg", "--remote-path=borg1"]
