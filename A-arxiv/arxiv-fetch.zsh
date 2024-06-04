#!/usr/bin/env -S zsh -il

basedir=$(dirname ${0})
print -u 2 $basedir

id=${1:?id not specified}
category=${2:?category not specified}

title=$(arxiv-query.py -j $id | jq -r '.[0].title')
if [[ -z "$title" ]] then
	print -u 2 "title is empty, quit"
	return 1
fi

if [[ ! -d latex/$id ]]; then
	arxiv-fetch.py --target_dir=$basedir/latex/"$id $title" $id
else
	echo "latex/$id already exists"
fi


if ! grep -q "$id" $basedir/arxiv.tsv; then
	echo "$id\x0$category" >>$basedir/arxiv.tsv
else
	echo "$id already exists in arxiv.tsv"
fi

cat $basedir/arxiv.tsv | tail -n +2 | while read id subcategory; do
	if test -f $basedir/arxiv-archieved.tsv && grep -q $id $basedir/arxiv-archieved.tsv; then
		echo "$id $category already in arxiv-archieved.tsv"
		continue
	fi
	if arxiv-query.py -j $id | jyt -f json -t yaml | grep --color=never -v '^---$' >>$basedir/arxiv.yml; then
		print $id >> $basedir/arxiv-archieved.tsv
	fi
done
