#!/usr/bin/env -S gawk -f
# vim: sts=-1 sw=4 fdm=marker

BEGIN {
}

match($0, /^(USER MANUAL|REFERENCE MANUAL):.*/,m){
    manual["name"]=m[1]
    chapter["index"]=0
    out=sprintf("mkdir -p \"%s\"",manual["name"])
    print out
}

match($0, /^(.*) ~/, m){
    chapter["name"]=m[1]
    chapter["index"]++
    sect["index"]=0
    out=sprintf("mkdir -p \"%s/%02d::%s\"", manual["name"], chapter["index"], chapter["name"])
    print out
}

match($0, /^\|(.*)\.txt\|[[:space:]]+(.*)$/, m){
    sect["name"]=m[1]
    sect["title"]=m[2]
    sect["index"]++
    if (chapter["index"]==0){
	out=sprintf("mkdir -p \"%s/%s\"", manual["name"], sect["title"])
    }else{
	out=sprintf("mkdir -p \"%s/%02d::%s/%02d::%s\"", manual["name"], chapter["index"], chapter["name"], sect["index"], sect["title"])
    }
    print out
    if (chapter["index"]==0){
	out=sprintf("mv %s.txt \"%s/%s\"",sect["name"], manual["name"], sect["title"])
    }else{
	out=sprintf("mv %s.txt \"%s/%02d::%s/%02d::%s\"",sect["name"], manual["name"], chapter["index"], chapter["name"], sect["index"], sect["title"])
    }
    print out
}

END {
}
