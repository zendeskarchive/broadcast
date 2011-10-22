namespace "broadcast" do

  namespace "authorize" do

    desc "Authorize Broadcast with Yammer and get access token information"
    task "yammer" do
      require 'broadcast'
      Broadcast::Medium::Yammer.new.authorize
    end

    desc "Authorize Broadcast with Twitter and get access token information"
    task "twitter" do
      require 'broadcast'
      Broadcast::Medium::Twitter.new.authorize
    end

    desc "Authorize Broadcast with Tumblr and get access token information"
    task "tumblr" do
      require 'broadcast'
      Broadcast::Medium::Tumblr.new.authorize
    end

  end

end
