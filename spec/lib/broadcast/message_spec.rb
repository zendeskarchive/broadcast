require 'spec_helper'

describe Broadcast::Message do

  before do
    Broadcast::Message::Spec.media = []
    @log = StringIO.new
    Broadcast.logger = Logger.new(@log)
  end

  describe ".initialize" do

    it "should accept options" do
      msg = Broadcast::Message::Spec.new(:foo => 1)
      msg.options.foo.should == 1
    end

  end

  describe ".medium" do

    it "should add a medium to media" do
      Broadcast::Message::Spec.medium :spec
      Broadcast::Message::Spec.media.size.should == 1
      Broadcast::Message::Spec.media.first[:name].should == :spec
    end

    it "should allow adding of options" do
      Broadcast::Message::Spec.medium :spec, :option => 1
      Broadcast::Message::Spec.media.size.should == 1
      Broadcast::Message::Spec.media.first[:name].should == :spec
      Broadcast::Message::Spec.media.first[:options].should == { :option => 1 }
    end

  end

  describe "#body" do

    it "should be empty by default" do
      Broadcast::Message::Spec.new.body.should == ''
    end

  end

  describe '#publish' do

    it "should properly load all media of the message" do
      Broadcast::Message::Spec.medium :spec
      Broadcast::Message::Spec.new.publish
    end

    it "should properly instantiate all media of the message" do
      medium = mock
      medium.should_receive(:publish)
      Broadcast::Medium::Spec.should_receive(:new).once.and_return(medium)
      Broadcast::Message::Spec.medium :spec
      Broadcast::Message::Spec.new.publish
    end

    it "should send to logger if medium instantiation fails" do
      medium = mock
      medium.should_receive(:publish).and_raise 'Some Exception'
      Broadcast::Medium::Spec.should_receive(:new).once.and_return(medium)
      Broadcast::Message::Spec.medium :spec
      lambda {
        Broadcast::Message::Spec.new.publish
      }.should_not raise_error
      @log.rewind
      @log.read.should match('Publishing of Broadcast::Message::Spec to spec failed:\nSome Exception')
    end

  end

end
