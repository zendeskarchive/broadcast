require 'spec_helper'

describe Broadcast::Medium::Sms do

  describe '.new' do

    it "should create a new instance with options provided in config" do
      medium  = Broadcast::Medium::Sms.new
      medium.options.username.should == 'myaccount'
      medium.options.password.should == 'mypass'
      medium.options.to.should == '22222222222'
    end

    it "should prioritize options argument over options provided in config" do
      medium  = Broadcast::Medium::Sms.new(:to => '33333333333')
      medium.options.username.should == 'myaccount'
      medium.options.password.should == 'mypass'
      medium.options.to.should == '33333333333'
    end

  end

  describe '#publish' do

    before do
      @mock_client = mock
      Smsified::OneAPI.should_receive(:new).with(:username => 'myaccount', :password => 'mypass').and_return(@mock_client)
    end

    it "should send the sms" do
      message = Broadcast::Message::SpecWithContent.new
      @mock_client.should_receive(:send_sms).with({:message=>message.body, :sender_address=>"11111111111", :address=>"22222222222"})
      Broadcast::Medium::Sms.new.publish(message)
    end

  end

end
