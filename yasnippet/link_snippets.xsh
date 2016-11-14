#!/usr/bin/env xonsh

import os
snippet_dir = `~/.emacs.d/elpa/yasnippet.*/snippets`[0]
cur_dir = $(pwd).strip()

for dir in `.*-mode`:
    ln -s @(os.path.join(cur_dir, dir)) @(os.path.join(snippet_dir, dir))

