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
    sectors = T.let(@index_service.call, T::Array[Responses::SectorResponseDto])

    render json: sectors, status: :ok
  end

  sig { void }
  def show
    sector = T.let(@show_service.call(id: params[:id]), Responses::SectorResponseDto)

    render json: sector, status: :ok
  end
end
