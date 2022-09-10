# vim: sts=-1 sw=4 fdm=marker

awkscript="$(pwd)/split-txt.awk"
while read f; do
    if [[ "$f" != *rfc0826* ]]; then
	dir=$(dirname "$f")
	subdir=$(basename "$f")
	subdir=${subdir%*.txt}
	mkdir "$dir/$subdir"
	pushd "$dir/$subdir"
	mv "$f" .
	awk -f "$awkscript" $(basename "$f")
	popd
	# echo ----------
	# awk -f "$awkscript" "$f"
    fi
done <<<$(find "rfcs" -name '*.txt')
