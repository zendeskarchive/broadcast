# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "broadcast"

Gem::Specification.new do |s|
  s.name        = "broadcast"
  s.version     = Broadcast::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Marcin Bunsch"]
  s.email       = ["marcin@futuresimple.com"]
  s.homepage    = "http://github.com/futuresimple/broadcast"
  s.summary     = %q{A broadcasting microframework making publishing of messages to different services easy}
  s.description = %q{A broadcasting microframework making publishing of messages to different services easy}

  s.add_dependency 'hashie'
  
  # 'Externalable' dependencies
  s.add_dependency 'oauth'
  s.add_dependency 'xmpp4r'
  s.add_dependency 'mail'
  s.add_dependency 'broach'
  s.add_dependency 'shout-bot'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
