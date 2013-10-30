def google(term,result)
	begin
		something = open("http://ajax.googleapis.com/ajax/services/search/web?v=1.0&q=" + term.gsub(" ","+"))
		content = something.read
		split = content.split("{\"GsearchResultClass\":",50)
		result1 = split[result]
		rs = result1.split("\",\"",9)
	rescue Exception => e
		
	end
	#I want split #1 (url),#6 (title no formatting).
	begin
		title = rs[6][rs[6].index(":") + 2, rs[6].length - (rs[6].index(":") + 2)]
		url = rs[2][rs[2].index(":") + 2, rs[2].length - (rs[2].index(":") + 2)]
		return "Title: " + CGI.unescape_html(title) + " ( " + CGI.unescape(url) + " ) "
	rescue
		err_log("error! (Google plugin)")
	end
end
def command_google()
	mmessage = $message[$message.index(" ") + 1, $message.length - ($message.index(" ") + 1)]
	sendmessage(google(mmessage,1))
end
def command_egoog()
	mmessage = $message[$message.index(" ") + 1, $message.length - ($message.index(" ") + 1)]
    sendmessage("1:" + google(mmessage,1))
    sendmessage("2: " + google(mmessage,2))
    sendmessage("3: " + google(mmessage,3))
end

regLib("cgi")
regLib("open-uri")
regCmd("google","command_google")
regGCmd("google","command_google")
regCmd("egoog","command_egoog")
regGCmd("egoog","command_egoog")	

regHelp("google", nil, [$prefix + "google <Keywords>", "Returns the first google match to the given key words."])
regHelp("egoog", nil, [$prefix + "egoog <Keywords>", "Returns the first three google matches to the given key words."])
