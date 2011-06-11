require 'rubygems'
require 'httparty'
require 'config'

class Kegbot
  include HTTParty
  format :json
  base_uri KEGBOT_API_URL
  
  def kegs
    self.class.get('/kegs')
  end
  
end

resp = Kegbot.new.kegs
resp['result']['kegs'].each do |keg|
  p keg
  if keg['status'] == 'online'
    p "A #{keg['size_name']} of #{keg['description']}"
  end
end