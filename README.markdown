Broadcast
=========

A broadcasting microframework making publishing of messages to different services easy and DRY.

Use Cases
------------

Possible use cases include:

- publishing a update on your product Twitter feed
- notifying coworkers on Jabber of a deployment when it happens
- sending update on company IRC when a signup in your startup app happens
- publishing daily statistics to Yammer
- sending an email and a Jabber update when a specific threshold is reached (like number of users)

Installation
------------

Broadcast is in alpha state, so it's not pushed to RubyGems yet.

You can install it by adding the following line to your Gemfile:

    gem 'broadcast', :git => 'git://github.com/futuresimple/broadcast.git'

and running

    bundle install

Usage
-----

Broadcast has 2 main classes: Medium and Message (hat tip to Marshall McLuhan).

**Broadcast::Medium** is the service the message will be sent to, and **Broadcast::Message** is, well, the message.

The first thing you need to do is configuring the desired Media. For example, to configure jabber, put something like this in some configuration file (e.g. a Rails initializer):

```ruby
  Broadcast.setup do |config|
    config.jabber { |jabber|
      jabber.username       = 'foo@foo.com'
      jabber.password       = 'mypass'
      jabber.recipients     = 'mike@foo.com'
    }
  end
```

Now to send a message, you need to define Message class, like this:

```ruby
  class Poke < Broadcast::Message
    medium :jabber

    def body
      "Poke!"
    end
  end
```

When you're ready, just instantiate the Message class and call #publish:

```ruby
  Poke.new.publish
```

Delayed::Job
------------

Broadcast plays nicely with Delayed::Job. For example to publish a message in a delayed job, simply change the above example to:

```ruby
  Poke.new.delay.publish
```


Media
-----

Broadcast currently ships with support for following Media:

### Jabber

Broadcast::Medium::Jabber is based on the xmpp4r gem.

#### Example setup

```ruby
  Broadcast.setup do |config|
    config.jabber { |jabber|
      jabber.username       = 'myaccount@gmail.com'
      jabber.password       = 'mypass'
      jabber.recipients     = 'mike@foo.com'
    }
  end
```

### Email

Broadcast::Medium::Email is based on the mail gem.

#### Example setup

This is an example setup with smtp delivery method with Gmail

```ruby
  Broadcast.setup do |config|
    config.email { |email|
      email.recipients       = ['foo@moo.com']
      email.delivery_method  = :smtp
      email.delivery_options = {
        :address              => "smtp.gmail.com",
        :port                 => 587,
        :domain               => 'your.host.name',
        :user_name            => '<username>',
        :password             => '<password>',
        :authentication       => 'plain',
        :enable_starttls_auto => true
      }
    }
  end
```

### Twitter

Broadcast::Medium::Twitter is based on the oauth gem.
In order to use it, you will need a application registered on Twitter.

When you have it, run rake broadcast:authorize:twitter, which will help you get all the required keys and tokens.

#### Example setup

```ruby
  Broadcast.setup do |config|
    config.twitter { |twitter|
      twitter.consumer_key    = 'consumerkey'
      twitter.consumer_secret = 'consumersecret'
      twitter.access_token    = 'accesstoken'
      twitter.access_secret   = 'accesssecret'
    }
  end
```

### Yammer

Broadcast::Medium::Yammer is based on the oauth gem.
In order to use it, you will need a application registered on Yammer.

When you have it, run rake broadcast:authorize:yammer, which will help you get all the required keys and tokens.

#### Example setup

```ruby
  Broadcast.setup do |config|
    config.twitter { |yammer|
      yammer.consumer_key    = 'consumerkey'
      yammer.consumer_secret = 'consumersecret'
      yammer.access_token    = 'accesstoken'
      yammer.access_secret   = 'accesssecret'
    }
  end
```

### Log

Broadcast::Medium::Log is a simple writer to a log file

#### Example setup

```ruby
  Broadcast.setup do |config|
    config.log.file = 'log/broadcast.log'
  end
```

### Campfire

Broadcast::Medium::Campfire is based on the broach gem.

#### Example setup

```ruby
  Broadcast.setup do |config|
    config.campfire { |campfire|
      campfire.subdomain = 'myaccount'
      campfire.token     = 'token'
      campfire.room      = 'My Room'
    }
  end
```

### Irc

Broadcast::Medium::Irc employs the shout-bot gem.

#### Example setup

```ruby
  Broadcast.setup do |config|
    config.irc { |irc|
      irc.username = 'myusername',
      irc.server = 'irc.freenode.net',
      irc.port = '6667',
      irc.channel = 'mychannel',
    }
  end
```

Copyright
---------

Copyright (c) 2011 Marcin Bunsch, Future Simple Inc. See LICENSE for details.
