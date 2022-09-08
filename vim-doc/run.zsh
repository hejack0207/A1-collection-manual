# vim: sts=-1 sw=4 fdm=marker

if [[ -e help.txt ]]; then
    cat help.txt | ./organize.awk
fi

awkscript="$(pwd)/split-txt.awk"

while read f; do
    dir=$(dirname "$f")
    pushd "$dir"
    awk -f $awkscript $(basename "$f")
    popd
done <<<$(find "1.USER MANUAL" -name '*.txt')

# while read f; do
#     cd ${f:A:h}
#     awk -f $awkscript ${f:A:t}
# done <<<$(find "2.REFERENCE MANUAL/" -name '*.txt')
