class Broadcast::Medium::Simple < Broadcast::Medium

  def body
    options.body
  end

  def subject
    options.subject
  end

  # TODO: implement publishing with ability to select medium on the fly

end
