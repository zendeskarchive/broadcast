require 'xmpp4r'

class Broadcast::Medium::Jabber < Broadcast::Medium

  class Client

    attr_accessor :client

    def initialize(username, password, server = nil, port = 5222)
      @jid    = Jabber::JID::new(username)
      @client = Jabber::Client::new(@jid)
      client.connect(server, port)
      client.auth(password)
    end

    def deliver(recipient, body)
      client.send Jabber::Message::new(recipient, body)
    end

  end

  def jabber
    @jabber ||= Client.new(options.username, options.password, options.server)
  end

  def publish(message)
    recipients = options.recipients.is_a?(Array) ? options.recipients : [options.recipients]
    recipients.compact.each do |recipient|
      jabber.deliver(recipient, message.body)
    end
  end

end
