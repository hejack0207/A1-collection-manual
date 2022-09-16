#!/usr/bin/env zsh
# vim: sts=-1 sw=4 foldmethod=marker

local -A opts
zparseopts -K -D -M -E -A opts -help h d x:

usage(){
    print "Usage: gen.zsh [options] keyword"
    print "\t-d\tdry run mode"
    print "\t-x pattern\texclude pattern"
    print "\t-h\tshow this help"
}

if [[ -n ${opts[(i)-h]} || -n ${opts[(i)--help]} ]]; then
    usage
    return 1
fi

key=${1:?key not specified}

if [[ -n ${opts[(i)-d]} ]]; then
    if [[ -n ${opts[-x]} ]]; then
	find ../.. -path "*$key*" -type f | grep -v links/$key | grep -v "${opts[-x]}" | while read p; do echo "$p"; done
    else
	find ../.. -path "*$key*" -type f | grep -v links/$key | while read p; do echo "$p"; done
    fi
else
    if [[ -n ${opts[-x]} ]]; then
	find ../.. -path "*$key*" -type f | grep -v links/$key | grep -v "${opts[-x]}" | while read p; do ln -s $p ${${p#../../}//\//__}; done
    else
	find ../.. -path "*$key*" -type f | grep -v links/$key | while read p; do ln -s $p ${${p#../../}//\//__}; done
    fi
fi

