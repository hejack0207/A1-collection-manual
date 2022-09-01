#!/usr/bin/env zsh
# vim: sts=-1 sw=4 fdm=marker

srcdir=${1:?directory of html files not specified}
destdir=${2:?target directory not specified}

while read f; do
    targetpath=${f#$srcdir/}
    targetdir=$(dirname $targetpath)
    targetbasename=$(basename $targetpath)
    targetbasename=${targetbasename%.html}
    test -d $destdir/$targetdir || mkdir -p $destdir/$targetdir
    html2md -i $f >$destdir/$targetdir/$targetbasename.md
done <<<$(find $srcdir -name '*.html' -type f)

while read f; do
    targetpath=${f#$srcdir/}
    targetdir=$(dirname $targetpath)
    test -d $destdir/$targetdir || mkdir -p $destdir/$targetdir
    cp $f $destdir/$targetpath
done <<<$(find $srcdir -not -name '*.html' -and -type f)

echo done
