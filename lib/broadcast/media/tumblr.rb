class Broadcast::Medium::Tumblr < Broadcast::Medium::Oauth

  def publish(message)
    tumblr_url = URI.parse "http://www.tumblr.com"
    upload_path = "/api/write"
    
    user_params    = {"email" => options.email, "password" => options.password, "generator" => "Broadcast Gem"}
    publish_params = {"state" => "published"}
    post_params    = {"title" => message.subject, "body" => message.body, "type" => "regular"}.merge(publish_params)
#     tumblelog_params = {'group' => "#{options.group}.tumblr.com"}
  
    params = tumblelog_params.merge(user_params).merge(post_params)

    query = params.collect {|k, v| "#{k}=#{v}"}.join('&')
  
    resp = nil
    Net::HTTP.start(tumblr_url.host, tumblr_url.port) do |http|
      resp = http.post upload_path, query
    end
  
    raise APIException.new(resp.body, resp.code.to_i) if resp.code.to_i != 201
  end
  
end
