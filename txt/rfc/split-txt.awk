# vim: sts=-1 sw=4 fdm=marker
BEGINFILE {
    filename["name"]=FILENAME
    filename["index"]=0
    fn=sprintf("%02d::%s", filename["index"], filename["name"])
    filename["index"]++
}

match($0, /^(Abstract|Table of Contents)[[:space:]]*$/, m){
    filename["name"]=sprintf("%02d::%s.txt", filename["index"], m[1])
    fn=filename["name"]
    filename["index"]++
}

match($0, /^([\.[:digit:]]+)[[:space:]]*(.*)$/, m) {
    gsub(/^[[:space:]]+/,"",m[2])
    gsub(/[[:space:]]+$/,"",m[2])
    filename["name"]=sprintf("%02d::%s%s.txt", filename["index"], m[1],  m[2])
    fn=filename["name"]
    filename["index"]++
}

match($0, /^(Appendix [\.[:upper:][:digit:]]*|[[:upper:]]\.[\.[:upper:][:digit:]]*)[[:space:]]*(.*)$/, m) {
    gsub(/^[[:space:]]+/,"",m[2])
    gsub(/[[:space:]]+$/,"",m[2])
    filename["name"]=sprintf("%02d::%s%s.txt", filename["index"], m[1],  m[2])
    fn=filename["name"]
    filename["index"]++
}

{
    print $0 >> fn
    # print fn "    " $0
}

ENDFILE {
}
