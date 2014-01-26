def ctof()
	sendmessage(((($args[1].to_i * 9) / 5) + 32).to_s)
end
def ftoc()
	sendmessage(((($args[1].to_i - 32) * 5) / 9).to_s)
end

regCmd("ctof", "ctof")
regCmd("ftoc", "ftoc")
regGCmd("ctof", "ctof")
regGCmd("ftoc", "ftoc")