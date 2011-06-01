require 'spec_helper'

describe Broadcast::Medium::Facebook do

  describe '.new' do

    it "should create a new instance with options provided in config" do
      medium  = Broadcast::Medium::Facebook.new
      medium.options.token.should == 'fb_token'
      medium.options.page.should == 'My Page'
    end

    it "should prioritize options argument over options provided in config" do
      medium  = Broadcast::Medium::Facebook.new(:page => 'Different Page')
      medium.options.token.should == 'fb_token'
      medium.options.page.should == 'Different Page'
    end

  end

  describe '#publish' do

    before do
      @medium  = Broadcast::Medium::Facebook.new
      @message = Broadcast::Message::SpecWithChagingContent.new
      @me = {"name"=>"Your Name", "username"=>"yourname", "timezone"=>0, "gender"=>"male", "id"=>"1", "last_name"=>"Name", "updated_time"=>"2011-06-01T17:29:02+0000", "verified"=>true, "locale"=>"en_US", "hometown"=>{"name"=>"Palo Alto", "id"=>"1"}, "link"=>"http://www.facebook.com/yourname", "first_name"=>"Your"}
      @connections = [{"name"=>"My Page", "category"=>"Software", "id"=>"123", "access_token"=>"page_access_token"}]
    end

    it "should send the message to a Facebook page" do
      mock_graph = mock
      mock_page_graph = mock
      Koala::Facebook::GraphAPI.should_receive(:new).with('fb_token').and_return(mock_graph)
      Koala::Facebook::GraphAPI.should_receive(:new).with('page_access_token').and_return(mock_page_graph)
      mock_graph.should_receive(:get_object).with('me').and_return(@me)
      mock_graph.should_receive(:get_connections).with('1', 'accounts').and_return(@connections)

      mock_page_graph.should_receive(:put_wall_post).with(@message.body)
      @medium.publish(@message)
    end

    it "should raise an error when no pages are available" do
      mock_graph = mock
      mock_page_graph = mock
      Koala::Facebook::GraphAPI.should_receive(:new).with('fb_token').and_return(mock_graph)
      mock_graph.should_receive(:get_object).with('me').and_return(@me)
      mock_graph.should_receive(:get_connections).with('1', 'accounts').and_return([])

      lambda { @medium.publish(@message) }.should raise_error('No pages available')
    end

    it "should raise an error when no page was not found" do
      mock_graph = mock
      mock_page_graph = mock
      Koala::Facebook::GraphAPI.should_receive(:new).with('fb_token').and_return(mock_graph)
      mock_graph.should_receive(:get_object).with('me').and_return(@me)

      @connections.first['name'] = 'Different name'
      mock_graph.should_receive(:get_connections).with('1', 'accounts').and_return(@connections)

      lambda { @medium.publish(@message) }.should raise_error('Page not found')
    end

  end

end
