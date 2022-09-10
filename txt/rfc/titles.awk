/^[[:digit:]]{4}/{
	rfc=$0
	if (rfc ~ /^[[:digit:]]{4} Not Issued. \r$/)
		output="0"
	else
		output="1"
}

/^[[:space:]]{4}/{
	rfc=rfc $0
}

/^\r$/ && output=="1"{
	gsub("[[:cntrl:]]"," ",rfc)
	gsub("[[:space:]]{2,}"," ",rfc)
	gsub(" $","",rfc)

	titlelen = index(rfc,". ")
	if (titlelen > 0){
                rfc = substr(rfc, 0, titlelen-1)
		# print "title: " rfc > "/dev/stderr"
	}else{
		print "Not found title in " rfc > "/dev/stderr"
		next
	}

	if (match(rfc, /^([[:digit:]]{4}) (.*)$/, groups)){
		rfc="- { number: \"" groups[1] "\", title: \"" gensub(/"/,"\\\\\"","g",groups[2]) "\" }"
		# print rfc > "/dev/stderr"
		print rfc >> "rfcs.yml"
	}else
		print rfc > "/dev/stderr"
}
