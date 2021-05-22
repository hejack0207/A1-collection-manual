#!/usr/bin/env -S zsh
find . -regextype gnu-awk -regex '.*/rfc[[:digit:]]{4}.*' | sed -nre 's#\./(.*)/rfc([[:digit:]]{4}).*#\2\x00\1#p'
