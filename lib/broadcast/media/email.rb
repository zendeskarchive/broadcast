require 'mail'
class Broadcast::Medium::Email < Broadcast::Medium::Oauth

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
        mail.delivery_method options.delivery_method, options.delivery_options || {}
      end
      mail.deliver
    end
  end
  
end