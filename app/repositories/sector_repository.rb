# typed: strict
class SectorRepository
  extend T::Sig

  sig { returns(T::Array[Responses::SectorResponseDto])}
  def index
    sectors = Sector.all.map { |sector| Responses::SectorResponseDto.new(sector.id, sector.name) }
    sectors
  end
end