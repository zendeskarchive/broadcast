class Broadcast::Medium::Yammer < Broadcast::Medium::Oauth

  self.site = "https://www.yammer.com"

  def publish(message)
    token.post '/api/v1/messages.json', { :body => message.body }
  end

end
