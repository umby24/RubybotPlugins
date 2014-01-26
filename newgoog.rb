def newgoogle(term,result)
	begin
		something = open("http://ajax.googleapis.com/ajax/services/search/web?v=1.0&q=" + term.gsub(" ","+"))
		content = something.read
		something.close()
		
		parsed = JSON.parse(content)
	rescue Exception => e
		
	end
	#I want split #1 (url),#6 (title no formatting).
	begin
		title = parsed["responseData"]["results"][result - 1]["titleNoFormatting"]
		url = parsed["responseData"]["results"][result - 1]["url"]
		return "Title: " + CGI.unescape_html(title) + " ( " + CGI.unescape(url) + " ) "
	rescue Exception => e
		#err_log("error! (Google plugin)")
		watchdog_Log("Google plugin: " + e.message, e.backtrace)
	end
end

def command_newgoogle()
	result = 1
	if $args[1].numeric? == true
		result = $args[1].to_i
		isearch = $args[0] + " " + $args[1] + " "
		mmessage = $message[$message.index(isearch), $message.length - ($message.index(isearch))]
	else
		mmessage = $message[$message.index(" ") + 1, $message.length - ($message.index(" ") + 1)]
	end
	
	sendmessage(newgoogle(mmessage,result))
end

regLib("json")
regLib("cgi")
regLib("open-uri")
regCmd("google","command_newgoogle")

help = Help.new("google")
help.addDescription("Returns the first google match to the given key words.")
help.addArgument("Result", "The result of the search to return", true)
help.addArgument("keywords","The keywords to google.")
$help.push(help)
