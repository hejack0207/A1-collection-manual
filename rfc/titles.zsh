#!/usr/bin/env -S zsh
truncate -s0 rfcs.yml
awk -f titles.awk rfc-index.txt
sed -i -re '/\I/d' rfcs.yml
