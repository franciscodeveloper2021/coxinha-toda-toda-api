# typed: strict
module UseCases
  module Sector
    class CreateSectorService
      extend T::Sig

      sig { params(sector_repository: SectorRepository).void }
      def initialize(sector_repository = SectorRepository.new)
        @repository = sector_repository
      end

      sig { params(create_params: Requests::SectorRequestDto).returns(Responses::SectorResponseDto) }
      def call(create_params:)
        @repository.create(create_params: create_params)
      end
    end
  end
end
