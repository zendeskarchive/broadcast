require 'smsified'

class Broadcast::Medium::Sms < Broadcast::Medium::Oauth

 def publish(message)
   
   oneapi = Smsified::OneAPI.new :username => options.username,
                                    :password => options.password

   oneapi.send_sms :address => options.to,
                      :message => message.body,
                      :sender_address => options.from
   
 end

end
