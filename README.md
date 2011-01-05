# gem scoping

"Ouch, yet **another** bunch of gems installed. Onehundredandfiftythree
 and counting..."
  -nonexistent person just for documentation purpose (like, nil?)

If you don't like to read things, here's what you get:

	$ `gem scope` || `gem scope list`
	Availlable scopes:
	 * shine
	   funny
		rails
	$ `gem scope funny`
	Mind aligned: new scope is 'funny'
	$ `gem scope not-in-existence`
	Horizon extended: added scope 'not-in-existence'

	...

See, it's quite lovely (and enough for me, obviously). If it does
not-so-funny things with your precious jewelry, just issue
`gem scope all` and all will be well. (Be sure to report such an
unlikely and sad event, though. I'll help you, too!)

## Features & Caveats

	+ minimal set of features
	+ `gem install gem-scope` and you're happy (no .bashrc stuff)

	- doesn't handle conflicts between executables
	- no spec's
	- no real API

## **Warning!**

This is really _overly simplified software_ don't use it if you're
doing something critical or the like. Bugs may appear out of opened
windows, irb sessions (ow..) and wherever you `require`...
(That didn't happen for me, though.)

So, if you have any problems, get redirected to
[/dev/null](https://github.com/anapple/gem-scope/issues) and complain
about bugs, missing features (gem-scope has no features) and that there
isn't any magic in there.
Alternatively, you might reach me at <mailto:mi.au@papill0n.org>.
