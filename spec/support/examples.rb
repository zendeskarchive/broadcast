class Broadcast::Message::Spec < Broadcast::Message
end

class Broadcast::Message::SpecWithContent < Broadcast::Message
  def body
    "message"
  end
end

class Broadcast::Medium::Spec < Broadcast::Medium
end
