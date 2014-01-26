def getit(ip,port)
	begin
	s = TCPSocket.open(ip,port)
	s.send(254.chr + 1.chr,0)
	d = s.read(256)
	s.close()
	if d.getbyte(0) == 255
		mystring = d[3,d.length - 3]
		mystring = mystring.force_encoding("utf-16be")
		mystring = mystring.encode("utf-8")
        mystring = mystring[3, d.length - 3]
		mysplit = mystring.split(0.chr.to_s,5) 
		$presult = "#{02.chr}#{mysplit[2]} - (#{03.chr}02#{mysplit[3]}/#{mysplit[4]}#{03.chr}),#{02.chr} MC Ver. #{02.chr}#{03.chr}02#{mysplit[1]}#{03.chr}#{02.chr} (Protocol #{02.chr}#{03.chr}02#{mysplit[0]}#{03.chr}#{02.chr})"
	end
	rescue Exception => e
		$presult = "Error pinging server"
	end
end

def ping_intercept()
	if $presult != "" && $presult != nil
		sendmessage($presult)
		$presult = ""
	end
end

def command_ping()
    begin
		mythread = Thread.new{getit($args[1],$args[2].gsub("\r\n","").gsub("\r","").gsub("\n",""))}
	rescue Exception => e
		watchdog_Log(e.message, e.backtrace)
		#return err_log(e.message)
	end
end
regCmd("ping","command_ping")
regGCmd("ping","command_ping")
regRead("ping","ping_intercept")

help = Help.new("ping")
help.addDescription("Pings the given minecraft server and returns it's name, and current players.")
help.addArgument("Server IP", "The IP of the server to be pinged.")
help.addArgument("Server Port", "The port of the server to be pinged.")
$help.push(help)

#regHelp("ping", nil, [$prefix + "ping <Server IP> <Server port>", "Pings the given minecraft server and returns it's name, and current players."])
