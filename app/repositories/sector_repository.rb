# typed: strict
class SectorRepository
  extend T::Sig

  sig { void }
  def initialize
    @sectors = T.let(
      Sector.all.map { |sector| Responses::SectorResponseDto.new(T.must(sector.id), sector.name) },
      T::Array[Responses::SectorResponseDto]
    )
  end

  sig { returns(T::Array[Responses::SectorResponseDto])}
  def index
    @sectors
  end
end
