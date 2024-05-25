# typed: strict
module Requests
  class SectorRequestDto
    extend T::Sig

    sig { returns(String) }
    attr_reader :name

    sig { params(name: String).void }
    def initialize(name:)
      @name = T.let(name, String)
    end
  end
end
