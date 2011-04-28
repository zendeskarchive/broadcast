require 'spec_helper'

describe Broadcast::Medium::Jabber do

  # 'nueter' the Jabber::Client
  class Jabber::Client
    def connect(*args); end
    def auth(*args); end
    def send(*args); end
  end
  
  describe '::Client' do

    before {
      @client = Broadcast::Medium::Jabber::Client.new('foo@foo.com', '123')
    }
    
    describe '.new' do
      
      it "should create a new Jabber::Client and connect to jabber" do
        @client.client.should be_an_instance_of Jabber::Client
      end
      
    end

    describe 'deliver' do
      
      it "should use the client to send a message" do
        @client.client.should_receive(:send)
        @client.deliver('mike@foo.com', 'Hi')
      end
      
    end
    
  end

  describe '.new' do
    
    it "should create a new instance with options provided in config" do
      medium  = Broadcast::Medium::Jabber.new
      medium.options.username.should == 'foo@foo.com'
      medium.options.password.should == 'mypass'
    end
    
    it "should prioritize options argument options provided in config" do
      medium  = Broadcast::Medium::Jabber.new(:username => 'someoneelse@foo.com', :password => 'elsepass')
      medium.options.username.should == 'someoneelse@foo.com'
      medium.options.password.should == 'elsepass'  
    end
    
  end
  
  describe '#jabber' do
    
    it "should instantiate a new Broadcast::Medium::Jabber::Client instance" do
      jabber = Broadcast::Medium::Jabber.new.jabber
      jabber.should be_an_instance_of(Broadcast::Medium::Jabber::Client)
    end
    
    it "should memoize the Broadcast::Medium::Jabber::Client instance" do
      medium = Broadcast::Medium::Jabber.new
      jabber = medium.jabber
      medium.jabber.object_id.should == jabber.object_id      
    end
        
  end
  
  describe '#publish' do

    before {
      @medium  = Broadcast::Medium::Jabber.new(:username => 'foo@foo.com', :password => 'passkey')
      @message = Broadcast::Message::SpecWithContent.new
      @jabber  = mock
      @medium.stub!(:jabber).and_return(@jabber)
    }
    
    it "should deliver the message to one recipient if options.recipients is a string" do
      @jabber.should_receive(:deliver).with('mike@foo.com', "message")
      @medium.publish(@message)
    end
    
    it "should deliver the message to many recipients if options.recipients is a array" do
      @medium.options.recipients = ['mike@foo.com', 'tom@foo.com']
      @jabber.should_receive(:deliver).with('mike@foo.com', "message")
      @jabber.should_receive(:deliver).with('tom@foo.com', "message")
      @medium.publish(@message)
    end
    
  end
  
end