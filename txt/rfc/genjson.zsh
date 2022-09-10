#!/usr/bin/zsh

yq '.' rfcs.yml | jq --slurpfile nums =(cat rfcnums.tsv | while read n _; do echo \"$n\"; done) '[.[] | select([.number] | inside($nums))]' >rfcs.json
cat rfcs.json | jq --slurpfile cates =(cat rfcnums.tsv | while read n c; do echo '{ "number": "'$n'", "cate": "'$c'"}'; done) '.[] |= (.number as $n | .category=($cates | .[] | select(.number == $n)|.cate))' | sponge rfcs.json
