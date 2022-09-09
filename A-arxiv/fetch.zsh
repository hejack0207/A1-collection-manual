#!/usr/bin/env -S zsh -il

cat arxiv.tsv | tail -n +2 | while read id subcategory; do
	echo $id $category
	if test -f arxiv-archieved.tsv && grep -q $id arxiv-archieved.tsv; then
		echo skipped
		continue
	fi
	if arxiv-query.py -j $id | jyt -f json -t yaml | grep --color=never -v '^---$' >>arxiv.yml; then
		print $id >> arxiv-archieved.tsv
	fi
done
