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

  sig { params(create_params: Requests::SectorRequestDto).returns(Responses::SectorResponseDto) }
  def create(create_params:)
    sector = Sector.new(name: create_params.name)

    sector.save!

    sector_dto = Responses::SectorResponseDto.new(id: T.must(sector.id), name: sector.name)
    @sectors_dtos << sector_dto

    sector_dto
  end

  sig { params(id: Integer, update_params: Requests::SectorRequestDto).returns(Responses::SectorResponseDto) }
  def update(id:, update_params:)
    sector_dto = show(id: id)

    sector = Sector.find(id)
    sector.update!(name: update_params.name)

    updated_sector_dto = Responses::SectorResponseDto.new(id: T.must(sector.id), name: sector.name)

    @sectors_dtos.map! { |sector_dto| sector_dto.id == id ? updated_sector_dto : sector_dto }

    updated_sector_dto
  end
end
