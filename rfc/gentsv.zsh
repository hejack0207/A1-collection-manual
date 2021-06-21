#!/usr/bin/env -S zsh -i

truncate -s0 rfcs.tsv
./rfcnums.zsh | while read rfcn cate; do
	title=$(yq -r ".[] | select(((.number | type) ==\"string\" and .number == \"$rfcn\" ) or ((.number | type) == \"number\" and .number == $rfcn )) | .title" rfcs.yml)
	echo "${rfcn}\x00${cate}\x00${title}" >> rfcs.tsv
done
