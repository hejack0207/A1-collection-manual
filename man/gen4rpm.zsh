#!/usr/bin/env -S zsh -il
# vim: sts=-1 sw=4
# set -x

usage() {
    echo "Usage: $0 [-p <package name>] [-s <section num>] [-c category] -D -h" 1>&2;
    exit 1;
}

pkg=""
sect=""
category=""
debug=0
while getopts "p:s:c:Dh" o; do
    case "${o}" in
        p)
            pkg=${OPTARG}
            ;;
        s)
            sect=${OPTARG}
            ;;
        c)
            category=${OPTARG}
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
for p in $(rpm -ql $pkg | grep -E --color=never -e "/man/man([^/]*|$sect)/" ${grepv[@]});
do
    (( debug )) && echo $p
    mpage=($(echo $p | sed -re 's#.*/(.*\.[[:digit:]].*)\.gz#\1#g'))
    mans+=($mpage)
    (( debug )) && echo $mpage
done
echo "man pages: ${mans[@]}"
set -- ${mans[@]}

test -d groff/$category/$pkg$sect || mkdir -p groff/$category/$pkg$sect
test -d txt/$category/$pkg$sect || mkdir -p txt/$category/$pkg$sect
test -d md/$category/$pkg$sect || mkdir -p md/$category/$pkg$sect
for manname; do
    zcat $(man -w $manname) >groff/$category/$pkg$sect/$manname
    man_dump $manname >txt/$category/$pkg$sect/$manname.txt
    MANWIDTH=40 zcat $(man -w $manname) | awk '/^.TH.*/ || p { p = 1; print }' | man-to-md.pl >md/$category/$pkg$sect/$manname.md
done
