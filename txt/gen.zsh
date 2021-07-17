#!/usr/bin/zsh

rm -rf bash
mkdir bash

csplit ../man/txt/bash.1.txt -f "bash/bash-" -b "%02d.txt" '/^[[:alpha:]][[:alpha:][:space:]]\+$/' '{*}'

for f in bash/bash-*.txt; do
	i=${${f%%.txt}##bash/bash-}
	mv bash/bash-$i.txt "bash/$i-$(head -n1 $f | tr 'A-Z ' 'a-z-').txt"
	rm bash/00-*
done
