require 'rubygems'
require 'bundler/setup'
require 'koala'
require 'yaml'

config = YAML.load_file(File.join(File.dirname(__FILE__), 'config.yml'))

def post_to_page_wall(message, token, page_name)
  graph = Koala::Facebook::GraphAPI.new(token)
  me    = graph.get_object('me')
  raise 'User not found' if !me
  connections = graph.get_connections(me['id'], 'accounts')
  page = connections.find { |connection| connection['name'] == page_name }
  raise 'Page not found' if !page
  page_graph = Koala::Facebook::GraphAPI.new(page['access_token'])
  page_graph.put_wall_post(message)
end

post_to_page_wall("Foo oh yeah 1234", config['token'], config['page'])
