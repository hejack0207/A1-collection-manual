#!/usr/bin/env -S zsh -i

rfcnums=${1:-$(jq -r '.[]|.number' rfcs.json)}
for n in $rfcnums; do
	cate=$(jq -r ".[]|select( .number == $n )|.category" rfcs.json)
	title=$(jq -r ".[]|select( .number == $n )|.title" rfcs.json)
	cp ~codes/docs/rfc/rfc$n.txt ~rfc/$cate/rfc$n-$title.txt
done

