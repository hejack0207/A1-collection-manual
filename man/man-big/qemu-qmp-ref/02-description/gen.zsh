#!/usr/bin/env zsh

pushd 07-Block devices/
awk -v i=1 -v fc="" -v fn="000-Block Devices.txt" -re '{
if (match($0,/[[:space:]]+([^(]+) \((Enum|Command|Object)\).*/,m)) {
if (fn != ""){
print fc > fn
}
pref=sprintf("%03d",i++)
title=m[1]
title=gensub(/^[[:space:]]+/,"","g",title)
title=gensub(/[[:space:]]+$/,"","g",title)
fn=pref "-" title "-" m[2] ".txt"
fc=$0
} else {
fc=fc "
" $0
}
}' -e 'END{ print fc > fn}' ../07-Block\ devices.txt
popd
