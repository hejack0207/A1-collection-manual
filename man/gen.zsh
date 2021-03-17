#!/usr/bin/zsh -li
set -e

manname=${1:?manual name not specified}
zcat $(man -w $manname) >groff/$manname
man_dump $manname >txt/$manname.txt
MANWIDTH=40 zcat $(man -w $manname) | awk '/^.TH.*/ || p { p = 1; print }' | man-to-md.pl >md/$manname.md
