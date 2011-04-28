require 'spec_helper'

ORIGINAL_CONFIG = Broadcast.configuration

describe Broadcast do

  describe '.publish' do
        
    it "should properly load the message class and instantiate the message" do
      msg = mock(:publish => true)
      Broadcast::Message::Spec.should_receive(:new).once.and_return(msg)
      Broadcast.publish(:spec)
    end
    
    it "should properly load the message class if in camelcase and instantiate the message" do
      msg = mock(:publish => true)
      Broadcast::Message::SpecWithContent.should_receive(:new).once.and_return(msg)
      Broadcast.publish(:spec_with_content)      
    end
    
    it "should call publish on the message" do
      msg = mock
      msg.should_receive(:publish)
      Broadcast::Message::Spec.should_receive(:new).once.and_return(msg)
      Broadcast.publish(:spec)
    end
    
  end
  
  describe '.setup' do
    
    before {
      Broadcast.configuration = ORIGINAL_CONFIG
    }
    
    it "should allow setting of single settings" do
      Broadcast.setup { |config| 
        config.some_setting = 1 
      }
      Broadcast.configuration.should be_an_instance_of(Broadcast::Config)
      Broadcast.configuration.some_setting.should == 1
    end

    it "should allow setting of namespaced settings" do
      Broadcast.setup { |config| 
        config.log.some_setting = 1 
      }
      Broadcast.configuration.log.should be_an_instance_of(Hashie::Mash)
      Broadcast.configuration.log.some_setting.should == 1
    end
    
    it "should allow setting of namespaced settings using a block" do
      Broadcast.setup { |config| 
        config.log { |log|
          log.file  = "foo.log"
          log.color = 'red'
        }
      }
      Broadcast.configuration.log.should be_an_instance_of(Hashie::Mash)
      Broadcast.configuration.log.file.should  == 'foo.log'
      Broadcast.configuration.log.color.should == 'red'
    end
    
  end
    
end