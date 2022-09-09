#!/usr/bin/env -S zsh -i

cat rfcs.tsv | while read n cate title; do
	ntitle=$(echo -n "$title" | tr '/' '-')
	test -d ~rfc/rfcs/$cate || mkdir -p ~rfc/rfcs/$cate
	if ! test -f ~rfc/rfcs/$cate/rfc$n-$ntitle.txt; then
		sn=$(print -f "%d" $n)
		rm ~rfc/rfcs/$cate/rfc$n-*.txt
		cp ~codes/docs/rfc/rfc$sn.txt ~rfc/rfcs/$cate/"rfc$n-$ntitle.txt"
	else
		echo ~rfc/rfcs/$cate/rfc$n-$ntitle.txt already exists!
	fi
done

