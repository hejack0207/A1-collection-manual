#!/usr/bin/env -S zsh

if test -f rfcnums.tsv; then
	cat rfcnums.tsv
else
	find . -regextype gnu-awk -regex '.*/rfc[[:digit:]]{4}.*' | sed -nre 's#\./(.*)/rfc([[:digit:]]{4}).*#\2\x00\1#p'
fi
