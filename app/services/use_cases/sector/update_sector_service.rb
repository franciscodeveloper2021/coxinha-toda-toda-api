# typed: strict
module UseCases
  module Sector
    class UpdateSectorService
      extend T::Sig

      sig { params(sector_repository: SectorRepository).void }
      def initialize(sector_repository = SectorRepository.new)
        @repository = sector_repository
      end

      sig { params(id: Integer, update_params: Requests::SectorRequestDto).returns(Responses::SectorResponseDto) }
      def call(id:, update_params:)
        @repository.update(id: id, update_params: update_params)
      end
    end
  end
end
