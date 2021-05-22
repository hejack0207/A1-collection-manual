#!/usr/bin/env -S zsh -i

./rfcnums.zsh | while read rfcn cate; do
	title=$(yq -r ".[]|select( .number == $rfcn )|.title" rfcs.yml)
	echo $rfcn $cate $title
done

