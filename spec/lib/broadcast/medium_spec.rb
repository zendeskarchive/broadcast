require 'spec_helper'

describe Broadcast::Medium do

  describe '#publish' do

    before do
      @medium  = Broadcast::Medium::Spec.new
      @message = Broadcast::Message::Spec.new
    end

    it "should properly load options" do
      @medium.options.option.should == 1
    end

    it "should accept 1 argument" do
      lambda {
        @medium.publish(@message)
      }.should_not raise_error(ArgumentError)
    end

  end

end
