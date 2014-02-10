def get_title(url)
    url = url.gsub("^[a-zA-Z0-9\-\.]+\.(com|org|net|mil|edu|info|io|IO|gl|GL|co|CO|INFO|COM|ORG|NET|MIL|EDU)$","")
	url = url.gsub("^(http|https|ftp)\://([a-zA-Z0-9\.\-]+(\:[a-zA-Z0-9\.&amp;%\$\-]+)*@)*((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])|localhost|([a-zA-Z0-9\-]+\.)*[a-zA-Z0-9\-]+\.(com|edu|gov|int|mil|net|org|biz|arpa|info|name|pro|aero|coop|museum|[a-zA-Z]{2}))(\:[0-9]+)*(/($|[a-zA-Z0-9\.\,\?\'\\\+&amp;%\$#\=~_\-]+))*$","")

    begin
        asdf = open(url)
        content = asdf.sysread(90000)
        content2 = content.downcase
        if content2.include?("<title>") == false
            return ""
        else
            place1 = content2.index("<title>")
            place2 = content2.index("</title>")
            length = place2 - place1
            length -= 7
            place1 += 7
            title = content[place1,length]
			title = CGI.unescape_html(title)
			title = title.strip()
	    
            return "[Title: " + title + "]"
        end
    rescue Exception => e
        puts "Error: " + e.message + " #{url}"
		return ""
    end
end

def message_title()
    if $message.include?("http://") || $message.include?("https://")
        $message = $message + " "
        url = $message.index("http://")
        substring = $message[url,$message.length - url]
        index2 = substring.index(" ")
        myurl = substring[0, index2]
        myurl = myurl.strip
        $current = $splits[1]

        if File.exists?("settings/bl.txt")
            blchans = IO.readlines("settings/bl.txt")
        end
        if blchans != nil
            if blchans.include?($current) || blchans.include?($current + "\n")
                return
            end
        end

        sendmessage(get_title(myurl))
    end
end

def command_blacklist()
    # Blacklist command
    content = IO.readlines("settings/bl.txt")

    if content.include?($current) || content.include?($current + "\n")
        sendmessage("This network is already blacklisted.")
        return
    end

    content[content.length] = $current

    thisFile = File.new("settings/bl.txt","w+")
    for i in 0..content.length - 1
        thisFile.syswrite(content[i])
    end
    thisFile.close()

    sendmessage("Blacklisted")
end

def command_unblacklist()
    # Unblacklist

    content = IO.readlines("settings/bl.txt")

    if content.include?($current) == false && content.include?($current + "\n") == false
        sendmessage("This channel is not blacklisted.")
        return
    end

    content.delete($current); content.delete($current + "\n");

    thisFile = File.new("settings/bl.txt","w+")
    for i in 0..content.length - 1
        thisFile.syswrite(content[i])
    end
    thisFile.close()

    sendmessage("Un-Blacklisted")
end

regLib("openssl")
regLib("cgi")
regLib("open-uri")

regMsg("plugin_title", "message_title")

regCmd("blacklist","command_blacklist")
regCmd("unblacklist","command_unblacklist")

help = Help.new("blacklist")
help.addDescription("Blacklists the current channel from the URL Title plugin.")
$help.push(help)

help = Help.new("unblacklist")
help.addDescription("UnBlacklists the current channel from the URL Title plugin.")
$help.push(help)