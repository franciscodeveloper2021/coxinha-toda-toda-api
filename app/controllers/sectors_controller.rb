# typed: strict
class SectorsController < ApplicationController
  extend T::Sig

  sig { void }
  def initialize
    super()

    @index_service = T.let(UseCases::Sector::IndexSectorsService.new, UseCases::Sector::IndexSectorsService)
    @show_service = T.let(UseCases::Sector::ShowSectorService.new, UseCases::Sector::ShowSectorService)
    @create_service = T.let(UseCases::Sector::CreateSectorService.new, UseCases::Sector::CreateSectorService)
    @update_service = T.let(UseCases::Sector::UpdateSectorService.new, UseCases::Sector::UpdateSectorService)
    @destroy_service = T.let(UseCases::Sector::DestroySectorService.new, UseCases::Sector::DestroySectorService)
  end

  sig { void }
  def index
    sectors_dtos = T.let(@index_service.call, T::Array[Responses::SectorResponseDto])

    render json: sectors_dtos, status: :ok
  end

  sig { void }
  def show
    sector_dto = T.let(@show_service.call(id: params[:id].to_i), Responses::SectorResponseDto)

    render json: sector_dto, status: :ok
  end

  sig { void }
  def create
    sector_dto = T.let(@create_service.call(create_params: sector_params), Responses::SectorResponseDto)

    render json: sector_dto, status: :created
  end

  sig { void }
  def update
    sector_dto = T.let(@update_service.call(id: params[:id].to_i, update_params: sector_params), Responses::SectorResponseDto)

    render json: sector_dto, status: :ok
  end

  sig { void }
  def destroy
    @destroy_service.call(id: params[:id].to_i)

    render json: { message: I18n.t('messages.record_deleted', record: 'Sector') }, status: :ok
  end

  private

  sig { returns(Requests::SectorRequestDto) }
  def sector_params
    permitted_params = params.require(:sector).permit(:name)

    Requests::SectorRequestDto.new(
      name: permitted_params[:name]
    )
  end
end
