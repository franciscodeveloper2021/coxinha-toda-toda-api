# typed: strict
class SectorsController < ApplicationController
  extend T::Sig

  sig { void }
  def initialize
    super()

    @index_service = T.let(UseCases::Sector::IndexSectorsService.new, UseCases::Sector::IndexSectorsService)
    @show_service = T.let(UseCases::Sector::ShowSectorService.new, UseCases::Sector::ShowSectorService)
  end

  sig { void }
  def index
    sectors_dtos = T.let(@index_service.call, T::Array[Responses::SectorResponseDto])

    render json: sectors_dtos, status: :ok
  end

  sig { void }
  def show(id: params[:id].to_i)
    sector_dto = T.let(@show_service.call(id: id), Responses::SectorResponseDto)

    render json: sector_dto, status: :ok
  end
end
