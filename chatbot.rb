require 'rubygems'
require 'net/toc'
require 'config'
require 'kegbot'

buddies = Hash.new

def translate_message(msg)
  case msg
  when /help/ then "I can't do much right now, but type <b>beer</b> or <b>taps</b> to see what's on tap."
  when /hey|hello|hi|yo/ then "Howdy partner"
  when /tap|beer/ then taps
  else
    return "I can't do much right now. No comprende."  
  end
end

def taps
  # Query kegbot API for list of all kegs
  # Just data dumping right now
  keg_message = String.new  
  resp = Kegbot.new.kegs({:status => 'online'})
  resp['result']['kegs'].each do |keg|
    if keg['status'] == 'online'
      keg_message = "A #{keg['size_name']} of #{keg['description']}"
    end
  end
  return keg_message
end

Net::TOC.new(AIM_USERNAME, AIM_PASSWORD) do |msg, buddy|
  # Clean up the incoming message
  msg = msg.chomp.gsub(/<[^>]+>/,"")

  # Log the buddy name, message, and time
  p "#{buddy}: #{msg} at #{Time.now}"

  # Intro message, only show if it's a newish IM  
  if !buddies.has_key?(buddy) #&& buddies[buddy] < Time.now - 60*20 #twenty minues ago
    buddy.send_im "Hi, I'm the #{COMPANY_NAME} #{KEGERATOR_NAME}, I can tell you about the beers I have on tap."
    buddy.send_im translate_message('help')
  else
    buddy.send_im translate_message(msg)
  end 

  # Save last message time for buddy
  buddies[buddy] = Time.now
end