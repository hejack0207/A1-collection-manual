#!/usr/bin/env -S zsh -i

cat rfcs.tsv | while read n cate title; do
	ntitle=$(echo -n "$title" | tr '/' '-')
	if ! test -f ~rfc/$cate/rfc$n-$ntitle.txt; then
		sn=$(print -f "%d" $n)
		rm ~rfc/$cate/rfc$n-*.txt
		cp ~codes/docs/rfc/rfc$sn.txt ~rfc/$cate/"rfc$n-$ntitle.txt"
	else
		echo ~rfc/$cate/rfc$n-$ntitle.txt already exists!
	fi
done

