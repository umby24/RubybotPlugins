def fetch_rss_items(url, max_items = nil)
  %w{open-uri rss/0.9 rss/1.0 rss/2.0 rss/parser}.each do |lib|
    require(lib)
  end
  rss = RSS::Parser.parse(open(url).read, false)
  rss.items[0...(max_items ? max_items : rss.items.length)]
end
def get_titles(url)
  items = fetch_rss_items(url, 5)
  arritems = items.collect { |item| item.title }
  return arritems.to_s
end
def get_titles2(url)
items = fetch_rss_items(url, 5)
arritems = items.collect { |item| item.title}
return arritems
end
def get_first(url)
  items = fetch_rss_items(url, 5)
  arritems = items.collect { |item| item.title }
  arrdescrip = items.collect { |item| item.description}
  arrlink = items.collect { |item| item.link}
  return  arrlink[0]
end
def update_feed2(name,force=false)
begin
url = ""
last = ""
reader = IO.readlines("settings/rss/#{name}")
reader.each {|line|
if line.include?("=") == false
	next
end
a = line[0, line.index("=")]
d = line[line.index("=") + 1, line.length - (line.index("=") + 1)]
if d.include?("\n") then
d = d.chop
end
case a.downcase
  when "url"
    url = d
  when "last"
    last = d
end
}


if force==true
last = ""
end
myarr = get_titles2(url)
if myarr[0] != last
last = myarr[0]
link = get_first(url)
sendtoall(2.chr + name + " update: #{last} (" + 2.chr + link + 2.chr + ")")
#now, update the file.
writer = File.new("settings/rss/#{name}","w+")
writer.syswrite("url=#{url}\nlast=#{last}")
writer.close()
#done
end
rescue Exception => e

end
end
def update_all_feeds()
$last = ""
  begin
	  myfile = File.new("settings/rssf", "r")
	  myfile.each_line do |f|
	  $last = f
	  f = f.gsub("\n","")
	  update_feed2(f,false)
	  end
	  myfile.close()
  rescue Exception => e

	  myfile.close()
          File.delete("settings/rss/#{$last}")
          afile = File.new("settings/rssf","r")
          content = afile.sysread(afile.size)
          afile.close
          afile = File.new("settings/rssf", "w+")
          afile.write(content.gsub($last,""))
          afile.close()
  end
end
def rss_loop()
    puts "RSS Loop started"
    begin
        while $quit == 0
            update_all_feeds()
            sleep(30)
        end
	rescue Exception => e

	end
    
	puts "Loop ended"
end
def kickoff()
    $rssthread = Thread.new{rss_loop}
end
def command_rss()
case $args[1]
        when "add"
          #need 2 more args
          title = $args[2]
          url = $args[3]
          title = title.gsub("\n","")
          url = url.gsub("\n","")
          title = title.gsub(" ","")
          url = url.gsub(" ","")
          afile = File.new("settings/rssf","r")
          content = afile.sysread(60000)
          content += "\n" + title
          afile.close
          afile = File.new("settings/rssf","w+")
          afile.write(content)
          afile.close()
          #Modified main feed file, creating feed dependent files.
          afile = File.new("settings/rss/#{title}","w+")
          afile.write("url=#{url}\nlast=asd")
          afile.close()
          #done!
          sendmessage("Feed added successfully!")
        when "rem"
		asdfd = ""
          #need 1 more arg
          title = $args[2]
		  begin
		  File.delete("settings/rss/#{title}")
		  rescue
		  end

          afile = File.new("settings/rssf","r")
          afile.each_line do |z|
            if z.include?(title) == false && z != "\n"
              asdfd += z
            end
          end
          afile.close
          afile = File.new("settings/rssf", "w+")
          asdfd = asdfd.gsub("\n" + title,"")
          asdfd = asdfd.gsub(title + "\n","")
		  asdfd = asdfd.gsub(title, "")
          afile.write(asdfd)
          afile.close()
		  puts "removed.."
          sendmessage("#{title} Removed from RSS feeds.")
        when "up"
          title = $args[2]
          update_feed2(title,true)
		  sendmessage("Manual update done.")
        when "feeds"
          #list out the feeds..
          feedstring = ""
          afile = File.new("settings/rssf", "r")
          afile.each_line do |f|
            feedstring += f + ","
          end
          feedstring = feedstring.gsub("\n","")
          sendmessage("RSS Feeds: " + feedstring.chop)
      end 
end
def sendtoall(text)
		realcurrent = $current
		
		$serverchannel.each do |f|
			$current = f
			sendmessage(text)
		end
		
		$current = realcurrent
end
regCon("rss_loop","kickoff")
regCmd("rss","command_rss")