require 'spec_helper'

describe Broadcast::Medium::Log do

  before do
    Broadcast.configuration.log.file = nil
  end
  
  describe '#publish' do
    
    it "should send message to logfile if it was defined on class level" do
      log = StringIO.new
      Broadcast.configuration.log.file = log
      message = Broadcast::Message::SpecWithContent.new
      Broadcast::Medium::Log.new.publish(message)
      log.rewind
      log.read.should match(message.body)
    end
    
    it "should send message to logfile if it was defined in options" do
      log = StringIO.new
      message = Broadcast::Message::SpecWithContent.new
      Broadcast::Medium::Log.new(:file => log).publish(message)
      log.rewind
      log.read.should match(message.body)
    end
    
    it "should look at options first before class when looking for file" do
      log_default = StringIO.new
      log_options = StringIO.new
      Broadcast.configuration.log.file = log_default
      
      message = Broadcast::Message::SpecWithContent.new
      Broadcast::Medium::Log.new(:file => log_options).publish(message)
      log_options.rewind
      log_options.read.should match(message.body)
      log_default.rewind
      log_default.read.should == ''
    end
    
  end
  
end