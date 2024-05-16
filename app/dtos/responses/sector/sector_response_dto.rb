# typed:strict
class SectorResponseDTO
  extend T::Sig

  sig { returns(Integer) }
  attr_reader :id

  sig { returns(String) }
  attr_reader :name

  sig { params(id: Integer, name: String).void }
  def initialize(id, name)
    @id = T.let(id, Integer)
    @name = T.let(name, String)
  end
end
