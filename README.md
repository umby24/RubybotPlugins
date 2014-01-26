# Rubybot Plugins

This is a set of plugins that I have developed over time for Rubybot. The list of plugins included:
	
	dict.rb - Adds a dictionary term lookup command. Uses google dictionary.
	forge.rb - Adds support for the bot to be controlled via Minecraft ForgeIRC.
	interaction.rb - Adds the ability to interact with the bot without command prefixes, such as 'hi Rubybot'
	manager.rb - Adds the ability to manage your channel titles in blocks.
	newcalc.rb - Provides basic calculator functionality using ruby eval.
	newgoog.rb - Provides support for google queries.
	notes.rb - Adds the ability for users to have notes stored by the bot.
	ping.rb - Adds the support to send a ping to Minecraft servers and receive information about them.
	raw.rb - Sample plugin, shows basic usage of the plugin API.
	rss.rb - Adds an RSS feed watcher to the bot (May be buggy).
	temp.rb - Very quick n' dirty temperture conversion plugin.
	title.rb - Bot will pickup links from irc chat and display their page titles in irc.
	utc.rb - Adds functionality to retreive the current time at different UTC offsets.
	wiki.rb - Allows you to lookup the first paragraph of a wiki page on a given topic. (Warning: May have large output.)

# Installation

Copy the files and folders into the 'plugins' directory for your bot, then add each of the plugins to your "plugins.txt" file, like so:

	forge.rb
	gcalc.rb
	google.rb
	interaction.rb
	notes.rb
	ping.rb
	raw.rb
	rss.rb
	title.rb
	utc.rb

## Commands added by these plugin

These are the commands added by these plugins, and their arguments.

	calc [query] -- Returns the results of [query] from Google Calculator.
	define [term] -- Returns the dictionary definition of that term.
	google [query] -- Returns the first result on google for [query].
	egoog [query] -- Returns the first 3 results on google for [query].
	note [command] [args] -- See the built in help included with the plugin.
	tr [number] -- Removes the <number>th block from the channel title.
	ta [text] -- Adds [<text>] to the channel title.
	ping [ip] [port] -- Pings Minecraft server [ip] on port [port].
	rss [command] [args] -- See the built in help included with the plugin.
	utc [offset] -- returns the utc time at the given offset. 
	wiki [term(s)] -- Preforms a lookup on wikipedia and returns the resulting first paragraph.