#!/usr/bin/env -S zsh -i

rfcnums=(${1:-$(jq -r '.[]|.number' rfcs.json)})
for n in $rfcnums; do
	cate=$(jq -r ".[]|select( .number == \"$n\" )|.category" rfcs.json)
	title=$(jq -r ".[]|select( .number == \"$n\" )|.title" rfcs.json)
	if ! test -f ~rfc/rfcs/$cate/rfc$n-$title.txt; then
		cp ~codes/docs/rfc/rfc$n.txt ~rfc/rfcs/$cate/rfc$n-$title.txt
	else
		echo ~rfc/rfcs/$cate/rfc$n-$title.txt already exists!
	fi
done

