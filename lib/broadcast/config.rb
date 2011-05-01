class Broadcast::Config

  # Allow usage of namespaces in config
  def method_missing(meth, *args, &block)
    @namespaces ||= {}
    stringified = meth.to_s
    if stringified[-1].chr == '=' and args.first
      key = stringified[0..-2].to_sym
      @namespaces[key] = args.first
    elsif block
      key = stringified[0..-1].to_sym
      @namespaces[key] ||= Hashie::Mash.new
      block.call(@namespaces[key])
    else
      key = stringified[0..-1].to_sym
      @namespaces[key] ||= Hashie::Mash.new
    end
  end

end
