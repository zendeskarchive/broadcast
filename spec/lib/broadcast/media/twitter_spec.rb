require 'spec_helper'

describe Broadcast::Medium::Twitter do

  describe '.site' do

    it "should be set to TwitterO OAuth endpoint" do
      Broadcast::Medium::Twitter.site.should == 'http://api.twitter.com'
    end

  end

  describe '#publish' do

    it "should send a post to twitter with the message body" do
      message = Broadcast::Message::SpecWithContent.new
      medium  = Broadcast::Medium::Twitter.new
      token   = mock
      token.should_receive(:post).with("/1/statuses/update.json", {:status=>"message"})
      medium.should_receive(:token).and_return(token)
      medium.publish(message)
    end

  end

end
