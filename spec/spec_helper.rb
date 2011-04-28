$:.push File.expand_path("../../lib", __FILE__)
require 'broadcast'
require 'rspec'

Dir.glob('spec/support/*').each { |f| require f }
