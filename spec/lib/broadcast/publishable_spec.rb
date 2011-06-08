require 'spec_helper'

class ClassToBecomeMessage
  include Broadcast::Publishable

  attr_accessor :something

  def initialize(somthng = nil)
    self.something = somthng
  end

end

describe Broadcast::Publishable do

  describe "in class scope" do

    it "should add the media accessor" do
      ClassToBecomeMessage.should respond_to(:media)
      ClassToBecomeMessage.should respond_to(:media=)
    end

    it "should add the medium method" do
      ClassToBecomeMessage.should respond_to(:medium)
    end

  end

  describe "in instance scope" do

    before {
      @instance = ClassToBecomeMessage.new(123)
    }
    it "should add the publish method" do
      @instance.should respond_to(:publish)
    end

    it "should add the subject method" do
      @instance.should respond_to(:subject)
    end

    it "should add the body method" do
      @instance.should respond_to(:body)
    end

    it "should not add the options accessor" do
      @instance.should_not respond_to(:options)
      @instance.should_not respond_to(:options=)
    end

    it "should not mess with the initializer" do
      ClassToBecomeMessage.new(123).something.should == 123
    end

  end

end
