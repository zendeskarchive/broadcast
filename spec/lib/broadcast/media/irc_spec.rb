require 'spec_helper'

describe Broadcast::Medium::Irc do

  describe '.new' do

    it "should create a new instance with options provided in config" do
      medium  = Broadcast::Medium::Irc.new
      medium.options.username.should == 'foo'
      medium.options.server.should == 'irc.freenode.net'
      medium.options.port.should == '6667'
      medium.options.channel.should == 'broadcast_test'
    end

  end

  describe '#publish' do

    before do
      @medium  = Broadcast::Medium::Irc.new
      @message = Broadcast::Message::SpecWithContent.new
    end

    it "should send the message to IRC channels with the message body" do
      ShoutBot.should_receive(:shout).with("irc://foo@irc.freenode.net:6667/#broadcast_test")
      @medium.publish(@message)
    end

  end

end
