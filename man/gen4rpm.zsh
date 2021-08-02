#!/usr/bin/env -S zsh -il
set -x

usage() {
    echo "Usage: $0 [-p <package name>] [-s <section num>] -D -h" 1>&2;
    exit 1;
}

pkg=""
sect=""
debug=0
while getopts "p:s:Dh" o; do
    case "${o}" in
        p)
            pkg=${OPTARG}
            ;;
        s)
            sect=${OPTARG}
            ;;
        D)
            debug=1
            # set -x
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done
shift $((OPTIND-1))

echo "listing manuals for package $pkg"
grepv=()
if [[ "$pkg" = "man-pages" && "$sect" = "7" ]]; then
	grepv=(\| grep -v -e utf-8 -e iso_ -e urn -e url -e latin)
fi
if [[ "$pkg" = "man-pages" && "$sect" = "2" ]]; then
	grepv=(\| grep -v -e _Exit.2)
fi
pkgversion=$(rpm -qi $pkg | grep Version | sed -re 's/(.*:\s+)//g')
mans=()
for p in $(rpm -ql $pkg | eval grep --color=never -e "/man/man$sect" ${grepv[@]});
do
	(( debug )) && echo $p
	mpage=($(echo $p | sed -re 's#.*/(.*\.[[:digit:]].*)\.gz#\1#g'))
	mans+=($mpage)
	(( debug )) && echo $mpage
done
echo "man pages: ${mans[@]}"
set -- ${mans[@]}

test -d groff/$pkg$sect || mkdir -p groff/$pkg$sect
test -d txt/$pkg$sect || mkdir -p txt/$pkg$sect
test -d md/$pkg$sect || mkdir -p md/$pkg$sect
for manname; do
	zcat $(man -w $manname) >groff/$pkg$sect/$manname
	man_dump $manname >txt/$pkg$sect/$manname.txt
	MANWIDTH=40 zcat $(man -w $manname) | awk '/^.TH.*/ || p { p = 1; print }' | man-to-md.pl >md/$pkg$sect/$manname.md
done
