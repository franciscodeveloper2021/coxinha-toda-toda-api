# typed: strict
class SectorRepository
  extend T::Sig

  sig { void }
  def initialize
    @sectors = T.let(
      Sector.all.map { |sector| Responses::SectorResponseDto.new(id: T.must(sector.id), name: sector.name) },
      T::Array[Responses::SectorResponseDto]
    )
  end

  sig { returns(T::Array[Responses::SectorResponseDto]) }
  def index
    @sectors
  end
end
