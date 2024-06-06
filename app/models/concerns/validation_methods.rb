# typed: strict
module ValidationMethods
  include Kernel

  extend T::Sig

  sig { params(attribute: Symbol).void }
  def strip_whitespace(attribute)
    value = send(attribute)
    send("#{attribute}=", value.strip) if value.present?
  end
end
