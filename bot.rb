require 'rubygems'
require 'net/toc'
require 'config'
require 'kegbot'

buddies = Hash.new

def translate_message(msg)
  case msg
  when 'help'
    return "You asked for help. Too bad I can't help you"
  when ['hey', 'hello', 'hi', 'yo']
    return "Howdy partner"
  else
    return "no comprende"  
  end
end

Net::TOC.new(AIM_USERNAME, AIM_PASSWORD) do |msg, buddy|
  # Clean up the incoming message
  msg = msg.chomp.gsub(/<[^>]+>/,"")

  # Log the buddy name, message, and time
  p "#{buddy}: #{msg} at #{Time.now}"

  # Intro message, only show if it's a newish IM  
  unless buddies.has_key?(buddy) #&& buddies[buddy] < Time.now - 60*20 #twenty minues ago
    buddy.send_im "Hi, I'm the #{COMPANY_NAME} #{KEGERATOR_NAME}, I can tell you about the beers I have on tap."
    # buddy.send_im "Type the <b>name of a beer</b> and I'll tell you more about it."
    buddy.send_im "Type <b>help</b> and I'll tell you more about what I can do."
  end 
  
  buddy.send_im translate_message(msg)
  
  # Query kegbot API for list of all kegs
  keg_message = String.new  
  resp = Kegbot.new.kegs({:status => 'online'})
  resp['result']['kegs'].each do |keg|
    keg_message +=  "A #{keg['size_name']} of #{keg['description']}"
  end  
  buddy.send_im "We've got #{resp['result']['kegs']} kegs right now."
  buddy.send_im keg_message

  # Save last message time for buddy
  buddies[buddy] = Time.now
end