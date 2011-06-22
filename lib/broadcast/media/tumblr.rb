require 'net/http'

class Broadcast::Medium::Tumblr < Broadcast::Medium

  def publish(message)
    tumblr_url = URI.parse "http://www.tumblr.com"
    upload_path = "/api/write"
    
    app_params     = {"generator" => "Broadcast Gem"}
    user_params    = {"email" => options.email, "password" => options.password}
    publish_params = {"state" => "published"}
    post_params    = {"title" => message.subject, "body" => message.body, "type" => "regular"}
#     tumblelog_params = {'group' => "#{options.group}.tumblr.com"}
  
    params = user_params.merge(post_params).merge(publish_params).merge(user_params).merge(app_params)

    query = params.collect {|k, v| "#{k}=#{v}"}.join('&')
  
    resp = nil
    Net::HTTP.start(tumblr_url.host, tumblr_url.port) do |http|
      resp = http.post upload_path, query
    end
  
    raise StandardError, resp.body if resp.code.to_i != 201
  end
  
end
