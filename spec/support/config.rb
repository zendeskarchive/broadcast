Broadcast.setup { |config|
  config.spec.option = 1

  config.oauth { |oauth|
    oauth.consumer_key    = 'consumerkey'
    oauth.consumer_secret = 'consumersecret'
    oauth.access_token    = 'accesstoken'
    oauth.access_secret   = 'accesssecret'
  }

  config.jabber { |jabber|
    jabber.username       = 'foo@foo.com'
    jabber.password       = 'mypass'
    jabber.recipients     = 'mike@foo.com'
  }

  config.email { |email|
    email.recipients       = ['foo@moo.com']
    email.delivery_method  = :test
    email.delivery_options = {
      :address => "smtp.gmail.com",
      :port                 => 587,
      :domain               => 'your.host.name',
      :user_name            => '<username>',
      :password             => '<password>',
      :authentication       => 'plain',
      :enable_starttls_auto => true
    }
  }

  config.campfire { |campfire|
    campfire.subdomain = 'myaccount'
    campfire.token     = 'token'
    campfire.room      = 'My Room'
  }

  config.irc { |irc|
    irc.username = 'foo'
    irc.server = 'irc.freenode.net'
    irc.port = '6667'
    irc.channel = 'broadcast'
  }
}
