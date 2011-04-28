require 'oauth'

class Broadcast::Medium::Oauth < Broadcast::Medium
    
  class << self
    attr_accessor :site
  end  
      
  def consumer
    @consumer ||= OAuth::Consumer.new(options.consumer_key, options.consumer_secret, :site => self.class.site)
  end
    
  def token
    @access_token ||= OAuth::AccessToken.new(consumer, options.access_token, options.access_secret)
  end
      
  def authorize
    unless options.consumer_key
      print "Enter consumer key: "
      options.consumer_key = $stdin.gets.chomp
    end
    unless options.consumer_secret
      print "Enter consumer secret: "
      options.consumer_secret = $stdin.gets.chomp
    end
    request_token = consumer.get_request_token
    puts "\nGo to this url and click 'Authorize' to get the token:"
    puts request_token.authorize_url 
    print "\nEnter token: "
    token = $stdin.gets.chomp

    access_token  = request_token.get_access_token(:oauth_verifier => token)

    puts "\nAuthorization complete! Put the following in your Broadcast configuration file:\n\n"    
    puts "Broadcast.setup do |config|\n\n"
    puts "  config.#{namespace}.consumer_key     = '#{consumer.key}'"
    puts "  config.#{namespace}.consumer_secret  = '#{consumer.key}'"
    puts "  config.#{namespace}.access_token     = '#{access_token.token}'"
    puts "  config.#{namespace}.access_secret    = '#{access_token.secret}'"
    puts "\nend"
  end
  
end