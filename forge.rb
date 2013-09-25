def forgemessage()
    if $message[0,1] != "+" && $message.include?(":") && $host[0,$host.index("!")] == "SinZationalBot"
        orighost = $host
        origmess = $message
        $host = $message[0, $message.index(":")] + "!"
        $message = $message[$message.index(":") + 1, $message.length - $message.index(":") + 1]
        if $message.include?("  ") == false
            $host = orighost
            $message = origmess
        else
            $message = $message[2, $message.length - 2]
        end
        if $access.include?($host.gsub("!","") + "\n") == false
            $access += [$host.gsub("!","") + "\n"]
        end
        if $authed.include?($host.gsub("!","")) == false
            $authed += [$host.gsub("!","")]
        end
    end
end
regMsg("forge_message","forgemessage")