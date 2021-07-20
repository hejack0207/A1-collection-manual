#!/usr/bin/zsh

if [ $# -lt 1 ]; then
	echo "usage: $0 txtfile"
	exit 0
fi

txtfile=${1:-../man/txt/bash.1.txt}
name=${$(basename $txtfile)%.?.*}

if test -d $name; then
	rm -rf $name
fi
mkdir $name

csplit $txtfile -f "$name/$name-" -b "%02d.txt" '/^[[:alnum:]][[:alnum:][:space:]]\{1,\}$/' '{*}'

for f in $name/$name-*.txt; do
	i=${${f%.txt}##$name/$name-}
	mv $name/$name-$i.txt "$name/$i-$(head -n1 $f | tr 'A-Z ' 'a-z-').txt"
done
rm $name/00-*
