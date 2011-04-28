require 'spec_helper'

describe Broadcast::Medium::Email do

  describe '#publish' do

    before {
      @medium  = Broadcast::Medium::Email.new
      @message = Broadcast::Message::SpecWithContent.new
      Mail::TestMailer.deliveries = []
    }
    
    it "should deliver the message to one recipient if options.recipients is a string" do
      @medium.publish(@message)
      Mail::TestMailer.deliveries.size.should == 1
      Mail::TestMailer.deliveries.first.to.should == ['foo@moo.com']
    end
    
    it "should deliver the message to many recipients if options.recipients is a array" do
      @medium.options.recipients = ['mike@foo.com', 'tom@foo.com']
      @medium.publish(@message)
      Mail::TestMailer.deliveries.size.should == 2
      Mail::TestMailer.deliveries.first.to.should == ['mike@foo.com']
      Mail::TestMailer.deliveries.last.to.should   == ['tom@foo.com']
    end
    
    it "should properly get delivery_options and set delivery method" do
      @medium.options.delivery_method = :smtp
      mail = Mail.new
      # 'nueter' the mail instance
      def mail.deliver; end
      Mail.should_receive(:new).and_return(mail)
      @medium.publish(@message)
      mail.delivery_method.settings['user_name'].should == '<username>'
      mail.delivery_method.settings['password'].should == '<password>'
      mail.delivery_method.settings['address'].should == 'smtp.gmail.com'
    end
    
  end
  
end
