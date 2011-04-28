require 'spec_helper'

describe Broadcast::Medium::Campfire do

  describe '#publish' do
    
    before do
      @medium  = Broadcast::Medium::Campfire.new
      @message = Broadcast::Message::SpecWithContent.new
    end
    
    it "should send a post request to the campfire API with the message body" do
      Broach.should_receive(:speak).with("My Room", 'message')
      @medium.publish(@message)
    end
    
  end

end 
