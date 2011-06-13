class Broadcast::Message::Simple < Broadcast::Message

  attr_accessor :body, :subject

  def body
    @body || options.body
  end

  def subject
    @subject || options.subject
  end

  def publish(medium, medium_arguments = {})
    begin
      Broadcast::Medium.const_get(medium.to_s.downcase.capitalize).new(medium_arguments).publish(self)
    rescue
      Broadcast.logger.error "Publishing of #{self.class.name} to #{medium[:name]} failed:\n#{$!}"
    end
  end

end
