# typed: strict
class SectorRepository < Interfaces::RepositoryInterface
  extend T::Sig

  sig { void }
  def initialize
    @sectors_dtos = T.let([], T::Array[Responses::SectorResponseDto])
    initialize_sectors_dtos
  end

  sig { override.returns(T::Array[Responses::SectorResponseDto]) }
  def index
    @sectors_dtos
  end

  sig { override.params(id: Integer).returns(Responses::SectorResponseDto) }
  def show(id:)
    sector_dto = @sectors_dtos.find { |sector_dto| sector_dto.id == id }

    raise ActiveRecord::RecordNotFound, I18n.t(
      "activerecord.errors.messages.record_not_found",
      attribute: "Sector", key: "id", value: id
    ) if sector_dto.nil?

    sector_dto
  end

  sig { override.params(create_params: Requests::SectorRequestDto).returns(Responses::SectorResponseDto) }
  def create(create_params:)
    sector = build_sector(create_params: create_params)
    sector.save!

    sector_dto = generate_sector_dto(sector: sector)
    add_sector_dto_in_memory(sector_dto: sector_dto)

    sector_dto
  end

  sig { override.params(id: Integer, update_params: Requests::SectorRequestDto).returns(Responses::SectorResponseDto) }
  def update(id:, update_params:)
    show(id: id)

    sector = Sector.find(id)
    sector.update!(name: update_params.name)

    sector_dto = generate_sector_dto(sector: sector)
    update_sector_dto_in_memory(sector_dto_id: id, updated_sector_dto: sector_dto)

    sector_dto
  end

  sig { override.params(id: Integer).void }
  def destroy(id:)
    show(id: id)

    Sector.delete(id)

    destroy_sector_dto_in_memory(sector_dto_id: id)
  end

  private

  sig { returns(T::Array[Responses::SectorResponseDto]) }
  def initialize_sectors_dtos
    @sectors_dtos = Sector.order(:id).map { |sector| generate_sector_dto(sector: sector) }
  end

  sig { params(sector: Sector).returns(Responses::SectorResponseDto) }
  def generate_sector_dto(sector:)
    Responses::SectorResponseDto.new(id: sector.id, name: sector.name)
  end

  sig { params(sector_dto: Responses::SectorResponseDto).void }
  def add_sector_dto_in_memory(sector_dto:)
    @sectors_dtos << sector_dto
  end

  sig { params(sector_dto_id: Integer, updated_sector_dto: Responses::SectorResponseDto).void }
  def update_sector_dto_in_memory(sector_dto_id:, updated_sector_dto:)
    @sectors_dtos.map! { |sector_dto| sector_dto.id == sector_dto_id ? updated_sector_dto : sector_dto }
  end

  sig { params(sector_dto_id: Integer).void }
  def destroy_sector_dto_in_memory(sector_dto_id:)
    @sectors_dtos.reject! { |sector_dto| sector_dto.id == sector_dto_id }
  end

  sig { params(create_params: Requests::SectorRequestDto).returns(Sector) }
  def build_sector(create_params:)
    Sector.new(
      name: create_params.name
    )
  end
end
