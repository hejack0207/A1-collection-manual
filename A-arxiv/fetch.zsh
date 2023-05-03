#!/usr/bin/env -S zsh -il

id=${1:?id not specified}
category=${2:?category not specified}

if [[ ! -d latex/$id ]]; then
	arxiv-sfetch.py --target_dir=latex $id
else
	echo "latex/$id already exists"
fi


if ! grep -q "$id" arxiv.tsv; then
	echo "$id\x0$category" >>arxiv.tsv 
else
	echo "$id already exists in arxiv.tsv"
fi

cat arxiv.tsv | tail -n +2 | while read id subcategory; do
	if test -f arxiv-archieved.tsv && grep -q $id arxiv-archieved.tsv; then
		echo "$id $category already in arxiv-archieved.tsv"
		continue
	fi
	if arxiv-query.py -j $id | jyt -f json -t yaml | grep --color=never -v '^---$' >>arxiv.yml; then
		print $id >> arxiv-archieved.tsv
	fi
done
