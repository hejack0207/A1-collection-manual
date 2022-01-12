#!/usr/bin/env -S zsh -il
# set -x

usage() {
    echo "Usage: $0 [-s <section num>] [-c category] -D -h" 1>&2;
    exit 1;
}

sect=""
category=""
debug=0
while getopts "p:s:Dh" o; do
    case "${o}" in
        s)
            sect=${OPTARG}
            ;;
        c)
            category=${OPTARG}
            ;;
        D)
            debug=1
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done
shift $((OPTIND-1))

for p in $(rpm -qa G $1); do
	if rpm -ql $p | grep -q /usr/share/man; then
		print $p | sed -re 's#\-([[:digit:]]+).*##g'
		# print $p | sed -re 's#\-([[:digit:]]+|svn).*##g'
	fi
done
