require 'spec_helper'

describe Broadcast::Medium::Oauth do

  before do
    Broadcast::Medium::Oauth.site            = nil
  end
  
  describe '.consumer' do
    
    before do
      Broadcast::Medium::Oauth.site            = 'http://site.com'
    end

    it "should return consumer object with proper keys and site" do
      consumer = Broadcast::Medium::Oauth.new.consumer
      consumer.should be_an_instance_of(OAuth::Consumer)
      consumer.key.should == 'consumerkey'
      consumer.secret.should == 'consumersecret'
    end
    
    it "should memoize the consumer object" do
      medium   = Broadcast::Medium::Oauth.new
      consumer = medium.consumer
      medium.consumer.object_id.should == consumer.object_id
    end
    
  end
  
  describe '#token' do
    
    before do
      Broadcast::Medium::Oauth.site = 'http://site.com'
    end
    
    it "should return access token object with proper access token keys" do
      token = Broadcast::Medium::Oauth.new.token
      token.should be_an_instance_of(OAuth::AccessToken)
      token.token.should  == 'accesstoken'
      token.secret.should == 'accesssecret'
    end
    
    it "should memoize the access token" do
      medium = Broadcast::Medium::Oauth.new
      token = medium.token
      medium.token.object_id.should == token.object_id
    end
    
    it "should prioritize options argument over class level options" do
      token = Broadcast::Medium::Oauth.new(:access_token => 'overridetoken', :access_secret => 'overridesecret').token
      token.should be_an_instance_of(OAuth::AccessToken)
      token.token.should == 'overridetoken'
      token.secret.should == 'overridesecret'      
    end
    
  end
   
  describe '.authorize' do
    
    before do
      Broadcast.configuration.oauth.consumer_key    = nil
      Broadcast.configuration.oauth.consumer_secret = nil
      Broadcast::Medium::Oauth.site            = 'http://site.com'
      
      medium = Broadcast::Medium::Oauth.new
      
      @request_token = mock
      @stdout = StringIO.new
      @old_stdout, $stdout = $stdout, @stdout

      $stdin.should_receive(:gets).and_return('consumerkey123')
      $stdin.should_receive(:gets).and_return('consumersecret123')
      $stdin.should_receive(:gets).and_return('12342')
      
      @request_token.should_receive(:authorize_url).and_return('http://foo.com/1234')
      medium.consumer.stub!(:get_request_token).and_return(@request_token)
      
      @access_token  = mock(:token => '6789', :secret => '3456')
      @request_token.should_receive(:get_access_token).and_return(@access_token)

      medium.authorize

      medium.options.consumer_key.should == 'consumerkey123'
      medium.options.consumer_secret.should == 'consumersecret123'
      $stdout = @old_stdout
      @stdout.rewind
    end
    
    it "should use the request token to get the url the user goes to" do
      @stdout.read.should match('http://foo.com/1234')
    end
    
    it "should get the oauth_verifier from the user" do
      @stdout.read.should match('Enter token')
    end
        
    it "should print out the lines the user should put in the config file" do
      out = @stdout.read
      out.should match('Put the following in your Broadcast configuration file:')
      out.should match('config.oauth.consumer_key')
      out.should match('config.oauth.consumer_secret')
      out.should match('config.oauth.access_token')
      out.should match('config.oauth.access_secret')
    end
    
  end
   
end