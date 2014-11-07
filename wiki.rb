regLib("json")
regLib("open-uri")

def wikipedia_lookup(query)
	url = "http://en.wikipedia.org/w/api.php?action=parse&page=#{CGI.escape(query)}&format=json&prop=text&section=0"
	
	wSock = open(url)
	content = wSock.sysread(90000)
	wSock.close()
	
	jsonobj = JSON.parse(content)
	
	if jsonobj["error"] != nil
		return jsonobj["error"]["info"]
	end
	
	querydata = jsonobj["parse"]["text"]["*"]
	
	if querydata.include?("<ul class=\"redirectText\">")
		filtered = /<a(.*?)<\/a>/.match(querydata)[0]
		filtered = filtered.gsub(%r{</?[^>]+?>}, "")
		return wikipedia_lookup(filtered)
	end
	
	filtered = /<p>(.*?)<\/p>/.match(querydata)[0]
	filtered = filtered.gsub(%r{</?[^>]+?>}, "")
		
	return filtered
end
def command_wikipedia()
	mmessage = $message[$message.index(" ") + 1, $message.length - ($message.index(" ") + 1)]
	send_message(wikipedia_lookup(mmessage))
end	

regCmd("wiki", "command_wikipedia")
regGCmd("wiki", "command_wikipedia")

help = Help.new("wiki")
help.addDescription("Preforms a lookup on wikipedia and returns the resulting first paragraph.")
help.addArgument("term", "The terms to lookup in wikipedia.")
$help.push(help)