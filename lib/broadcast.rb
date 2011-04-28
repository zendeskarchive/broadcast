require 'logger'
require 'hashie'

class Broadcast
  
  VERSION = "0.1.0"
  
  ROOT    = File.dirname(__FILE__)
  
  class << self
    attr_accessor :logger
    attr_accessor :configuration
  end
  
  # Basic configuration object
  require 'broadcast/config'
  self.configuration = Broadcast::Config.new
  
  # Default
  self.logger = Logger.new($stdout)
    
  def self.publish(type, options = {})
    name = type.to_s.strip.split("_").collect(&:capitalize).join('')
    message = Broadcast::Message.const_get(name).new
    message.publish
    message
  end
  
  def self.setup(&block)
    block.call(self.configuration)
  end
  
end

require 'broadcast/medium'
require 'broadcast/message'