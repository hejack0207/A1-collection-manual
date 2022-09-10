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
	    test -e "$dir/$subdir" || mkdir "$dir/$subdir"
	    cp "$f" "$dir/$subdir"
	fi
    done <<<$(find "rfcs" -maxdepth 2 -name '*.txt')
fi

if ! find rfcs | grep -q Abstract; then
    while read f; do
	if [[ "$f" != *rfc0826* ]]; then
	    dir=$(dirname "$f")
	    pushd "$dir"
	    fn=$(basename ${f})
	    awk -f "$awkscript" "$fn"
	    rm "$f"
	    popd
	fi
    done <<<$(find rfcs -mindepth 3 -type f -regextype awk -regex '.*/[^[:digit:]]+[^/]*\.txt')
fi
