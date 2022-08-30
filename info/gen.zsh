#!/usr/bin/zsh

if [ $# -lt 1 ]; then
	echo "usage: $0 info-name"
	exit 0
fi

name=${1?:info name not specified}
txtfile="$name/$name.txt"

if test -d $name; then
	rm -rf $name
fi

mkdir $name

info --subnodes -o $txtfile $name
csplit $txtfile -n4 -f "$name/$name-" -b "%03d.txt" '/^[*=]\{4,\}/-1' '{*}'

for f in $name/$name-*.txt; do
	i=${${f%.txt}##$name/$name-}
	nn=$(head -n1 $f | tr $'A-Z ' "a-z-")
	nn=$(echo "$nn" | tr -sd $'/?\'()' "")
	nn=${nn%%--*}
	mv $name/$name-$i.txt "$name/$i-$nn.txt"
done
# rm $name/000-*
rm $txtfile
