require 'rubygems'
require 'net/toc'
require 'config'
require 'kegbot'

buddies = Hash.new

def translate_message(msg)
  case msg
  when /help|what|who/ then "I can't do much right now, but type <b>beer</b> or <b>taps</b> to see what's on tap on the #{COMPANY_NAME} #{KEGERATOR_NAME}."
  when /hey|hello|hi|yo/ then "Howdy partner"
  when /tap|beer/ then taps
  else
    return "I can't do much right now. No comprende."  
  end
end

def taps
  # Query kegbot API for list of all kegs, just data dumping right now
  # TODO run this as a cron task, save to db every 30 minutes
  keg_message = String.new  
  resp = Kegbot.new.kegs
  resp['result']['kegs'].each do |keg|
    if keg['status'] == 'online'
      keg_message = "A #{keg['size_name']} of #{keg['description']}"
    end
  end
  return keg_message
end

Net::TOC.new(AIM_USERNAME, AIM_PASSWORD) do |msg, buddy|
  msg = msg.chomp.gsub(/<[^>]+>/,"") # Clean up the incoming message
  p "#{buddy}: #{msg} at #{Time.now}" # Log the buddy name, message, and time

  # Intro message, only show if it's a newish IM  
  if !buddies.has_key?(buddy) #&& buddies[buddy] < Time.now - 60*20 #twenty minues ago
    buddy.send_im "Hi, I'm the #{COMPANY_NAME} #{KEGERATOR_NAME}, I can tell you about the beers I have on tap."
    buddy.send_im translate_message('help')
  else
    buddy.send_im translate_message(msg)
  end 
  buddies[buddy] = Time.now # Save last message time for buddy
end