#!/usr/bin/env xonsh
import os

snippet_dir = `~/.emacs.d/elpa/yasnippet.*/snippets`[0]

for dir in `yasnippet/.*`:
    ln -s @(dir) @(os.path.join(snippet_dir, dir.rsplit('/')[-1]))
