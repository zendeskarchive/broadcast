# This integration was originally prepared by https://github.com/hmaddocks
require 'net/http'

class Broadcast::Medium::Tumblr < Broadcast::Medium::Oauth

  self.site = "http://www.tumblr.com"

  def publish(message)
    @consumer = OAuth::Consumer.new(options.consumer_key,
                                    options.consumer_secret,
                                    :site => "http://api.tumblr.com")

    params = {
      "state"     => "published",
      "title"     => message.subject,
      "body"      => message.body,
    }

    token.post "/v2/blog/#{options.hostname}/post", params
  end

end