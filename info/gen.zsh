#!/usr/bin/zsh

if [ $# -lt 1 ]; then
	echo "usage: $0 txtfile"
	exit 0
fi

txtfile=${1:-gdb/gdb.txt}
name=${$(basename $txtfile)%.*}

if test -d $name; then
	rm -rf $name
fi

mkdir $name
csplit $txtfile -n4 -f "$name/$name-" -b "%03d.txt" '/^[*=]\{8,\}/-1' '{*}'

for f in $name/$name-*.txt; do
	i=${${f%.txt}##$name/$name-}
	nn=$(head -n1 $f | tr $'A-Z ' "a-z-")
	nn=$(echo "$nn" | tr -sd $'/?\'()' "")
	nn=${nn%%--*}
	mv $name/$name-$i.txt "$name/$i-$nn.txt"
done
# rm $name/000-*
