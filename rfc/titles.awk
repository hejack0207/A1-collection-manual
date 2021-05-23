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
	# # gsub(/^([[:digit:]]{4}) ([^.]*)\. .*$/,"- { number: \\1, category: \"\", title: \"\\2\" }",rfc)
	# rfc=gensub(/^([[:digit:]]{4}) ([^.]*|[^ ]*)\. .*$/,"- { number: \\1, category: \"\", title: \"\\2\" }","g",rfc)
	# # if (index(rfc,"-"))
	# if (match(rfc,"^-"))
	#         print rfc
	# else
	#         print rfc > "/dev/stderr"
	titlelen = index(rfc,". ")
	if (titlelen > 0){
                rfc = substr(rfc, 0, titlelen)
		print "title: " rfc > "/dev/stderr"
	}else{
		print "Not found title in " rfc > "/dev/stderr"
		next
	}

	if (match(rfc, /^([[:digit:]]{4}) (.*)$/, groups)){
		rfc="- { number: " groups[1] ", category: \"\", title: \"" gensub(/"/,"\\\\\"","g",groups[2]) "\" }"
		# print rfc > "/dev/stderr"
		print rfc >> "rfcs.yml"
	}else
		print rfc > "/dev/stderr"
}
