require 'spec_helper'

describe Broadcast::Medium::Tumblr do

  describe '.site' do

    it "should be set to Tumblr OAuth endpoint" do
      Broadcast::Medium::Tumblr.site.should == "http://www.tumblr.com"
    end

  end

  describe '#publish' do

    it "should send a post to twitter with the message body" do
      message = Broadcast::Message::SpecWithContentAndSubject.new
      medium  = Broadcast::Medium::Tumblr.new
      token   = mock
      params = {
        "state"     => "published",
        "title"     => "title",
        "body"      => "message",
      }
      token.should_receive(:post).with("/v2/blog/spec.tumblr.com/post", params)
      medium.should_receive(:token).and_return(token)
      medium.publish(message)
    end

  end

end
