require 'rubygems'
require 'net/toc'

Net::TOC.new("retardomontlbn", "291649") do |msg, buddy|
  msg = msg.chomp.gsub(/<[^>]+>/,"")
  p "message #{msg} received from #{buddy}"
  
  if !msg.index(/[hey|hello|hi]/).nil?
    buddy.send_im "yo, sup?"
  elsif msg.include? 'beer'
    buddy.send_im("ah you'd like some beer.")
    if msg.index.(/[kind|tap]/)
      buddy.send_im("there's an angry eel porter, slutty sweatty betty, an ipa")
    end
  elsif
    buddy.send_im("I'm not very smart, I don't understand")
  end
end