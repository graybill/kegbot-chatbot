require 'rubygems'
require 'net/toc'
require 'config'

# require 'data' # some data file that's created from a form? or...
# Model beer hash
# beers = {
#   beer: {
#       name: 'awesome name',
#       type: 'ipa',
#       description: 'a little blurb from some beer site',
#       volume: 'what\'s left' #from the microcontroller
#   }
# }

buddies = Hash.new
beers = ['Angry Eel Porter', 'Sweaty Betty Wheat', 'Fancy Pants IPA']

Net::TOC.new(AIM_USERNAME, AIM_PASSWORD) do |msg, buddy|
  
  # Clean up the incoming message
  msg = msg.chomp.gsub(/<[^>]+>/,"")
  
  # Log the buddy name, message, and time
  p "#{buddy}: #{msg} at #{Time.now}"
  
  if msg.include? 'hey'
    buddy.send_im 'yo, sup'
  end
  
  # Save buddy and last timestamp message
  # Intro message, only show if it's a newish IM  
  unless buddies.has_key?(buddy) #&& buddies[buddy] < Time.now - 60*20 #twenty minues ago
    buddy.send_im "Hi, I'm the RedTettemer + Partners Kegerator, I can tell you about the beers I have on tap."
    buddy.send_im "On three taps we've got #{beers.map{|b| b + ", " }}."
    buddy.send_im "Type the <b>name of a beer</b> and I'll tell you more about it."
    buddy.send_im "Type <b>help</b> and I'll tell you more about what I can do."
  end
  
  if msg.include? 'help'
    buddy.send_im "<b>You stupid wanker. I can't do shit yet.</b>"
    buddy.send_im "We have: "
    beers.each do |b|
      buddy.send_im b
    end
    buddy.send_im "But "
  end

  # turn the beer name into an array and test the msg for each word
  if msg.include? 'ipa'
    buddy.send_im "Good choice. This IPA is made from awesome hops and has a 6% ABV."
  end
  if msg.include? 'porter'
    buddy.send_im "A porter. It's 8% ABV, I like the way you think."
  end
  if msg.include? 'bored'
    buddy.send_im "Yeah, me too. Is this interesting? some cool link from some API"
  end
  
  # Refactor to use buddy.send_im chatbot_response
  buddies[buddy] = Time.now
  p buddies[buddy]
  
end