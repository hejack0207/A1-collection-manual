#!/usr/bin/zsh

f=$1
grep --color=never -e '^[[:digit:]]\+\. ' -e '^[[:space:]]\{3\}[[:digit:]]\+\.[[:digit:]]\+ ' -e '^[[:space:]]\{6\}[[:digit:]]\+\.[[:digit:]]\+\.[[:digit:]]\+ ' $f
