def stripcslashes(str) 
return str.gsub(/\\x../) {|c| c[2,3].to_s.hex.chr} 
end
def gcalc(statement)
		something = open("http://www.google.com/ig/calculator?hl=en&q=" + CGI.escape(statement))
		content = something.read
		content = stripcslashes(content)
		content = content.gsub(/<sup>(.*?)<\/sup>/,'^\1')
		content = content.gsub(/&#215;/,"\u00d7")
		split = content.split(",")
		result = split[1].gsub("rhs: ","").gsub("\"","")
		return result
end
def command_gcalc()
    mmessage = $message[$message.index(" ") + 1, $message.length - ($message.index(" ") + 1)]
    sendmessage(gcalc(mmessage))
end
regLib("cgi")
regLib("open-uri")
regCmd("calc","command_gcalc")
regGCmd("calc","command_gcalc")
