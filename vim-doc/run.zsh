# vim: sts=-1 sw=4 fdm=marker

if [[ -e help.txt ]]; then
    cat help.txt | ./org.awk
fi

awkscript="$(pwd)/split-text.awk"

while read f; do
    cd ${f:A:h}
    awk -f $awkscript ${f:A:t}
done <<<$(find . -name '*.txt')
