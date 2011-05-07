$:.push File.expand_path("../../lib", __FILE__)
require 'broadcast'
require 'rspec'

$:.push File.expand_path("../..", __FILE__)
Dir.glob('spec/support/*').each { |f| require f }
