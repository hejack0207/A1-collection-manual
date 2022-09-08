# vim: sts=-1 sw=4 fdm=marker
BEGINFILE {
    filename["name"]=FILENAME
    filename["index"]=0
    nameneeded=0
    fn=sprintf("%02d::%s", filename["index"], filename["name"])
    filename["index"]++
}

/^={20,}$/{
    nameneeded=1
    next
}

nameneeded && match($0, /^\*([^*]+)\*[[:space:]]+([^*]+).*$/, m) {
    gsub(/^[[:space:]]+/,"",m[2])
    gsub(/[[:space:]]+$/,"",m[2])
    filename["name"]=sprintf("%02d::%s::%s.txt", filename["index"], m[1], m[2])
    nameneeded=0
    fn=filename["name"]
    filename["index"]++
}

nameneeded && ! match($0, /^\*([^*]+)\*[[:space:]]+([^*]+).*$/, m) {
    filename["name"]=FILENAME
    nameneeded=0
    fn=sprintf("%02d::%s", filename["index"], filename["name"])
    filename["index"]++
}

{
    print $0 >> fn
    # print fn "    " $0
}

ENDFILE {
}
