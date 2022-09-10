#!/usr/bin/env zsh
# vim: sts=-1 sw=4 fdm=marker
# set -x

awkscript="$(pwd)/split-txt.awk"

if ! find rfcs -regextype awk -regex '.*/rfc[[:digit:]]+.*' -type d &>/dev/null; then
    while read f; do
	if [[ "$f" != *rfc0826* ]]; then
	    dir=$(dirname "$f")
	    subdir=$(basename "$f")
	    subdir=${subdir%*.txt}
	    mkdir "$dir/$subdir"
	    mv "$f" "$dir/$subdir"
	fi
    done <<<$(find "rfcs" -name '*.txt')
fi

if ! find | grep -q Abstract; then
    while read f; do
	if [[ "$f" != *rfc0826* ]]; then
	    dir=$(dirname "$f")
	    pushd "$dir"
	    awk -f "$awkscript" "$(basename ${(q)f})"
	    popd
	fi
    done <<<$(find rfcs -type f -name '*.txt')
fi

