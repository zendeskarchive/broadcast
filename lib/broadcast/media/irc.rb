require 'shout-bot'

class Broadcast::Medium::Irc < Broadcast::Medium
  def publish(message)
    uri = "irc://#{options.username}"

    uri += "@#{options.server}:#{options.port ? options.port : '6667'}"
    uri += "/##{options.channel.to_s.gsub("#","") }"

    ShoutBot.shout(uri) { |room| room.say message }
  end
end
