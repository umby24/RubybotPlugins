def rcalc(statement)
		escaped = statement.gsub(/[^0-9,\*,\\,\/,\%,\+,\-,\(,\)]/,"")
		result = eval(escaped)
		
		return result.to_s
end

def command_rcalc()
    mmessage = $message[$message.index(" ") + 1, $message.length - ($message.index(" ") + 1)]
    sendmessage(rcalc(mmessage))
end

regCmd("calc","command_rcalc")
regGCmd("calc","command_rcalc")

help = Help.new("calc")
help.addDescription("Calculates the given math function.")
help.addArgument("equation","The equation to be evaluated.")
$help.push(help)
#regHelp("calc",nil,[$prefix + "calc <equation>", "Calculates the given math function."])
