# Module which allows any class to be turned into a message
module Broadcast::Publishable

  attr_accessor :options

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods

    attr_accessor :media

    def medium(name, options = {})
      self.media ||= []
      self.media.push({ :name => name, :options => options })
    end

  end

  def initialize(options = {})
    @options = Hashie::Mash.new(options)
  end

  def publish
    (self.class.media || []).each do |medium|
      begin
        Broadcast::Medium.const_get(medium[:name].to_s.downcase.capitalize).new(medium[:options]).publish(self)
      rescue
        Broadcast.logger.error "Publishing of #{self.class.name} to #{medium[:name]} failed:\n#{$!}"
      end
    end
  end

  def subject
  end

  def body
    ""
  end

end
