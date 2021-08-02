#!/usr/bin/env -S zsh -il
set -e

man=${1:?"usage: $0 man.1"}

if ! rpm -ql man-pages | egrep -q "/$man.gz$"; then
	echo "$man not in package man-pages"
	exit 1
fi

related=$(man $man | grep --color=never 'SEE ALSO' -A1 | tail -n1 | tr -d ' ')

if ! grep -q "^$man:" man-pages.groups; then
	echo "$man:$related" >>man-pages.groups
fi
