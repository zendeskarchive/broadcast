require 'spec_helper'

describe Broadcast::Message::Simple do

  before do
    @message = Broadcast::Message::Simple.new(:body => 'my body', :subject => 'OMG!')
  end

  describe ".initialize" do

    it "should accept options" do
      Broadcast::Message::Simple.new(:body => 'my body', :subject => 'OMG!')
    end

  end

  describe "#body and #subject accessors" do

    describe "#body" do

      it "should be the value sent to the initializer" do
        @message.body.should == 'my body'
      end

    end

    describe "#body=" do

      it "should allow changing the value of body dynamically" do
        @message.body = 'updated body'
        @message.body.should == 'updated body'
      end

    end

    describe "#subject" do

      it "should be the value sent to the initializer" do
        @message.subject.should == 'OMG!'
      end

    end

    describe "#subject=" do

      it "should be the value sent to the initializer" do
        @message.subject = 'LOL'
        @message.subject.should == 'LOL'
      end

    end

  end

  describe '#publish' do

    it "should explode when no media is supplied" do
      lambda {
        @message.publish
      }.should raise_error(ArgumentError)
    end

    it "should publish to the media passed as first argument" do
      mocked = mock
      mocked.should_receive(:publish).with(@message)
      Broadcast::Medium::Log.should_receive(:new).and_return(mocked)
      @message.publish :log
    end

    it "should override media settings if provided as second argument" do
      mocked = mock
      mocked.should_receive(:publish).with(@message)
      Broadcast::Medium::Log.should_receive(:new).with(:file => 'different.log').and_return(mocked)
      @message.publish :log, :file => 'different.log'
    end

  end

end
