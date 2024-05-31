# typed: strict
class SectorRepository
  extend T::Sig

  sig { void }
  def initialize
    @sectors_dtos = T.let([], T::Array[Responses::SectorResponseDto])
    initialize_sectors_dtos
  end

  sig { returns(T::Array[Responses::SectorResponseDto]) }
  def index
    @sectors_dtos
  end

  sig { params(id: Integer).returns(Responses::SectorResponseDto) }
  def show(id:)
    sector_dto = @sectors_dtos.find { |dto| dto.id == id }

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

    sector_dto = Responses::SectorResponseDto.new(id: sector.id, name: sector.name)
    add_sector_dto_in_memory(sector_dto: sector_dto)

    sector_dto
  end

  sig { params(id: Integer, update_params: Requests::SectorRequestDto).returns(Responses::SectorResponseDto) }
  def update(id:, update_params:)
    sector_dto = show(id: id)

    sector = Sector.find(id)
    sector.update!(name: update_params.name)

    sector_dto = Responses::SectorResponseDto.new(id: sector.id, name: sector.name)
    update_sector_dto_in_memory(dto_id: id, updated_sector_dto: sector_dto)

    sector_dto
  end

  private

  sig { returns(T::Array[Responses::SectorResponseDto]) }
  def initialize_sectors_dtos
    @sectors_dtos = Sector.all.map { |sector| Responses::SectorResponseDto.new(id: T.must(sector.id), name: sector.name) }
  end

  sig { params(sector_dto: Responses::SectorResponseDto).void }
  def add_sector_dto_in_memory(sector_dto:)
    @sectors_dtos << sector_dto
  end

  sig { params(dto_id: Integer, updated_sector_dto: Responses::SectorResponseDto).void }
  def update_sector_dto_in_memory(dto_id:, updated_sector_dto:)
    @sectors_dtos.map! { |dto| dto.id == dto_id ? updated_sector_dto : dto }
  end
end
