# typed: strict
module ValidationConstants
  extend T::Sig

  MINIMUM_NAME_LENGTH = T.let(5, Integer)
  MAXIMUM_NAME_LENGTH = T.let(50, Integer)
end
