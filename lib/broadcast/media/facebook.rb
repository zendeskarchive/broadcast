require 'koala'

class Broadcast::Medium::Facebook < Broadcast::Medium

  def publish(message)
    # We do not rescue any Koala exceptions to make them crash the sendout
    # This should make debugging easier i.e. when fb has privilege issues

    # Connect to facebook and get info about current user
    graph       = Koala::Facebook::GraphAPI.new(options.token)
    me          = graph.get_object('me')
    # Get the connections to retrieve the appropriate page
    connections = graph.get_connections(me['id'], 'accounts')
    raise "No pages available" if connections.size == 0

    # Find the page to post to
    page        = connections.find { |connection| connection['name'] == options.page }
    raise 'Page not found' if !page

    # Create a new graph so that the page posts to itself
    page_graph = Koala::Facebook::GraphAPI.new(page['access_token'])
    page_graph.put_wall_post(message.body)
  end

end
