


def _borglist():
    with ${...}.swap({"BORG_PASSPHRASE": $(gopass show misc/rsyncnet).split()[0]}):
        borg list rsyncnet:backup
   
aliases["borglist"] = _borglist
