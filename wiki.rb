regLib("json")
regLib("open-uri")

def wikipedia_lookup(query)
	url = "http://en.wikipedia.org/w/api.php?action=parse&page=#{CGI.escape(query)}&format=json&prop=text&section=0"
	
	wSock = open(url)
	content = wSock.sysread(90000)
	wSock.close()
	
	jsonobj = JSON.parse(content)
	querydata = jsonobj["parse"]["text"]["*"]
	
	filtered = /<p>(.*?)<\/p>/.match(querydata)[0]
	filtered = filtered.gsub(%r{</?[^>]+?>}, "")
	
	puts filtered
	
	return filtered
end
def command_wikipedia()
	mmessage = $message[$message.index(" ") + 1, $message.length - ($message.index(" ") + 1)]
	sendmessage(wikipedia_lookup(mmessage))
end	

regCmd("wiki", "command_wikipedia")
regGCmd("wiki", "command_wikipedia")

help = Help.new("wiki")
help.addDescription("Preforms a lookup on wikipedia and returns the resulting first paragraph.")
help.addArgument("term", "The terms to lookup in wikipedia.")
$help.push(help)