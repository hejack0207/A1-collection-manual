#!/usr/bin/env zsh
# vim: sts=-1 sw=4 fdm=marker
# set -x

awkscript="$(pwd)/split-txt.awk"

while read f; do
    if [[ "$f" != *rfc0826* && "$f" != *rfc2136* ]]; then
	dir=$(dirname "$f")
	subdir=$(basename "$f")
	subdir=${subdir%*.txt}
	if ! test -e "$dir/$subdir"; then
	    mkdir "$dir/$subdir"
	    cp "$f" "$dir/$subdir"
	fi
    fi
done <<<$(find "rfcs" -maxdepth 2 -name '*.txt')

while read f; do
    if [[ "$f" != *rfc0826* && "$f" != *rfc2136* ]]; then
	dir=$(dirname "$f")
	pushd "$dir"
	fn=$(basename ${f})
	awk -f "$awkscript" "$fn"
	popd
	rm "$f"
    fi
done <<<$(find rfcs -mindepth 3 -type f -regextype awk -regex '.*/[^[:digit:]]+[^/]*\.txt')
