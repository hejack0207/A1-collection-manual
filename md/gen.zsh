#!/usr/bin/env -S zsh -il

pdffile=${1:?pdf file not specified!}
filename=$(basename ${pdffile})
basename=${filename%%.pdf}
test -d $basename || mkdir $basename
pushd $basename
cp $pdffile .
pdftohtml -s -noframes $filename
html2md -i ${basename}.html >README.md
rm *.html *.pdf
popd
