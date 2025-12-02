# Make sure to call newest version of borg on rsync
$BORG_REMOTE_PATH="/usr/local/bin/borg1/borg1"

def _borglist():
    with ${...}.swap({"BORG_PASSPHRASE": $(rbw get rsyncnet --field key)}):
        borg list rsyncnet:backup

def _borginfo():
    with ${...}.swap({"BORG_PASSPHRASE": $(rbw get rsyncnet --field key)}):
        borg info rsyncnet:backup
    
aliases["borglist"] = _borglist
aliases["borginfo"] = _borginfo

aliases["borg"] = ["borg", "--remote-path=borg1"]

abbrevs["borgd"] = """with ${...}.swap({"BORG_PASSPHRASE": $(rbw get rsyncnet --field key)}):
    borg delete rsyncnet:backup """
