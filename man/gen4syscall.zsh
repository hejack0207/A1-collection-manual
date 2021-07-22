#!/usr/bin/zsh -li
set -e

cat man2.list | while read m; do
	test -f txt/man2/$m.2.txt || ./gen4man.zsh $m.2
done
mmv '*/*.2.*' '#1/man2/#2.2.#3'
