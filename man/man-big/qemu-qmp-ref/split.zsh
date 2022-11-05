#!/usr/bin/env zsh

pushd 02-description/
awk -v fc="" -v fn="" -v c=1 -re ' { fc=fc "
" $0; }; /^[[:space:]]{3,3}[[:alpha:]]+.*/ { if (fn != "") { print fc > fn }; fn=gensub(/[[:space:]]{3,3}/,"","g"); pref=sprintf("%02d",c++); fn=pref "-" fn; fc=$0; } END { print fc > fn}' ../02-description.txt
popd
