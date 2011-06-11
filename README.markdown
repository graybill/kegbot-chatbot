About
----------------------------
An AIM chatbot that talks to a kegbot (http://kegbot.org). A user must send a message to the chatbot to engage.

By default this connects to the publicly available SFO Kegbot so anyone can connect to the SFO Kegbot for experimentation. You will need to register an AIM screename for your bot at http://aim.com

	git clone git@github.com:graybill/kegbot-chatbot.git

Requirements
----------------------------
Make sure you have Ruby 1.8.7

	ruby -v

Install Ruby Bundler:

	gem install bundler

Install net-toc: 

	gem install -r net-toc

Configuration
----------------------------
Copy config.example.rb to config.rb and edit the file as necessary.

Run the Chatbot
----------------------------
	ruby chatbot.rb