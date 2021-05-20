#!/usr/bin/env -S zsh
awk -e '/^[[:digit:]]{4}/{rfc=$0;output="1"}' -e '/^[[:space:]]{4}/{rfc=rfc $0}' -e '/^\r$/ && output=="1"{gsub("[[:cntrl:]]","",rfc);gsub("[[:space:]]{2,}"," ",rfc);print rfc}' rfc-index.txt
