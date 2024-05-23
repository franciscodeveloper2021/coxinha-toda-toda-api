# typed: strict
class SectorRepository
  extend T::Sig

  sig { void }
  def initialize
    @sectors_dtos = T.let(
      Sector.all.map { |sector| Responses::SectorResponseDto.new(id: T.must(sector.id), name: sector.name) },
      T::Array[Responses::SectorResponseDto]
    )
  end

  sig { returns(T::Array[Responses::SectorResponseDto]) }
  def index
    @sectors_dtos
  end

  sig { params(id: Integer).returns(Responses::SectorResponseDto) }
  def show(id:)
    sector_dto = @sectors_dtos.find { |sector| sector.id == id }

    raise ActiveRecord::RecordNotFound, I18n.t(
      "activerecord.errors.messages.record_not_found",
      attribute: "Sector", key: "id", value: id
    ) if sector_dto.nil?

    sector_dto
  end
end
