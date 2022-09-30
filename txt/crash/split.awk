#!/usr/bin/env -S gawk -f
# vim: sts=-1 sw=4 fdm=marker

BEGIN {
    debug=0
    filename["index"]=0
    plines["index"]=0
    nameneeded=0
    fn=sprintf("%02d::%s.txt",filename["index"]++,"intro")
}

/^NAME$/{
    nameneeded=1
    plines[plines["index"]++]=$0
    next
}

nameneeded && match($0,/^[[:space:]]*([^[:space:]]+)[[:space:]]*-[[:space:]]*([[:print:]]+[^[:space:]])[[:space:]]*$/,m){
    title["command"]=m[1]
    title["brief"]=m[2]
    if (length(title["command"])>1)
	fn=sprintf("%02d::%s.txt",filename["index"]++,title["command"])
    else
	fn=sprintf("%02d::%s.txt",filename["index"]++,title["brief"])
    nameneeded=0
}

function genout(line,fn){
    if (debug){
	print fn,"---",line
    }else{
	print line >>fn
    }
}

{
    if (nameneeded == 0) {
	for (i=0;i<plines["index"];i++){
	    genout(plines[i],fn)
	}
	plines["index"]=0
	genout($0,fn)
    }
}

END {
}
