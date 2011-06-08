require 'spec_helper'

class ClassToBecomeMessage
  include Broadcast::Publishable

  attr_accessor :something

  def initialize(somthng)
    self.something = somthng
  end

end

describe Broadcast::Publishable do

  describe "in class scope" do

    it "should add the media accessor" do
      ClassToBecomeMessage.methods.should include('media')
      ClassToBecomeMessage.methods.should include('media=')
    end

    it "should add the medium method" do
      ClassToBecomeMessage.methods.should include('medium')
    end

  end

  describe "in instance scope" do

    it "should add the publish method" do
      ClassToBecomeMessage.public_instance_methods.should include('publish')
    end

    it "should add the subject method" do
      ClassToBecomeMessage.public_instance_methods.should include('subject')
    end

    it "should add the body method" do
      ClassToBecomeMessage.public_instance_methods.should include('body')
    end

    it "should not add the options accessor" do
      ClassToBecomeMessage.public_instance_methods.should_not include('options')
      ClassToBecomeMessage.public_instance_methods.should_not include('options=')
    end

    it "should not mess with the initializer" do
      ClassToBecomeMessage.new(123).something.should == 123
    end

  end

end
