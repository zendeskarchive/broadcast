require 'mail'

class Broadcast::Medium::Email < Broadcast::Medium

  def publish(message)
    recipients = options.recipients.is_a?(Array) ? options.recipients : [options.recipients]
    options = self.options
    recipients.compact.each do |recipient|
      mail = Mail.new do
         from    options.sender || message.class.to_s
         to      recipient
         subject message.subject || message.class.to_s
         body    message.body
      end
      if options.delivery_method
        # ensure the delivery options has symbolized keys
        # Addresses https://github.com/futuresimple/broadcast/issues/9
        delivery_options = options.delivery_options.inject({}) do |memo, setting|
          memo[setting[0].to_s.to_sym] = setting[1]
          memo
        end
        mail.delivery_method options.delivery_method, delivery_options || {}
      end
      mail.deliver
    end
  end

end
