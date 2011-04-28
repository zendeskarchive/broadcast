class Broadcast::Medium::Log < Broadcast::Medium
    
  def publish(message)
    Logger.new(options.file).info(message.body)
  end
  
end