require 'rubygems'
require 'httparty'
require 'config'

class Kegbot
  include HTTParty
  format :json
  base_uri KEGBOT_API_URL
  
  def kegs(attrs={})
    self.class.get('/kegs')
  end
end