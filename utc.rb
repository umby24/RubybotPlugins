def command_utc()
	if $args[1].length == 3
		$args[1] = $args[1] + ":00"
	elsif $args[1].length == 2
		$args[1] = $args[1][0, 1] + "0" + $args[1][1, 1] + ":00"
	elsif $args[1].length != 6
		sendmessage($name + ": Incorrect format for Time zone.")
		sendmessage("Format is: [+/-][offset], ex. -02:00")
		return
	end
	sendmessage($name + ": " + Time.now.localtime($args[1]).strftime("%I:%M:%S %p"))
end
regCmd("utc","command_utc")
regGCmd("utc","command_utc")
regHelp("utc", nil, [$prefix + "utc [+/-][offset]", "Returns the current time at the given utc offset."])