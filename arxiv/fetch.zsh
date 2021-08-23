#!/usr/bin/env -S zsh -il

cat arxiv.tsv | while read id title category; do
	echo $id $title $category
	# arxiv-fetch
done
