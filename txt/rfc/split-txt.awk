# vim: sts=-1 sw=4 fdm=marker
BEGINFILE {
    filename["name"]=FILENAME
    filename["index"]=0
    fn=sprintf("%03d::%s", filename["index"], filename["name"])
    filename["index"]++
}

match($0, /^(Abstract|Table of Contents)[[:space:]]*$/, m){
    filename["name"]=sprintf("%03d::%s.txt", filename["index"], m[1])
    fn=filename["name"]
    filename["index"]++
}

match($0, /^([[:digit:]]+\.[\.[:digit:]]*)[[:space:]]*(.*)$/, m) {
    gsub(/^[[:space:]]+/,"",m[2])
    gsub(/[[:space:]]+$/,"",m[2])
    filename["name"]=sprintf("%03d::%s%s.txt", filename["index"], m[1],  m[2])
    fn=filename["name"]
    filename["index"]++
}

match($0, /^(Appendix [\.[:upper:][:digit:]]*|[[:upper:]]\.[\.[:digit:]]+)[[:space:]]*(.*)$/, m) {
    gsub(/^[[:space:]]+/,"",m[2])
    gsub(/[[:space:]]+$/,"",m[2])
    filename["name"]=sprintf("%03d::%s%s.txt", filename["index"], m[1],  m[2])
    fn=filename["name"]
    filename["index"]++
}

{
    print $0 >> gensub("/","::","g",fn)
    # print fn "    " $0
}

ENDFILE {
}
