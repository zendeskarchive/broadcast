Broadcast [![Build Status](http://travis-ci.org/futuresimple/broadcast.png)](http://travis-ci.org/futuresimple/broadcast)
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

You can install broadcast via Rubygems by typing:

    gem install broadcast

It you use bundler, you can install it by adding the following line to your Gemfile:

    gem 'broadcast'

and running

    bundle install

Usage
-----

Broadcast has 2 main classes: Medium and Message (hat tip to Marshall McLuhan).

**Broadcast::Medium** is the service the message will be sent to, and **Broadcast::Message** is, well, the message.

The first thing you need to do is to configure the desired Media. For example, to configure jabber, put something like this in some configuration file (e.g. a Rails initializer):

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

### Facebook

Broadcast::Medium::Facebook uses the koala gem. It is designed to publish messages to Facebook pages.
It is based on the assumption that the user associated with the access token has publishing access to the page.

#### Example setup

```ruby
  Broadcast.setup do |config|
    config.facebook { |facebook|
      facebook.token = 'facebook_access_token',
      facebook.page  = 'Name of the page to publish to'
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

### SMS

Broadcast::Medium::SMS is based on the SMSified gem.
You must create an account on http://smsified.com before sending SMS text messages (developer accounts are free).
You will be given a phone number to use as your very own FROM sms number. This number, along with your username and password, 
must be added to your config during setup.  The To address is the address of the mobile number that you would like to send the SMS message to.

#### Example setup

```ruby
  Broadcast.setup do |config|
    config.Sms { |sms|
      sms.username       = 'myaccount'
      sms.password       = 'mypass'
      sms.from		     = '16025551212'
      sms.to		     = '14801234567'
    }
  end
```

Copyright
---------

Copyright (c) 2011 Marcin Bunsch, Future Simple Inc. See LICENSE for details.
