regLib("open-uri")
regLib("cgi")
regLib("json")

def Do_Dictionary_Lookup(term)
	website = open("http://www.google.com/dictionary/json?callback=a&client=p&sl=en&tl=en&q=" + CGI.escape(term))
	text = website.read
	jsonObj = JSON.parse(text[2, text.length - 12])
	website.close()
	definition = ""
	part = ""
	puts text
	pull = 0
	
	if jsonObj["primaries"] != nil
		if jsonObj["primaries"][0]["terms"][0]["labels"] != nil
			part = jsonObj["primaries"][0]["terms"][0]["labels"][0]["text"]
		else
			part = "None"
		end

		jsonObj["primaries"][0]["entries"].each_index {|index|
			if jsonObj["primaries"][0]["entries"][index]["terms"][0]["type"] == "text"
				if jsonObj["primaries"][0]["entries"][index]["terms"][0]["labels"] != nil 
					pull = pull + 1
				end
				if pull == index
					definition = CGI.unescape(jsonObj["primaries"][0]["entries"][index]["terms"][0]["text"])
					break
				end
			end
		}
	end
	
	return 2.chr + 3.chr + "12" + term + 3.chr + 2.chr + " [" + 29.chr + 3.chr + "3" + part + 3.chr + 29.chr + "] " + definition
end

def Command_Define()
	mmessage = $message[$message.index(" ") + 1, $message.length - ($message.index(" ") + 1)]
	sendmessage(Do_Dictionary_Lookup(mmessage))
end

regCmd("define","Command_Define")
regGCmd("define","Command_Define")

help = Help.new("define")
help.addDescription("Returns the dictionary definition of that term.")
help.addArgument("term", "The term to lookup on Google Dictionary.")
$help.push(help)
