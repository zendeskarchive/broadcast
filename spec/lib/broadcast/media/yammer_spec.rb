require 'spec_helper'

describe Broadcast::Medium::Yammer do
  
  describe '.site' do
    
    it "should be set to Yammer OAuth endpoint" do
      Broadcast::Medium::Yammer.site.should == 'https://www.yammer.com'
    end
    
  end
  
  describe '#publish' do
    
    it "should send a post to yammer with the message body" do      
      message = Broadcast::Message::SpecWithContent.new
      medium  = Broadcast::Medium::Yammer.new
      token   = mock
      token.should_receive(:post).with("/api/v1/messages.json", { :body=>"message" })
      medium.should_receive(:token).and_return(token)
      medium.publish(message)
    end
    
  end
  
end