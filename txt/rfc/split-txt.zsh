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

if ! find rfcs | grep -q Abstract; then
    while read f; do
	if [[ "$f" != *rfc0826* ]]; then
	    dir=$(dirname "$f")
	    pushd "$dir"
	    fn=$(basename ${f})
	    awk -f "$awkscript" "$fn"
	    # test -f "$fn" || { echo "$fn not exists"; echo * }
	    popd
	fi
    done <<<$(find rfcs -type f -name '*.txt')
fi

while read f; do
    if [[ "$f" != *rfc0826* ]]; then
	print "$f"
    fi
done <<<$(find rfcs -regextype awk -regex '^[^[:digit:]]+*.txt')
