class SectorsController < ApplicationController

  def index
    @sectors = Sector.all.map { |sector| Responses::SectorResponseDto.new(sector.id, sector.name) }

    render json: @sectors
  end
end
