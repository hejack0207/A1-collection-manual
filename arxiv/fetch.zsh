#!/usr/bin/env -S zsh -il

cat arxiv.tsv | tail -n +2 | while read id title category; do
	echo $id $title $category
	# arxiv-fetch
done
