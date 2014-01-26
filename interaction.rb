$preWords = Hash.new()
$postWords = Hash.new()

def loadKeywords()
	begin
		type = "pre"
		suppress = 0
		file = IO.readlines("settings/keywords.txt")
		
		file.each {|line|
			#line = line.gsub("/^[a-zA-Z0-9]+$/", "")
			line = line.gsub("\n", "")
			line = line.gsub("\r", "")
			
			if line.include?("[") and line.include?("]")
				type = line[1, line.length - 2]
				suppress = 0
				next
			end
			
			if type != "pre" and type != "post" and suppress == 0
				#err_log("Interaction(Load keywords): Unexpected type found. Skipping lines.")
				suppress = 1
			end
			key = line[0, line.index("=")]
			value = line[line.index("=") + 1, line.length - (line.index("=") + 1)]
			if type == "pre"
				$preWords[key] = value
			elsif type == "post"
				$postWords[key] = value
			end
		}
	rescue Exception => e
		watchdog_Log("Interaction(Load keywords): #{e.message}", e.backtrace)
		#err_log("Interaction(Load keywords): #{e.message}")
	end
	_log("INFO", "interaction", "loadKeywords", "Keywords Loaded.")
end

def interaction_do()
	if $preWords.fetch($splits[2], nil) != nil and $splits[3] == $botname
		begin
			send($preWords.fetch($splits[2]).to_sym)
		rescue Exception => e
			watchdog_Log("Interaction(Interaction run): #{e.message}", e.backtrace)
			#err_log("Interaction(Interaction run): #{e.message}")
		end
	elsif ($splits[2] == ":" + $botname or $splits[2] == ":" + $botname + ":") and $postWords.fetch($splits[3], nil) != nil
		begin
			send($postWords.fetch($splits[3]).to_sym)
		rescue Exception => e
			watchdog_Log("Interaction(Interaction run): #{e.message}", e.backtrace)
			#err_log("Interaction(Interaction run): #{e.message}")
		end
	end
end

def interact_hi()
	sendmessage("Hello " + $name + ".")
end
def interact_bye()
	sendmessage("Catch ya later " + $name + ".")
end
def interact_fuck()
	sendmessage("See you in the bedroom then, " + $name)
end
loadKeywords()
regMsg("interaction", "interaction_do")
