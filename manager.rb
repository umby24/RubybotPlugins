class String
  def numeric?
    Float(self) != nil rescue false
  end
end

def command_removeitem()
	if $args[1].numeric? == false
		send_raw("NOTICE " + $name + " :Argument must be numeric.")
		return
	end
	topic = $topic[$current]
	split = topic.split("]")
	newtopic = ""
	
	for i in 0..split.length - 1
		if i != $args[1].to_i - 1
			newtopic = newtopic + split[i] + "]"
		end
	end
	
	send_raw("TOPIC #{$current} :#{newtopic}")
end
def command_additem()
	mmessage = $message[$message.index(" ") + 1, $message.length - ($message.index(" ") + 1)]
	topic = $topic[$current]
	topic = topic + "[#{mmessage}]"
	puts topic
	send_raw("TOPIC #{$current} :#{topic}")
end
regCmd("tr","command_removeitem")
regCmd("ta","command_additem")

help = Help.new("tr")
help.addDescription("Removes the <number>th block from the channel title.")
help.addArgument("number", "The number of the block to remove from the message title.")
$help.push(help)

help = Help.new("ta")
help.addDescription("Adds [<text>] to the channel title.")
help.addArgument("text", "The text to be added to the channel title.")
$help.push(help)

#regHelp("tr", nil, [$prefix + "tr <number>", "Removes the <number>th block from the channel title."])
#regHelp("ta", nil, [$prefix + "ta <Text>", "Adds [<text>] to the channel title."])