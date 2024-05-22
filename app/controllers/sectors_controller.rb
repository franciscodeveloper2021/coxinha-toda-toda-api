# typed: strict
class SectorsController < ApplicationController
  extend T::Sig

  sig { void }
  def initialize
    super()

    @index_service = T.let(UseCases::Sector::IndexSectorsService.new, UseCases::Sector::IndexSectorsService)
  end

  sig { void }
  def index
    sectors = T.let(@index_service.call, T::Array[Responses::SectorResponseDto])

    render json: sectors, status: :ok
  end
end
