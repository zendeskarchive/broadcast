require 'rails/railtie'
class Broadcast
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'broadcast/tasks/broadcast.rake'
    end
  end
end