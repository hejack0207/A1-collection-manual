#!/usr/bin/env -S zsh -i

cat rfcs.tsv | while read n cate title; do
	if ! test -f ~rfc/$cate/rfc$n-$title.txt; then
		rm ~rfc/$cate/rfc$n-*.txt
		cp ~codes/docs/rfc/rfc$n.txt ~rfc/$cate/rfc$n-$title.txt
	else
		echo ~rfc/$cate/rfc$n-$title.txt already exists!
	fi
done

