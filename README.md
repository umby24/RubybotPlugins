# Rubybot Plugins

This is a set of plugins that I have developed over time for Rubybot. The list of plugins included:

	forge.rb - Adds support for the bot to be controlled via Minecraft ForgeIRC.
	gcalc.rb - Adds support for the use of Google Calculator.
	google.rb - Adds support for google queries.
	interaction.rb - Adds the ability to interact with the bot without command prefixes, such as 'hi Rubybot'
	notes.rb - Adds the ability for users to have notes stored by the bot.
	ping.rb - Adds the support to send a ping to Minecraft servers and receive information about them.
	raw.rb - Sample plugin, shows basic usage of the plugin API.
	rss.rb - Adds an RSS feed watcher to the bot (May be buggy).
	title.rb - Bot will pickup links from irc chat and display their page titles in irc.
	utc.rb - Adds functionality to retreive the current time at different UTC offsets.

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
	google [query] -- Returns the first result on google for [query].
	egoog [query] -- Returns the first 3 results on google for [query].
	note [command] [args] -- See the built in help included with the plugin.
	ping [ip] [port] -- Pings Minecraft server [ip] on port [port].
	rss [command] [args] -- See the built in help included with the plugin.
	utc [offset] -- returns the utc time at the given offset. 
	