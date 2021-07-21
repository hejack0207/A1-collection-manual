#!/usr/bin/zsh

echo $@
#strace $@ |& awk '$2 ~ /^[[:alpha:]]+\(.*/{print gensub(/\(.*/,"","g",$2)}' | sort -u
