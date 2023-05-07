#!/usr/bin/zsh

pdffile=${1:?pdf file not specified}
txtfilename=${$(basename $pdffile)%.pdf}.txt

mkdir -p pdfs
pdftotext -nopgbrk $pdffile pdfs/$txtfilename
