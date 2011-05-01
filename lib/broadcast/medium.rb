class Broadcast::Medium

  # Set up autoload for the media
  Dir.glob(File.join(Broadcast::ROOT, 'broadcast', 'media', '*')).each do |file|
    name = File.basename(file).split('.').first
    autoload name.capitalize.to_sym, file
  end

  def initialize(options = {})
    # load in the configuration from Broadcast setup
    @options = Broadcast.configuration.send(namespace) || Hashie::Mash.new
    # Override the configuration using the supplied options
    @options = @options.merge(options)
  end

  def namespace
    @namespace ||= self.class.name.split('::').last.downcase.to_sym
  end

  def options
    @options
  end

  def publish(message)
  end

end
