#Notes plugin for Ruby IRC bot.
#will have 2 types of note, Executable and text.
#Executable will run a ruby or shell command, text will just be text.
#Notes must be editable, and on a per-user basis.

def new_note(user,type,title,content)
#saves to notes/user/[exec/text]/[title].txt
#First, Check to see if the folders exist.
  if type == 2
    if user != "umby24"
      return "Executable notes for Main admin only."
    end
    
  end
  
  ext = ""
  if File.exists?("notes") == false
    Dir.mkdir("notes")
  end
  if File.exists?("notes/#{user}") == false
    Dir.mkdir("notes/#{user}")
  end
  case type
    when 1
      if File.exists?("notes/#{user}/text") == false
	Dir.mkdir("notes/#{user}/text")
      end
      ext = "text"
      when 2
      if File.exists?("notes/#{user}/exec") == false
	Dir.mkdir("notes/#{user}/exec")
      end
   ext = "exec"
    end
    #now we can write the file..
    afile = File.new("notes/#{user}/#{ext}/#{title}.txt","w+")
    afile.write(content)
    afile.close
   
    pm("Note updated.",user)
end
def append_note(user,title,append)
    if File.exists?("notes/#{user}/text/#{title}.txt") == false
    pm("404 - Note does not exist",user)
    end
    afile = File.new("notes/#{user}/text/#{title}.txt", "r")
    content = afile.read()
    afile.close
    content += append
    afile = File.new("notes/#{user}/text/#{title}.txt", "w+")
    afile.write(content)
    afile.close()
    pm("Note edited successfully.",user)
end
def edit_note(user,title,content)
    if File.exists?("notes/#{user}/text/#{title}.txt") == false
      return "404 - Note does not exist"
    end
    afile = File.new("notes/#{user}/text/#{title}.txt", "w+")
    afile.write(content)
    afile.close()
    pm("Note edited.",user)
end
def del_note(user,title)
     if File.exists?("notes/#{user}/text/#{title}.txt") == false
      pm("404 - Note does not exist",user)
    end
  File.delete("notes/#{user}/text/#{title}.txt")
  pm("Note deleted.",user)
end
def read_note(user,title)
    if File.exists?("notes/#{user}/text/#{title}.txt") == false
    pm("404 - Note does not exist",user)
  end
  afile = File.new("notes/#{user}/text/#{title}.txt","r")
  content = afile.read()
  afile.close()
  pm(content,user)
end
def exec_note(user,title)
  if File.exists?("notes/umby24/exec/#{title}.txt") == false
    return "404 - Note does not exist"
  end
  afile = File.new("notes/umby24/exec/#{title}.txt","r")
  content = afile.read()
  afile.close()
  begin
  eval(content)
  rescue Exception => e
  err_log(e.message)
  sendmessage("Your note errored, please revise and see error log for details.")
  end
  sendmessage("Command has been run.")
  return
end
def list_notes(user)
  pm("Notes:",user)
  Dir.foreach("notes/#{user}/text") do |f|
    if f.include?(".txt")
      pm(f.gsub(".txt",""),user)
    end
  end
end
def command_note()
type = $args[1] #Determine what to do. Edit, Append, Xecute, Create, Delete, LIST, Read
type = type.downcase
begin

case type
  when "e"
    index = $message.index($args[2])
    index += $args[2].length + 1
    string = $message[index,$message.length - index]
    edit_note($host[0,$host.index("!")],$args[2],string)
  when "a"
    index = $message.index($args[3])
    index += $args[3].length
    string = $message[index,$message.length - index]
    append_note($host[0,host.index("!")],$args[2],string)    
  when "x"
    exec_note($host[0,$host.index("!")],$args[2])
  when "c"
   index = $message.index($args[3])
   index += $args[3].length + 1
   string = $message[index,$message.length - index]
   type = 0
   if $args[2] == "text"
     type = 1
   elsif $args[2] == "exec"
     type = 2
   end
   new_note($host[0,$host.index("!")],type,$args[3],string)
  when "d"
    del_note($host[0,$host.index("!")],$args[2])
  when "list"
    list_notes($host[0,$host.index("!")])
  when "r"
    read_note($host[0,$host.index("!")],$args[2])
  else
    sendmessage("Try +help note.")
end

rescue Exception => e
sendmessage("Error: Try +help note for proper usage.")
sendmessage(e.message)
end
end
regCmd("note","command_note")
regGCmd("note","command_note")