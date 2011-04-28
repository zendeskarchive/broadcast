require 'broach'

class Broadcast::Medium::Campfire < Broadcast::Medium::Oauth
  
  def publish(message)    
    Broach.settings = { 'account' => options.subdomain, 'token' => options.token, 'use_ssl' => true }
    Broach.speak(options.room, message.body)
  end
  
end