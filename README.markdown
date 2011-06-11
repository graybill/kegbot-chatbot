About
----------------------------
An AIM chatbot that talks to a [kegbot](http://kegbot.org). A user must message the chatbot to engage the bot.

By default this connects to the publicly available SFO Kegbot so anyone can connect to the SFO Kegbot for experimentation. You will need to register an AIM screen name for your chatbot at [http://aim.com](http://aim.com)

Example
----------------------------
A chatbot running the latest code may occasionally be online as **rtpkegerator**

Get the code
----------------------------
Check out the code:

	git clone git@github.com:graybill/kegbot-chatbot.git

Move into the code directory:

	cd kegbot-chatbot.git

Requirements
----------------------------
Make sure you have Ruby 1.8.7 (default for OSX)

	ruby -v

Install net-toc (may need sudo): 

	gem install -r net-toc

Install Ruby Bundler (may need sudo):

	gem install bundler
	
Then get the required gems:

	bundle install

Configuration
----------------------------
**Important:** Copy config.example.rb to config.rb and edit the file with your AIM name (required) and kegbot info (optional, defaults to publicly available kegbot).

Run the Chatbot
----------------------------
	ruby chatbot.rb
	
Usage
----------------------------

Send your chatbot an instant message. The first IM every 30 minutes will show a welcome message. Otherwise messages containing the following words will elicit a response:

**"hello", "hi", "hey", or "yo"** : A welcome message

**"help"** : Message about using the chatbot

TODOs
----------------------------
* Store data from kegbot API calls and user logs to a sqlite database
* Expand kegbot.rb API library
* String parsing to respond to the chatbot with individual keg attributes (e.g. catch 'beer name' from keg list)