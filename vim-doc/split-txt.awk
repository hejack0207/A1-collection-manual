# vim: sts=-1 sw=4 fdm=marker
BEGINFILE {
    filename["name"]=FILENAME
    filename["index"]=0
    nameneeded=0
    fn=sprintf("%02d##%s", filename["index"], filename["name"])
}

/={20,}/{
    nameneeded=1
    next
}

nameneeded && match($0, /^\*([^*]+)\*[[:space:]]+([^*]+).*$/, m) {
    gsub(/^[[:space:]]+/,"",m[2])
    gsub(/[[:space:]]+$/,"",m[2])
    filename["name"]=sprintf("%s::%s.txt", m[1], m[2])
    nameneeded=0
    fn=filename["name"]
}

nameneeded && ! match($0, /^\*([^*]+)\*[[:space:]]+([^*]+).*$/, m) {
    filename["name"]=FILENAME
    filename["index"]++
    nameneeded=0
    fn=sprintf("%02d##%s", filename["index"], filename["name"])
}

{
    print fn "      " $0
}

ENDFILE {
}
